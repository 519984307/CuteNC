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

Backend::Backend(QObject *parent) : QObject(parent){

}


void Backend::setup(){
    qDebug() << "backend ready";
    getJsonSettingsFile();
    setupJsonSettingsFile();
}
void Backend::handleQuit(){
    updateJsonSettingsFile();
    qDebug() << "quitting";
}
//inital startup when everything completes loading
void Backend::startUp(){


    //get OpenGl details

    //scan for avaiable  serial ports
    console.log("info","comport","Reading available COM ports.");
    comport.scanPorts();
    emit appendPortsToComboBox();

    getAllThemes();

    //initial command
    console.log("log","system","Application ready.");
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
        QTextStream file_text(&file);
        result = file.readAll();
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
        if(comport.connectedPortName == "dummy"){
            console.log("info","comport","Connected to dummy, serial port details not avaiable");
        }else{
            if(comport.connected){
                comport.portInfo();
            }else{
                console.log("info","comport","Serial port details not avaiable");
            }

        }
    }

    else if(command == "cp_debug"){
        qDebug() << command;
        comport.debug();
    }

    else{
        if(!command.isNull()){
            for(int i = 0; i < command.length(); i++){
                QString temp = command.at(i);
                QByteArray arr;
                arr.append(temp.toLocal8Bit());
                emit comport.receivedCommand(arr);
            }
            console.log("info","console",command);
            emit comport.receivedCommand("\r");
        }
    }
}

//send file contents to QML - applying style
QString Backend::getJSONFile(QString path, QString filename){
    QString defaultPath = "../json/";
    if(path == ""){
        path = defaultPath;
    }
    QFile file;
    QString result;
    QString rootPath = QDir::currentPath();

    file.setFileName(path+filename);

    if(!file.open(QIODevice::ReadOnly)){
        qDebug() << file.fileName();
        qDebug() << "failed to open file" << file.errorString() << file.error();
    }else{
        QTextStream file_text(&file);
        result = file.readAll();
        file.close();
    }
    return result;
}



//Getting and setting a color theme
void Backend::setTheme(QString themeName){
    selectedThemeName = themeName+".json";
    settings.defaultTheme = themeName;
    qDebug() << settings.defaultTheme;
    emit refreshWidgets();
}
QString Backend::getSelectedTheme(){
    return selectedThemeName;
}

void Backend::getAllThemes(){
    QDir directory("../JSON/Themes");
    QStringList themes = directory.entryList(QStringList()<<"*.json",QDir::Files);
    foreach(QString filename, themes){
        themeNames.append(filename);
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
