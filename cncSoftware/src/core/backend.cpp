#include "backend.h"
#include "settings.h"

using namespace CuteNC;
Settings *m_Settings;

QString Backend::getFilePath(QString fileName) const{
    QString binDir = QCoreApplication::applicationDirPath();

    QStringList searchList;
    searchList.append(binDir);
    searchList.append(binDir+"/data");
    searchList.append(binDir+"/../data");
    searchList.append(binDir+"/../cncSoftware/data"); // for development with shadow build (Linux)
    searchList.append(binDir+"/../../cncSoftware/data"); // for development with shadow build (Windows)
    searchList.append(QDir::rootPath()+"data/opt");
    searchList.append(QDir::rootPath()+"data");

    qDebug() << "Root path: " << QDir::rootPath();
    qDebug() << "Dir path: " << binDir;
    foreach (QString dir, searchList)
    {
        QFile file(dir+"/"+fileName);
        if (file.exists())
        {
            fileName=QDir(file.fileName()).canonicalPath();
            qDebug("Using config file %s",qPrintable(fileName));
            return fileName;
        }
    }

    // not found
    foreach (QString dir, searchList)
    {
        qWarning("%s/%s not found",qPrintable(dir),qPrintable(fileName));
    }
    qFatal("Cannot find config file %s",qPrintable(fileName));
    return nullptr;
}

Backend::Backend(QObject *parent) : QObject(parent){
    m_Settings = new Settings(this);

    this->m_AxisController = new AxisController(this);
    this->m_Console = new Console(this,this->m_AxisController);
    this->m_Comport = new Comport(this,this->m_Console);

    connect(this->m_Comport,SIGNAL(signal_DisconnectedFromSerialPort()),this->m_AxisController,SLOT(setZeros()));
    connect(this->m_Console,SIGNAL(signal_StartGcode()),this,SLOT(startParsingFile()));
    connect(this->m_Comport,SIGNAL(signal_ReceivedOk()),this,SLOT(incrementOkCount()));
}

Backend::~Backend()
{
    //m_Settings->~Settings();
    close();
    qDebug("Backend: destroyed");
}

void Backend::close() {
    qDebug("Backend: closed");
    //clear data
}

void Backend::setup(){
    emit signal_LoadSettings();
    getAllThemes();
    qDebug() << "backend ready";


}
void Backend::handleQuit(){
    emit signal_SaveSettings();
}


QString Backend::getSettingsFilePath() const{
    return getFilePath(SETTINGS_FILE);
}

//inital startup when everything completes loading
void Backend::startUp(){
    this->m_Comport->startUp();
    this->m_AxisController->startUp();

    // Search for webconfig.ini
    QString configFileName=getFilePath("webconfig.ini");

    // Session store
    QSettings* sessionSettings = new QSettings(configFileName, QSettings::IniFormat, this);
    sessionSettings->beginGroup("sessions");
    sessionStore = new HttpSessionStore(sessionSettings, this);

    // Static file controller
    QSettings* fileSettings = new QSettings(configFileName, QSettings::IniFormat, this);
    fileSettings->beginGroup("files");
    staticFileController = new StaticFileController(fileSettings, this);

    // HTTP Server
    QSettings* listenerSettings = new QSettings(configFileName, QSettings::IniFormat, this);
    listenerSettings->beginGroup("listener");
    this->httpListener = new HttpListener(listenerSettings, new Websocket(this,this->m_AxisController), this);
    //connect(this->httpListener,SIGNAL(signal_RequestCommand(QString)),this,SLOT(commandReceived(QString)));

    emit signal_Ready();
    emit signal_RefreshWidgets();

    //from now on GUI is ready and visible to user.

    QString ipstr("");
    QList<QHostAddress> ips = QNetworkInterface::allAddresses();
    for (int i = 0; i < ips.size(); ++i)
    {
        if(ips[i].protocol() == QAbstractSocket::IPv4Protocol && ips[i] != QHostAddress::LocalHost)
        {
            ipstr += ips[i].toString();
        }
    }

    if(this->httpListener->isListening()){
        m_Console->log("info","WebWidget",tr("Listening on: ")+ipstr+":"+QString::number(this->httpListener->serverPort()));
    }else{
        m_Console->log("warn","WebWidget",tr("Failed opening port :")+QString::number(this->httpListener->serverPort()));
    }

    QString versionString = QString::fromUtf8(getCuteNCVersion());

    //finished loading
    m_Console->log("info","Application",tr("Application ready. Running version ") + versionString);
}

