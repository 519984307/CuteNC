#include "json.h"
#include <QDebug>

#include <QFile>
#include <QDir>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>

using namespace cutenc;

Json::Json(QObject *parent)
{

}

Json::~Json()
{
    qDebug("Json: destroyed");
}

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


void Json::createMacro(QString macroName,const QList<QString> &data){
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

            QJsonArray array;
            for(int i = 0 ; i < data.length(); i++){
                QJsonObject line;
                QString l = QString::number(i+1);

                linesObj.insert(l,data[i]);

                //line.insert(l,data[i]);
                //array.append(line);
            }

            //obj["lines"] = array;
            obj["lines"] = linesObj;

            jsonDoc.setObject(obj);
            file.write(jsonDoc.toJson());
            file.close();

            qDebug() << "============ Json: new macro ============";
            qDebug() << jsonDoc;
            qDebug() << "=========================================";

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

}
