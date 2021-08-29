// Responsible for everything
#include "global.h"
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
QString selectedThemeName;
QJsonDocument jsonDoc;

Backend::Backend(QObject *parent) : QObject(parent){

}
void Backend::setup(){
    qDebug() << "backend ready";
    getJsonSettingsFile();
    setupJsonSettingsFile();
}

//inital startup when everything completes loading
void Backend::startUp(){

    //initial command
    console.log("log","system","Application ready.");

    //get OpenGl details

    //scan for avaiable  serial ports
    console.log("info","comport","Reading available COM ports.");
    comport.scanPorts();
    emit appendPortsToComboBox();


    //websocket
    websocket.websocketSetup();

    getAllThemes();
}

//set json app settings
void Backend::setupJsonSettingsFile(){
    //get the jsonObject
      QJsonObject jObject = jsonDoc.object();
      selectedThemeName = jObject["defaultTheme"].toString();
      qDebug() << jObject["appName"].toString();
      qDebug() << selectedThemeName;
}
//get json app settings
void Backend::getJsonSettingsFile(){
    QString path = "../json/GlobalSettings.json";
    QFile file;
    QString result;

    file.setFileName(path);

    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << file.fileName();
        qDebug() << "failed to open file" << file.errorString() << file.error();
    }else{
        QTextStream file_text(&file);
        result = file.readAll();
        file.close();
    }
    jsonDoc = QJsonDocument::fromJson(result.toUtf8());
}
//update json app settings
void Backend::updateJsonSettingsFile(){
    QString path = "../json/GlobalSettings.json";
    QFile file;
    QJsonObject jObject = jsonDoc.object();


    file.write(jsonDoc.toJson());
    file.close();
    qDebug() << "Write to file";

}
void Backend::debug(){
    qDebug() << "backend debug";
    emit debugSingal("debug Signal from QML");
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
    selectedThemeName = themeName;
    emit refreshWidgets();
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