void Backend::debug(){
    qDebug() << "backend debug";
    emit debugSignal("debug Signal from QML");
}

void Backend::openFile(QString filePath){
    //remove file:///
    loadedFile = "";
    QString formattedFilePath = filePath.remove(0,8);

    QFile file(filePath);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QString result = file.readAll();
        file.close();
        loadedFile = result;
        emit signal_OpenFile(result);
        emit signal_DrawFromFile(result);
    }
}
QString Backend::getGcodeFile(){
    return loadedFile;
}
void Backend::setupFile(QString fileContent){
    loadedFile = "";
    loadedFile = fileContent;
}


int currentSegment = 0;
int currentCommand = 0;
int currentSegmentLength = 0;
QList<QStringList> gcodeSegments;

void Backend::setToReadyState(){
    //m_Console->log("error","Application",tr("Emergency stop"));
    //this->showNotification("info",tr("Reconnecting..."));
    //m_Comport->reconnect();

    //this->showNotification("warning",tr("Detected emergency stop!"));
    emit signal_DoneRunningProgram();
    currentSegment = 0;
    currentCommand = 0;
    currentSegmentLength = 0;
    this->okCount = 0;
    gcodeSegments.clear();
    this->groupedFile.clear();
    this->m_Console->isRunning = false;
    this->m_AxisController->totalTime = 0;
    //qDebug() << "done";
}

//E stop
void Backend::emergencyStop(){
    m_Console->log("error","Application",tr("Emergency stop"));
    this->showNotification("info",tr("Reconnecting..."));
    m_Comport->reconnect();

    this->showNotification("warning",tr("Detected emergency stop!"));

    this->setToReadyState();
    qDebug() << "done";
}

//divide file into groups (10 commands per group)
void Backend::startParsingFile(){
    qDebug() << "parsing file";
    this->groupedFile.clear();
    currentSegment = 0;
    currentCommand = 0;
    currentSegmentLength = 0;
    gcodeSegments.clear();
    this->okCount = 0;
    this->m_Console->isRunning = true;

    QStringList commands = this->loadedFile.split('\n');

    if(commands.length() == 0){
        this->setToReadyState();
    }

    foreach(QString command, commands){
        QString formattedCmd = command.mid(0, command.indexOf(";"));
        if(formattedCmd != "" && formattedCmd != " "){
            if(formattedCmd[0] == "G" || formattedCmd[0] == "T" || formattedCmd[0] == "M" || formattedCmd[0] == "N"){
                   this->groupedFile.append(formattedCmd);
            }
        }
    }


    int groups = this->groupedFile.length();
    this->currentGroup = 0;
    int groupsNeeded = groups/10;

    if(groups == 0){
        this->setToReadyState();
    }


    for(int j = 1; j <= groupsNeeded; j++){
        QStringList ten;

        for(int i = 0; i < 10; i++){
            if(i == 0){
                ten.append(this->groupedFile.at(0));
            }else{
                ten.append(this->groupedFile.at(i*j));
            }

        }

        gcodeSegments.append(ten);
        qDebug() << ten;
    }

    int groupsRest = groups - (groupsNeeded*10);



    QStringList restTen;
    for(int k = groupsRest; k > 0; k--){
        restTen.append(this->groupedFile.at(groups-k));
    }
    gcodeSegments.append(restTen);
    qDebug() << restTen;

    m_Console->log("info","Application",tr("Number of lines ")+""+ QString::number(groups));
   // m_Console->log("info","Application","Number of groupsNeeded " + QString::number(groupsNeeded));
   // m_Console->log("info","Application","Number of groupsRest " + QString::number(groupsRest));

    this->sendNextSegment();
}


