// Responsible for everything
#include "../global.h"
#include "backend.h"
#include <QDebug>
#include <list>
#include <QVector>
#include <QOpenGLFunctions>
#include <QOpenGLContext>
#include <QOffscreenSurface>
#include <QFile>
#include <QDir>

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QVariantMap>

#include "httplistener.h"
#include "httprequesthandler.h"

#include <QHostAddress>
#include <QNetworkInterface>

Backend backend;

QList<QString> themeNames;
QJsonDocument jsonDoc;

class globalSettings{
public:
    QString filename = "Config.json";
    QJsonValue width;
    QJsonValue height;
    QJsonValue defaultTheme;
    QJsonValue version;
    QJsonValue appName;
    QJsonValue website;
    QJsonValue windowTitle;
};

globalSettings settings;


QString selectedThemeName;

QString Backend::searchFile(QString fileName)
{
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
    m_Comport = new Comport(this);
    //console comport itd?
}

Backend::~Backend()
{
    close();
    qDebug("Backend: destroyed");
}

void Backend::setup(){
    qDebug() << "backend ready";
    m_Settings->LoadSettings(searchFile(SETTINGS_FILE));

    getJsonSettingsFile();
    setupJsonSettingsFile();
}
void Backend::handleQuit(){
    updateJsonSettingsFile();
    qDebug() << "quitting";
}

void Backend::close() {
    qDebug("Backend: closed");
    updateJsonSettingsFile();
    //clear data
}
//inital startup when everything completes loading
void Backend::startUp(){
    //scan for avaiable  serial ports
    console.log("info","m_Comport",tr("Reading available COM ports."));
    m_Comport->getAvailablePorts();
    emit appendPortsToComboBox();

    getAllThemes();

    // Search for webconfig.ini
    QString configFileName=searchFile("webconfig.ini");

    // Session store
    QSettings* sessionSettings = new QSettings(configFileName, QSettings::IniFormat, this);
    sessionSettings->beginGroup("sessions");
    sessionStore = new HttpSessionStore(sessionSettings, this);

    // Static file controller (index.html)
    QSettings* fileSettings = new QSettings(configFileName, QSettings::IniFormat, this);
    fileSettings->beginGroup("files");
    staticFileController = new StaticFileController(fileSettings, this);

    // HTTP Server
    QSettings* listenerSettings = new QSettings(configFileName, QSettings::IniFormat, this);
    listenerSettings->beginGroup("listener");
    HttpListener* httpListener = new HttpListener(listenerSettings, new Websocket(this), this);

    QString ipstr("");
    QList<QHostAddress> ips = QNetworkInterface::allAddresses();
    for (int i = 0; i < ips.size(); ++i)
    {
        if(ips[i].protocol() == QAbstractSocket::IPv4Protocol && ips[i] != QHostAddress::LocalHost)
        {
            ipstr += ips[i].toString();
        }
    }

    if(httpListener->isListening()){
        console.log("info","WebWidget",tr("Listening on: ")+ipstr+":"+QString::number(httpListener->serverPort()));
    }else{
        console.log("info","WebWidget",tr("Failed opening port :")+QString::number(httpListener->serverPort()));
    }

    QString versionString = QString::fromUtf8(getCuteNCVersion());

    //finished loading
    console.log("log","system",tr("Application ready. Running version ") + versionString);
}

