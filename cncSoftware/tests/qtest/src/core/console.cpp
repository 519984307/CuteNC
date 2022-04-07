#include "console.h"
#include <QTime>
#include <QDate>
#include <QDebug>
#include <QList>
#include <QTimer>
#include "../global.h"

#include <QRegularExpression>
bool receivedFirstTime = true;
Console::Console(QObject *parent, AxisController *axisController) : QObject(parent)
{
    this->m_AxisController = axisController;
    connect(this->m_AxisController, SIGNAL(signal_WaitingForNextCommand()), this, SLOT(debug()));
    connect(this, SIGNAL(signal_ReadyForNextCommand()),this->m_AxisController, SLOT(this->m_AxisController->sendNextCommand()));
}

Console::~Console(){
    qDebug("Console: destroyed");
    close();
}
void Console::close(){
    log("info","system",tr("Shutting down..."));
}

void Console::commandReceived(QString command){

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

    if(isRunning){
         log("info","Console","Executing g-code? true");
    }else{
         log("info","Console","Executing g-code? false");
    }

    //log("log","gcode","N1 G17 G20 G90 G94 G54\nN2 G0 Z0.25\nN3 X-0.5 Y0.");

    //log("log","gcode","N1 G17 G20 G90 G94 G54\nN2 G0 Z0.25\n N3 X-0.5 Y0.\nN4 Z0.1\nN5 G01 Z0. F5.\nN6 G02 X0. Y0.5 I0.5 J0. F2.5\nN7 X0.5 Y0. I0. J-0.5\nN8 X0. Y-0.5 I-0.5 J0.\nN9 X-0.5 Y0. I0. J0.5\nN10 G01 Z0.1 F5.\nN11 G00 X0. Y0. Z0.25\nN12 M119");
    //log("info","comport","Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum");
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
    qDebug() << "getCmdArgs " << word;
    QString result;

    for(int i = 1; i < word.length(); i++){
        result += word[i];
    }
    //  qDebug() << "CmdArgs" << result;
    return result;
}

void Console::gCodeInterpreter(QStringList groups, bool isExecuting){
    //"G0", "X100", "Y100"
    QString motionType;
    QString param;
    QStringList params;

    for(int i = 0; i < groups.length(); i++){

        QString word = groups[i].trimmed();
        QChar letter = word[0];

        if(letter == 'G'){
            QString arg = getCmdArgs(word);

            if (arg == '0' || arg == '1' || arg == '2' || arg == '3' || arg == "38.2" || arg == "38.3" || arg == "38.4" || arg == "38.5" || arg == "02" || arg == "03") {
                motionType = word;
            } else if (arg == "80") {
                motionType = "";
            }else if (arg == "92" || arg == "28"){
                motionType = word;
            }else{
                QStringList args;
                args.append(arg);
                this->m_AxisController->executeCommand(args,"", isExecuting);
            }

        } else if (letter == 'M') {
            QString arg = getCmdArgs(word);
            motionType = word;
        } else if (letter == 'T') {
            QString arg = getCmdArgs(word);
            motionType = word;
        } else if (letter == 'F') {
            QString arg = getCmdArgs(word);
            param = word;
            params.append(param);
        } else if (letter == 'X' || letter == 'Y' || letter == 'Z' || letter == 'A' || letter == 'B' || letter == 'C' || letter == 'E' || letter == 'I' || letter == 'J' || letter == 'K') {
            QString arg = getCmdArgs(word);
            param = word;
            params.append(param);
        }else{
            //if letter = ''
            param = word;
            params.append(param);
        }

    }
    //qDebug() << "params " << params << " mtype " << motionType;
    this->m_AxisController->executeCommand(params, motionType, isExecuting);

}

//creating new serial console message
void Console::log(QString type, QString source, QString message, QString textColor, bool receivedFromSerialPort){
       QStringList commands = message.split("\n");
    if(receivedFirstTime){
        //emit signal_ReadyForNextCommand();
        receivedFirstTime = false;
    }else{
        foreach(QString cmd, commands){
            if(cmd != "" && cmd != " "){
            QString currentTimeString = QDateTime::currentDateTime().toString("hh:mm:ss.zzz");

            if(!receivedFromSerialPort){
                //N1 G01 X100
                QStringList groups = generateGroups(cmd);
                //"N1" "G01" "X100"
                gCodeInterpreter(groups,true);
            }
            //qDebug() << cmd << " cmd?";
            if(cmd == "ok"){
                emit signal_ReadyForNextCommand();
            }
            if(cmd != "ok"){
                 emit sendToConsole(currentTimeString, type, source, cmd, textColor);
            }
            }
        }
    }
}



void Console::drawFromFile(QString message){
    QStringList commands = message.split("\n");
    QList<QStringList> parsedFile;
    foreach(QString cmd, commands){
        if(cmd != "" && cmd != " "){
            //N1 G01 X100
            QStringList groups = generateGroups(cmd);
            //"N1" "G01" "X100"
            gCodeInterpreter(groups,false);
            parsedFile.append(groups);
        }
    }
    qDebug() << "file ready";
    emit signal_FileLoaded();

}

void Console::startGcode(){
    isRunning = true;

    emit signal_StartGcode();
}


void Console::stopGcode(){
    isRunning = false;
    emit signal_StopGcode();
}