void Backend::incrementOkCount(){
    qDebug() << currentSegmentLength << " currentSegmentLength";
    qDebug() << this->okCount << " this->okCount";
    this->okCount++;
    if(this->okCount == currentSegmentLength){
        if(currentSegmentLength < 10){
           this->sendNextSegment(true);
        }else{
           this->sendNextSegment();
        }
    }
}

void Backend::sendNextSegment(bool done){
    if(done){
        int time = m_AxisController->totalTime;

        int hours=(int)(time/3600);
        int minutes=((int)(time/60))%60;
        int seconds=(int)(time%60);

        QString tookTotalTime = QString::number(round(hours))+"h "+QString::number(round(minutes))+"m "+QString::number(round(seconds))+"s ";
        m_Console->log("info","Application",tr("Done, took:") +" "+tookTotalTime);
        this->showNotification("success",tr("Done executing g-code"));
        this->setToReadyState();
        return;
    }

    currentCommand = 0;
    QStringList segmentToSend = gcodeSegments.at(currentSegment);


    currentSegmentLength = gcodeSegments.at(currentSegment).length();

    foreach(QString command, segmentToSend){
        commandReceived(command,"G-code");
        currentCommand++;
    }

    this->okCount = 0;
    currentSegment++;
}

void Backend::getFileToBeSavedContents(QString contents){
    this->fileContents = contents;
}
void Backend::saveFile(QString filePath){
    //remove file:///

    emit signal_SaveFile();

    QString formattedFilePath = filePath.remove(0,8);

    QFile file(formattedFilePath);
    file.setPermissions(QFileDevice::ReadOwner | QFileDevice::WriteOwner);

    if(file.open(QIODevice::WriteOnly|QIODevice::Text))
    {
        qDebug() << "success";
    }
    else
    {
        qDebug() << "Fail";
    }
    file.close();

    if(file.exists())
    {
        file.open(QIODevice::ReadWrite);
        QByteArray fileContents = this->fileContents.toUtf8();
        file.resize(0);
        file.write(fileContents);
        file.close();
    }
}

