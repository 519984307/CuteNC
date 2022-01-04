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
    console.log("log","gcode","N1 G17 G20 G90 G94 G54\nN2 G0 Z0.25\nN3 X-0.5 Y0.");

    // console.log("log","gcode","N1 G17 G20 G90 G94 G54\nN2 G0 Z0.25\n N3 X-0.5 Y0.\nN4 Z0.1\nN5 G01 Z0. F5.\nN6 G02 X0. Y0.5 I0.5 J0. F2.5\nN7 X0.5 Y0. I0. J-0.5\nN8 X0. Y-0.5 I-0.5 J0.\nN9 X-0.5 Y0. I0. J0.5\nN10 G01 Z0.1 F5.\nN11 G00 X0. Y0. Z0.25\nN12 M119");
    //console.log("info","comport","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum");
}

QStringList generateGroups(QString command){
    QStringList array;
    QStringList words = command.split(" ");

    for(int j = 0; j < words.length(); j++){
        QString word = words[j];
        array.append(word);
    }
    return array;
}

QString getCmdArgs(QString word){
    QString result;

    for(int i = 1; i < word.length(); i++){
        result += word[i];
    }
    //  qDebug() << "CmdArgs" << result;
    return result;
}

void gCodeInterpreter(QStringList groups){
    QString motionType;
    QString param;

    for(int i = 0; i < groups.length(); i++){
        QStringList params;

        QString word = groups[i].trimmed();
        QChar letter = word[0];

        if(letter == 'G'){
            QString arg = getCmdArgs(word);

            if (arg == '0' || arg == '1' || arg == '2' || arg == '3' || arg == "38.2" || arg == "38.3" || arg == "38.4" || arg == "38.5") {
                motionType = word;
            } else if (arg == "80") {
                motionType = "";
            }else{
                axisController->executeCommand(arg);
            }

        } else if (letter == 'M') {
            QString arg = getCmdArgs(word);
            param = word;
        } else if (letter == 'T') {
            QString arg = getCmdArgs(word);
            param = word;
        } else if (letter == 'F') {
            QString arg = getCmdArgs(word);
            param = word;
        } else if (letter == 'X' || letter == 'Y' || letter == 'Z' || letter == 'A' || letter == 'B' || letter == 'C' || letter == 'I' || letter == 'J' || letter == 'K') {
            QString arg = getCmdArgs(word);
            param = word;
        }
        axisController->executeCommand(param, motionType);
    }
}

//creating new serial console message
void Console::log(QString type, QString source, QString message, QString textColor){
    QStringList commands = message.split("\n");

    foreach(QString cmd, commands){
        QString currentTimeString = QDateTime::currentDateTime().toString("hh:mm:ss.zzz");

        //N1 G01 X100
        QStringList groups = generateGroups(cmd);
        //"N1" "G01" "X100"
        gCodeInterpreter(groups);

        emit sendToConsole(currentTimeString, type, source, cmd, textColor);
    }
}
