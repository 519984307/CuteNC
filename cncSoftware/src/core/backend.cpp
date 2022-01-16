#include "backend.h"
#include "settings.h"

Settings *m_Settings;
using namespace CuteNC;

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

    connect(this->m_Comport, SIGNAL(signal_ReadyForNextCommand()), this->m_AxisController, SLOT(sendNextCommand()));
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

void Backend::axisController_SendNextCommand(){
    this->m_AxisController->sendNextCommand();
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
    this->httpListener = new HttpListener(listenerSettings, new Websocket(this), this);

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
    QString formattedFilePath = filePath.remove(0,8);

    QFile file(filePath);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QString result = file.readAll();
        file.close();
        qDebug() << "opening file" << filePath;
        emit signal_OpenFile(result);
    }
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

    this->fileContents = "";
}

void Backend::commandReceived(QString command){
    //debug messages
    if(command == "debug()"){
        debug();
        qDebug() << "commandReceived(): " << command;
    }

    else if(command == "test1"){
        m_Console->log("warn","system debug","test message");
    }

    else if(command == "test10"){
        for(int i = 1; i <= 10 ; i++){
            QString temp = QString::number(i);
            m_Console->log("warn","system debug","test message " + temp);
        }
    }
    else if(command == "test100"){
        for(int i = 1; i <= 100 ; i++){
            QString temp = QString::number(i);
            m_Console->log("warn","system debug","test message " + temp);
        }
    }

    else if(command == ""){
        m_Console->log("warn","system debug","Error - empty command received!");
    }

    else if(command == "sys_colors"){
        m_Console->log("info","system","green","greenedOut");
        m_Console->log("info","system","gray","greyedOut");
        m_Console->log("info","system","red","rededOut");

        m_Console->log("error","system","error");
        m_Console->log("warn","system","warn");
        m_Console->log("info","system","info");
        m_Console->log("log","system","log");
        m_Console->log("default","system","debug");
    }

    else if(command == "cp_info"){
        if(m_Comport->connectedPortName == "dummy"){
            m_Console->log("info","m_Comport","Connected to dummy, serial port details not avaiable");

        }else{
            if(m_Comport->connected){
                m_Comport->portInfo();
            }else{
                m_Console->log("info","m_Comport","Serial port details not avaiable");
            }

        }
    }

    else if(command == "cp_debug"){
        qDebug() << command;
        m_Comport->debug();
        //m_Console->debug();
    }

    else{
        if(!command.isNull()){
            for(int i = 0; i < command.length(); i++){
                QString temp = command.at(i);
                QByteArray arr;
                arr.append(temp.toLocal8Bit());
                emit m_Comport->receivedCommand(arr);
            }
            m_Console->log("info","console",command);
            emit m_Comport->receivedCommand("\r");
        }
    }
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



//Getting and setting a color theme
void Backend::setTheme(QString themeName){
    selectedThemeName = themeName+".json";
    emit signal_RefreshWidgets();
}
QString Backend::getSelectedTheme() const{
    return m_Settings->getThemeName();
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

void Backend::refreshWidgetsInvoker(){
    emit signal_RefreshWidgets();
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
