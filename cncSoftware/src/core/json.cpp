#include "json.h"
#include <QDebug>

#include <QFile>
#include <QDir>
#include <QJsonObject>
#include <QJsonDocument>


class GCodeMacro{
public:
    QString filename;
    QJsonValue width;
    QJsonValue height;
    QJsonValue defaultTheme;
    QJsonValue version;
    QJsonValue appName;
    QJsonValue website;
    QJsonValue windowTitle;
};

void Json::createMacro(QString macroName){
    QString path = "../json/Macros/";
    QString fullpath = path+macroName+".json";
    QFile file;
    QString result;
    QDir dir;

    if(!dir.exists(path)){
        //create directory Macros
        dir.mkpath(path);
    }

    if(!dir.exists(fullpath)){
       updateMacro(macroName);
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

}
void Json::updateMacro(QString macroName){
    QJsonDocument jsonDoc;

    QString path = "../json/";
    QString fullpath = path+macroName+".json";
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
                qDebug() <<"creating new macro "+fullpath;

                QJsonObject obj;
                QJsonDocument jsonDoc;




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
                updateMacro(macroName);
            }
        }
    }
}
