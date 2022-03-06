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
    //emit signal_WaitingForNextCommand();

}
QStringList axes;
double feedrate;
void AxisController::calculateTravelTime(AxisController *parent, QStringList commands, QString motionType){
    foreach(QString command, commands){

    QString mt = motionType;
    bool ok = true;
    if(command[0] == "F"){
      bool ok = true;
      QString temp = command.remove(0,1);
      feedrate = temp.toDouble(&ok);
      qDebug() << feedrate;
      //convert from mm/min to mm/s
      feedrate = feedrate * (1/60);

    }else if(command[0] == "X"){
        QString temp = command.remove(0,1);
        double xPos = temp.toDouble(&ok);
        parent->setXPosition(xPos);


        //emit parent->signal_MoveX(xPos);

    }else if(command[0] == "Y"){
        QString temp = command.remove(0,1);
        double yPos = temp.toDouble(&ok);
        parent->setYPosition(yPos);

        //emit parent->signal_MoveY(yPos);

    }else if(command[0] == "Z"){
        QString temp = command.remove(0,1);
        parent->setZPosition(temp.toDouble(&ok));

    }else if(command[0] == "A"){
        QString temp = command.remove(0,1);
        parent->setAPosition(temp.toDouble(&ok));

    }else if(command[0] == "B"){
        QString temp = command.remove(0,1);
        parent->setBPosition(temp.toDouble(&ok));

    }else if(command[0] == "C"){
        QString temp = command.remove(0,1);
        parent->setCPosition(temp.toDouble(&ok));
    }
    emit parent->signal_Refresh();
}
    //qDebug() << "moving " << c << " with feedrate of " << feedrate;
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

void AxisController::draw2D(){
    qDebug() << "moving..";




}

void AxisController::executeMCommand(const QString command, const QString type){
    qDebug() << command << " G<<<";
}


QString previousMotionType = "";
void AxisController::executeCommand(QStringList commands, QString motionType, bool isExecuting){
    if(!this->startReading){
        qDebug() << "Cmds " << commands;
           // if(command != "" && command != " "){

                if(motionType != ""){
                    if(motionType[0] == "M" || motionType[0] == "T"){

                    }else if(motionType[0] == "G"){
                        previousMotionType = motionType;
                    }

                }

                if(previousMotionType != "" && previousMotionType[0] == "G"){
                    if(isExecuting){
                       calculateTravelTime(this,commands,previousMotionType);
                    }else{
                       emit signal_Drawing(commands, previousMotionType);
                    }

                  //  QFuture<void> future = QtConcurrent::run(this->calculateTravelTime, this, command, previousMotionType);
                }else{
                   // qDebug() << previousMotionType << "T or M";
                }


         //   }
    }
}