//get installed widgets
void Backend::getWidgets(){

}
//set json app settings
void Backend::setupJsonSettingsFile(){
    //get the jsonObject
    QJsonObject jObject = jsonDoc.object();
    selectedThemeName = jObject["defaultTheme"].toString() + ".json";
    settings.defaultTheme = jObject["defaultTheme"].toString();
    settings.appName = jObject["appName"].toString();
    settings.windowTitle = jObject["windowTitle"].toString();
    settings.website = jObject["website"].toString();
    settings.version = jObject["version"].toString();
    settings.height = jObject["height"];
    settings.width = jObject["width"];
    qDebug() << selectedThemeName;
    qDebug() << settings.defaultTheme;
    qDebug() << settings.appName;

    qDebug() << settings.windowTitle;
    qDebug() << settings.website;
    qDebug() << settings.version;

    qDebug() << settings.height;
    qDebug() << settings.width;
}
//get json app settings
void Backend::getJsonSettingsFile(){
    QString path = "../json/";
    QString fullpath = path+settings.filename;
    QFile file;
    QString result;
    QDir dir;

    if(!dir.exists(fullpath)){
        updateJsonSettingsFile();
    }

    file.setFileName(fullpath);

    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "failed to open file" << file.fileName() << file.errorString() << file.error();
        qDebug() << fullpath;
    }else{
        qDebug() << "Success reading json config file";
        QTextStream file_text(&file);
        result = file.readAll();
        qDebug() << "result : " << result;
        file.close();
    }
    jsonDoc = QJsonDocument::fromJson(result.toUtf8());
}
//update json app settings
void Backend::updateJsonSettingsFile(){
    QString path = "../json/";
    QString fullpath = path+settings.filename;
    QJsonObject jObject = jsonDoc.object();
    QDir dir;

    if(!dir.exists(path)){
        dir.mkpath(path);
    }else{

        if(!dir.exists(fullpath)){
            QFile file(fullpath);
            if(!file.open(QIODevice::ReadWrite)) {
                qDebug() << "failed creating file" << file.fileName() << file.errorString() << file.error();
            } else {
                qDebug() <<"file created! "+fullpath;

                QJsonObject obj;
                obj.insert("appName","CuteNC");
                obj.insert("title","");
                obj.insert("website","feew.dev");
                obj.insert("version","v0.1.0");
                obj.insert("height",800);
                obj.insert("width",1200);
                obj.insert("defaultTheme","LightTheme");
                QJsonDocument jsonDoc;
                jsonDoc.setObject(obj);
                file.write(jsonDoc.toJson());
                file.close();
                qDebug() << jsonDoc;
            }

        }else{
            QFile file(fullpath);
            if(!file.open(QIODevice::ReadWrite)) {
                qDebug() << "failed to open file" << file.fileName() << file.errorString() << file.error();
            } else {
                qDebug() <<"saving "+fullpath;

                // Clear the original content in the file
                file.resize(0);

                QJsonObject obj;
                obj.insert("appName",settings.appName);
                obj.insert("title",settings.windowTitle);
                obj.insert("website",settings.website);
                obj.insert("version",settings.version);
                obj.insert("height",settings.height);
                obj.insert("width",settings.width);
                obj.insert("defaultTheme",settings.defaultTheme);
                QJsonDocument jsonDoc;
                jsonDoc.setObject(obj);

                qDebug() <<jsonDoc;

                file.write(jsonDoc.toJson());
                file.close();
            }
        }
    }
}
void Backend::debug(){
    qDebug() << "backend debug";
    emit debugSignal("debug Signal from QML");
}

void Backend::commandReceived(QString command){
    //debug messages
    if(command == "debug()"){
        debug();
        qDebug() << "commandReceived(): " << command;
    }

    else if(command == "test1"){
        console.log("warn","system debug","test message");
    }

    else if(command == "test10"){
        for(int i = 1; i <= 10 ; i++){
            QString temp = QString::number(i);
            console.log("warn","system debug","test message " + temp);
        }
    }
    else if(command == "test100"){
        for(int i = 1; i <= 100 ; i++){
            QString temp = QString::number(i);
            console.log("warn","system debug","test message " + temp);
        }
    }

    else if(command == ""){
        console.log("warn","system debug","Error - empty command received!");
    }

    else if(command == "sys_colors"){
        console.log("info","system","green","greenedOut");
        console.log("info","system","gray","greyedOut");
        console.log("info","system","red","rededOut");

        console.log("error","system","error");
        console.log("warn","system","warn");
        console.log("info","system","info");
        console.log("log","system","log");
        console.log("default","system","debug");
    }

    else if(command == "cp_info"){
        if(m_Comport->connectedPortName == "dummy"){
            console.log("info","m_Comport","Connected to dummy, serial port details not avaiable");

        }else{
            if(m_Comport->connected){
                m_Comport->portInfo();
            }else{
                console.log("info","m_Comport","Serial port details not avaiable");
            }

        }
    }

    else if(command == "cp_debug"){
        qDebug() << command;
        m_Comport->debug();
        console.debug();
    }

    else{
        if(!command.isNull()){
            for(int i = 0; i < command.length(); i++){
                QString temp = command.at(i);
                QByteArray arr;
                arr.append(temp.toLocal8Bit());
                emit m_Comport->receivedCommand(arr);
            }
            console.log("info","console",command);
            emit m_Comport->receivedCommand("\r");
        }
    }
}

//send file contents to QML - applying style
QString Backend::getJsonFile(QString fileName){
    if(fileName != ".json"){

        QString binDir = QCoreApplication::applicationDirPath();
        QStringList searchList;
        QStringList searchListSubFolders;

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
    settings.defaultTheme = themeName;

    emit refreshWidgets();
}
QString Backend::getSelectedTheme(){
    return selectedThemeName;
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
    emit getThemes();
}
QString Backend::getThemeName(int position){
    return themeNames.at(position);
}
int Backend::numberOfThemes(){
    return themeNames.size();
}

void Backend::refreshWidgetsInvoker(){
    emit refreshWidgets();
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
