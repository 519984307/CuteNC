#include "fileparser.h"
#include "../global.h"

#include <QDebug>
#include <QFile>
#include <QDir>
#include <QJsonObject>
#include <QJsonDocument>

FileParser fileparser;

FileParser::FileParser(QObject *parent) : QObject(parent){
    qDebug() << "fileparser ready";
    createNecessaryFiles();
}
void FileParser::createNecessaryFiles(){
    qDebug() << "Creating files";
}
QString FileParser::getFileRawContent(QString path, QString filename){
    QString defaultPath = "../json/";
    if(path == ""){
        path = defaultPath;
    }
    QFile file;
    QString result;
    QString rootPath = QDir::currentPath();

    file.setFileName(path+filename);

    if(!file.open(QIODevice::ReadOnly)){
        qDebug() << "failed to open file" << file.fileName() << file.errorString() << file.error();
    }else{
        QTextStream file_text(&file);
        result = file.readAll();
        file.close();
    }
    return result;
}
void FileParser::loadWidgets(){

}
