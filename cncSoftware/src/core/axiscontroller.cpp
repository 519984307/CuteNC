#include "axiscontroller.h"

AxisController::AxisController(QObject *parent)
    : QObject{parent}
{

}

AxisController::~AxisController(){
    close();
    qDebug("AxisController: destroyed");
}

void AxisController::close() {
    qDebug("AxisController: closed");

}

void AxisController::startUp(){
    emit signal_Refresh();
}

void AxisController::sendNextCommand(){
    qDebug() << "Sending next command...";
    emit signal_WaitingForNextCommand();

}
QStringList axes;
double feedrate;
void AxisController::calculateTravelTime(AxisController *parent, QString command, QString motionType){
    QString c = command;
    QString mt = motionType;
    if(command[0] == "F"){
      bool ok = true;
      QString temp = command.remove(0,1);
      feedrate = temp.toDouble(&ok);
      qDebug() << feedrate;
      //convert from mm/min to mm/s
      feedrate = feedrate * (1/60);

    }else if(command[0] == "X"){
        bool ok = true;
        QString temp = command.remove(0,1);
        parent->setXPosition(temp.toDouble(&ok));
        emit parent->signal_Refresh();
    }else if(command[0] == "Y"){
        bool ok = true;
        QString temp = command.remove(0,1);
        parent->setYPosition(temp.toDouble(&ok));
        emit parent->signal_Refresh();
    }else if(command[0] == "Z"){
        bool ok = true;
        QString temp = command.remove(0,1);
        parent->setZPosition(temp.toDouble(&ok));
        emit parent->signal_Refresh();
    }else if(command[0] == "A"){
        bool ok = true;
        QString temp = command.remove(0,1);
        parent->setAPosition(temp.toDouble(&ok));
        emit parent->signal_Refresh();
    }else if(command[0] == "B"){
        bool ok = true;
        QString temp = command.remove(0,1);
        parent->setBPosition(temp.toDouble(&ok));
        emit parent->signal_Refresh();
    }else if(command[0] == "C"){
        bool ok = true;
        QString temp = command.remove(0,1);
        parent->setCPosition(temp.toDouble(&ok));
        emit parent->signal_Refresh();
    }
    qDebug() << "moving " << c << " with feedrate of " << feedrate;
}

void AxisController::setXPosition(const double position){this->xPosition = position;}

void AxisController::setYPosition(const double position){this->yPosition = position;}

void AxisController::setZPosition(const double position){this->zPosition = position;}

void AxisController::setAPosition(const double position){this->aPosition = position;}

void AxisController::setBPosition(const double position){this->bPosition = position;}

void AxisController::setCPosition(const double position){this->cPosition = position;}


double AxisController::getXPosition() const{
    return xPosition;
}

double AxisController::getYPosition() const{
    return yPosition;
}

double AxisController::getZPosition() const{
    return zPosition;
}

double AxisController::getAPosition() const{
    return aPosition;
}

double AxisController::getBPosition() const{
    return bPosition;
}

double AxisController::getCPosition() const{
    return cPosition;
}


void AxisController::executeMCommand(const QString command, const QString type){
    qDebug() << command << " G<<<";
}


QString previousMotionType = "";
void AxisController::executeCommand(QString command,QString motionType){
    if(this->startReading){
        if(command != "" && command != " "){

            if(motionType != ""){
                if(motionType[0] == "M" || motionType[0] == "T"){

                }else if(motionType[0] == "G"){
                    previousMotionType = motionType;
                }

            }

            if(previousMotionType != "" && previousMotionType[0] == "G"){
                qDebug() << previousMotionType << "G";
                qDebug() << command;        
                QFuture<void> future = QtConcurrent::run(this->calculateTravelTime, this, command, previousMotionType);
            }else{
                qDebug() << previousMotionType << "T or M";
                qDebug() << command;
            }


        }
    }
}
