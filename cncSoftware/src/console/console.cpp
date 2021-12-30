#include "console.h"
#include <QTime>
#include <QDate>
#include <QDebug>
#include <QList>
#include <QTimer>
#include "../global.h"

#include <QRegularExpression>
Console console;

Console::Console(QObject *parent) : QObject(parent)
{

}

Console::~Console()
{
    qDebug("Console: destroyed");
    close();
}
void Console::close(){
    console.log("info","system",tr("Shutting down..."));
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

void Console::debug(){
    qDebug() << "Sending debug message";
    console.log("info","comport","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum");
}

//creating new serial console message
void Console::log(QString type, QString source, QString message, QString textColor){
    qDebug() << "about to send: " << message;
    QStringList commandsToSend = message.split("\n");

    QRegularExpression re("^(?<type>G\\d*) (?<Xaxis>X\\d*) (?<Yaxis>Y\\d*) (?<Zaxis>Z\\d*) (?<Aaxis>A\\d*) (?<Baxis>B\\d*) (?<Caxis>C\\d*) (?<frate>.\\d*)");
    QRegularExpressionMatch match = re.match("G01 X123 Y123 F1000");
    if (match.hasMatch()) {
        QString type = match.captured("type");
        QString Xaxis = match.captured("Xaxis");
        QString Yaxis = match.captured("Yaxis");
        QString Zaxis = match.captured("Zaxis");
        QString Aaxis = match.captured("Aaxis");
        QString Baxis = match.captured("Baxis");
        QString Caxis = match.captured("Caxis");
        QString frate = match.captured("frate");

    }

    foreach(QString command, commandsToSend){

        QString currentTimeString = QDateTime::currentDateTime().toString("hh:mm:ss.zzz");
        qDebug() << "emitting" << command;
        emit sendToConsole(currentTimeString, type, source, command, textColor);

    }
}
