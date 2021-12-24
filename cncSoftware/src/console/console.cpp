#include "console.h"
#include <QTime>
#include <QDate>
#include <QDebug>
#include <QList>
#include <QTimer>
#include "../global.h"

Console console;
int maxMessages = 10;
struct msg{
    QString type;
    QString time;
    QString source;
    QString message;
    QString textColor;

    void newMessage(QString mType, QString mTime, QString mSource, QString mMsg, QString mTextColor){
        this->type = mType;
        this->time = mTime;
        this->source = mSource;
        this->message = mMsg;
        this->textColor = mTextColor;
    }
};

QList<msg> messagesInConsole;

Console::Console(QObject *parent) : QObject(parent)
{

}


void Console::displayEachSecond(){
    QTimer* timer = new QTimer();
    timer->setInterval(1000); //Time in milliseconds
    //timer->setSingleShot(false); //Setting this to true makes the timer run only once
    connect(timer, &QTimer::timeout, this, [=](){
        //Do your stuff in here, gets called every interval time
        log("info","system","second");
    });
    timer->start(); //Call start() AFTER connect
    //Do not call start(0) since this will change interval
}

void Console::displayMessages(){
    for(int i = 0; i < messagesInConsole.length(); i++){
        qDebug() << getMessage(i);
    }
}
void Console::debug(){
    for(int i = 0; i < messagesInConsole.length(); i++){
        qDebug() << getMessage(i);
    }
}
int Console::countMessages(){
    return messagesInConsole.size();
}

//getting message at position send to Serial console
QString Console::getMessage(int position){ return messagesInConsole.at(position).message;}
QString Console::getSource(int position){ return messagesInConsole.at(position).source;}
QString Console::getTime(int position){ return messagesInConsole.at(position).time;}
QString Console::getType(int position){ return messagesInConsole.at(position).type;}
QString Console::getTextColor(int position){ return messagesInConsole.at(position).textColor;}





//clear cosnole messages / empty QList
void Console::clearConsole(){
    qDebug() << "emptying console";
    messagesInConsole.clear();
    emit refreshConsole();
}


//creating new serial console message
void Console::log(QString type, QString source, QString message, QString textColor){

    QString currentTimeString = QDateTime::currentDateTime().toString("hh:mm:ss.zzz");

    msg m;

    if(source.isEmpty()){
       // qDebug() << "[ "+currentTimeString+" ]" << "[ ]" << message;
    }
    //qDebug() << "[ "+currentTimeString+" ]" << "[ "+source+" ]" << message;

    m.newMessage(type,currentTimeString,source,message,textColor);

    messagesInConsole.append(m);
    emit refreshConsole();
    emit sendToConsole(currentTimeString, type, source, message, textColor);

}