void Backend::commandReceived(QString command,QString source){
    //debug messages  
    if(command == "app_info"){

        QString versionString = QString::fromUtf8(getCuteNCVersion());

        //finished loading
        m_Console->log("info","Application",tr("Running version ") + versionString);
    }

    else if(command == "web_info"){
        QString ipstr("");
        QList<QHostAddress> ips = QNetworkInterface::allAddresses();
        for (int i = 0; i < ips.size(); ++i)
        {
            if(ips[i].protocol() == QAbstractSocket::IPv4Protocol && ips[i] != QHostAddress::LocalHost)
            {
                ipstr += ips[i].toString();
            }
        }
        if(this->httpListener->isListening()){
            m_Console->log("info","WebWidget",tr("Running on: ")+ipstr+":"+QString::number(this->httpListener->serverPort()));
        }else{
            m_Console->log("warn","WebWidget",tr("Failed opening port :")+QString::number(this->httpListener->serverPort()));
        }
    }

    else if(command == "cmd_test"){
        m_Console->log("warn","Debug","Test");
        showNotification("default","Test");
    }

    else if(command == ""){
        m_Console->log("warn","Application","Empty command received!");
    }
    else if(command == "cp_reconnect"){
        m_Comport->reconnect();
    }
    else if(command == "cp_disconnect"){
        m_Comport->closeSerialPort();
    }
    else if(command == "cp_info"){
        if(m_Comport->connectedPortName == "dummy"){
            m_Console->log("info","SerialPort","Connected to dummy, serial port details not avaiable");

        }else{
            if(m_Comport->connected){
                m_Comport->portInfo();
            }else{
                m_Console->log("info","SerialPort","Serial port details not avaiable");
                showNotification("warn","Connect to a device first!");
            }

        }
    }
    else if(command == "cp_debug"){
        m_Comport->debug();
    }
    else if(command == "cs_debug"){
        m_Console->debug();
    }

    else{
        if(!command.isNull()){
            if(m_Comport->connected){
                QByteArray arr;
                for(int i = 0; i < command.length(); i++){
                    QString temp = command.at(i);
                    arr.append(temp.toLocal8Bit());
                }
                emit m_Comport->receivedCommand(arr);
                emit m_Comport->receivedCommand("\r");

                m_Console->log("log",source,command);
            }else{
                showNotification("warn","Connect to a device first!");
            }
        }
    }
}
void Backend::createMacro(QString macroName, QList<QString> data){
    QString path = "../json/Macros/";
    QDir dir;

    if(macroName == " " || macroName == ""){
        macroName = "Untitled";
    }

    QString fullpath = path+macroName+".json";

    if(!dir.exists(path)){
        dir.mkpath(path);
    }

    if(!dir.exists(fullpath)){
        QFile file(fullpath);
        if(!file.open(QIODevice::ReadWrite)) {
            qDebug() << "failed creating file" << file.fileName() << file.errorString() << file.error();
        } else {
            qDebug() <<"creating new macro "+fullpath;

            QJsonObject obj;
            QJsonObject linesObj;
            QJsonDocument jsonDoc;

            obj.insert("macro",macroName);
            obj.insert("icon","");
            obj.insert("shortcut","");
            QJsonArray array;
            for(int i = 0 ; i < data.length(); i++){
                QJsonObject line;
                QString l = QString::number(i+1);
                linesObj.insert(l,data[i]);
            }

            obj["lines"] = linesObj;
            jsonDoc.setObject(obj);
            file.write(jsonDoc.toJson());
            file.close();
        }

    }else{
        QFile file(fullpath);
        if(!file.open(QIODevice::ReadWrite)) {
            qDebug() << "failed to open file" << file.fileName() << file.errorString() << file.error();
        } else {

            qDebug() <<"deleting existing macro "+fullpath;
            file.remove();

            createMacro(macroName, data);
        }
    }

    emit signal_ReloadMacros();
}
//send file contents to QML - applying style
QString Backend::getJsonFile(QString fileName){
    if(fileName != ".json" && fileName.length() > 2){

        QString binDir = QCoreApplication::applicationDirPath();
        QStringList searchList;
        QStringList searchListSubFolders;

        searchList.append(binDir);
        searchList.append(binDir+"/data");
        searchList.append(binDir+"/../data");
        searchList.append(binDir+"/../data/webserver");
        searchList.append(binDir+"/../data/webserver/assets");
        searchList.append(binDir+"/../cncSoftware/data"); // for development with shadow build (Linux)
        searchList.append(binDir+"/../../cncSoftware/data"); // for development with shadow build (Windows)
        searchList.append(QDir::rootPath()+"data/opt");
        searchList.append(QDir::rootPath()+"data");

        //root
        searchList.append("..");
        searchList.append("/json");
        searchList.append("../json");
        searchList.append("../CuteNC/json"); // for development with shadow build (Linux)
        searchList.append("../../CuteNC/json"); // for development with shadow build (Windows)


        //subfolders
        searchListSubFolders.append("");
        searchListSubFolders.append("/themes");
        searchListSubFolders.append("/components");
        searchListSubFolders.append("/macros");
        searchListSubFolders.append("/settings");
        searchListSubFolders.append("/widgets");

        foreach (QString dir, searchList)
        {
            foreach(QString folder, searchListSubFolders){
                QFile file(dir+folder+"/"+fileName);
                if (file.open(QIODevice::ReadOnly | QIODevice::Text))
                {
                    QString result = file.readAll();
                    file.close();
                    return result;
                }
            }
        }

        // not found
        foreach (QString dir, searchList)
        {
            qWarning("%s/%s not found",qPrintable(dir),qPrintable(fileName));
        }
        qFatal("Cannot find .json file %s",qPrintable(fileName));
        return nullptr;
    }
    return nullptr;
}
//get macro files as paths
QStringList Backend::getMacros(){
    QStringList macros;
    QStringList directories;

    directories.append("/json/Macros/");
    directories.append("../json/Macros/");
    directories.append("../CuteNC/json/Macros/"); // for development with shadow build (Linux)
    directories.append("../../CuteNC/json/Macros/"); // for development with shadow build (Windows)
    directories.append("../../../CuteNC/json/Macros/");
    QStringList themes;
    foreach(QString dir, directories){
        themes.clear();
        QDir directory = dir;

        themes = directory.entryList(QStringList()<<"*.json",QDir::Files);

        //found themes
        if(!themes.empty()){
            break;
        }
    }
    foreach(QString tName, themes){
        qDebug() << "Found file: " << tName;
        macros.append(tName);
    }

    return macros;
}

