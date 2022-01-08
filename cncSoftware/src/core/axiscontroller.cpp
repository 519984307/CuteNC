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

void AxisController::calculateTravelTime(){

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


void AxisController::executeGCommand(const QString command){
    qDebug() << command << " G<<<";
}

void AxisController::executeMCommand(const QString command){
    qDebug() << command << " M<<<";
}

void AxisController::executeCommand(const QString command,const QString motionType) const{
    if(this->startReading){
        if(command != "" && command != " "){
            qDebug() << motionType;
            qDebug() << command;
        }
    }
}