void Backend::getAllThemes(){
    QStringList directories;

    directories.append("/json/themes/");
    directories.append("../json/themes/");
    directories.append("../CuteNC/json/themes/"); // for development with shadow build (Linux)
    directories.append("../../CuteNC/json/themes/"); // for development with shadow build (Windows)
    directories.append("../../../CuteNC/json/themes/");
    QStringList themes;
    foreach(QString dir, directories){
        themes.clear();
        QDir directory = dir;

        themes = directory.entryList(QStringList()<<"*.json",QDir::Files);

        //found themes
        if(!themes.empty()){
            break;
        }
    }
    foreach(QString tName, themes){
        qDebug() << "Found theme: " << tName;
        themeNames.append(tName);
    }
    emit signal_GetThemes();
    emit signal_RefreshWidgets();
}

QString Backend::getThemeName(int position){
    return themeNames.at(position);
}
int Backend::numberOfThemes(){
    return themeNames.size();
}

//Determine which font color (black or white) is better with given color(ex. background color) QString
//returns true if white, false if black is better
bool Backend::determineFontColor(QString color){
    int threshold = 149; //186
    QChar colorArray[color.length()];
    QString sRed,sGreen,sBlue;
    double r,g,b;
    bool ok;

    for(int i = 0; i < color.length(); i++){
        colorArray[i] = color.at(i);
    }

    sRed = colorArray[1];
    sRed += colorArray[2];
    sGreen = colorArray[3];
    sGreen += colorArray[4];
    sBlue = colorArray[5];
    sBlue += colorArray[6];

    r = static_cast<double>(sRed.toInt(&ok, 16));
    g = static_cast<double>(sGreen.toInt(&ok, 16));
    b = static_cast<double>(sBlue.toInt(&ok, 16));


    if(((r*0.299 + g*0.587 + b*0.114) > threshold)){
        return 0;
    }else{
        return 1;
    }
}

//Getting and setting a color theme
void Backend::setTheme(QString themeName){
    m_Settings->setThemeName(themeName);
    selectedThemeName = themeName+".json";
    emit signal_RefreshWidgets();
}
QString Backend::getSelectedTheme() const{
    return m_Settings->getThemeName();
}

//Getting and setting units
void Backend::setUnits(bool units){
    m_Settings->setUnits(units);
    emit signal_RefreshWidgets();
}
bool Backend::getSelectedUnits() const{
    return m_Settings->getUnits();
}

//Getting and setting language
void Backend::setLanguage(QString lang){
    m_Settings->setLanguage(lang);
    emit signal_RefreshWidgets();
}
QString Backend::getSelectedLanguage() const{
    return m_Settings->getLanguage();
}
