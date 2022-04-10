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

void AxisController::setZeros(){
    setXPosition(0);
    setYPosition(0);
    setZPosition(0);
    setAPosition(0);
    setBPosition(0);
    setCPosition(0);
}

//convert from mm/min to mm/s
//feedrate = feedrate * (1/60);

//# G1 Z0.200 F5400.000
//newZ = 0.2 mm
//mmPerSecond = 5400 / 60 = 90 mm/s
//deltaZ = newZ - currentZ = 0.2 - 0 = 0.2 mm
//segmentLength = deltaZ  = 0.2 mm
//moveTime = segmentLength / mmPerSecond = 0.2 / 90 = 0.002 s
//totalTime = totalTime + moveTime = 0 + 0.002 = 0.002 s

double AxisController::calculateMotionTime(double newFirst, double newSecond, double oldFirst, double oldSecond, double feedrate){
    double deltaFirst = newFirst - oldFirst;
    double deltaSecond = newSecond - oldSecond;
    double delta = sqrt((deltaFirst*deltaFirst) + (deltaSecond*deltaSecond));
    double moveTime = delta / (feedrate/60);
    return moveTime;
}

void AxisController::calculateTravelTime(QStringList commands, QString motionType){
    bool ok = true;

    if(motionType == "G28" && commands.length() == 0){
        this->jogAxis("X",-this->getXPosition());
        this->jogAxis("Y",-this->getYPosition());
        this->jogAxis("Z",-this->getZPosition());
    }
    double tempX,tempY,tempZ,tempA,tempB,tempC = 0;
    double tempFeedrate = this->feedrate;
    foreach(QString command, commands){
        qDebug() << "command " << command << "motion type" << motionType;
        QString mt = motionType;
        if(mt == "G92"){
            //set 0
            this->jogAxis((QString)command[0],-this->getAxisPosition((QString)command[0]));
            continue;
        }

        if(mt == "G28" && commands.length() > 0){
            this->jogAxis((QString)command[0],-this->getAxisPosition((QString)command[0]));
        }


        if(command[0] == "F"){
            QString temp = command.remove(0,1);
            tempFeedrate = temp.toDouble(&ok);

        }else if(command[0] == "X"){
            QString temp = command.remove(0,1);
            tempX = this->getXPosition();
            //   this->totalTime = this->totalTime + calculateMotionTime(this->getXPosition(), temp.toDouble(&ok),this->feedrate);
            this->jogAxis("X",temp.toDouble(&ok));
        }else if(command[0] == "Y"){
            QString temp = command.remove(0,1);
            tempY = this->getYPosition();
            //   this->totalTime = this->totalTime + calculateMotionTime(this->getYPosition(), temp.toDouble(&ok),this->feedrate);
            this->jogAxis("Y",temp.toDouble(&ok));
        }else if(command[0] == "Z"){
            QString temp = command.remove(0,1);
            tempZ = this->getZPosition();
            //   this->totalTime = this->totalTime + calculateMotionTime(this->getZPosition(), temp.toDouble(&ok),this->feedrate);
            this->jogAxis("Z",temp.toDouble(&ok));
        }else if(command[0] == "A"){
            QString temp = command.remove(0,1);
            tempA = this->getAPosition();
            //   this->totalTime = this->totalTime + calculateMotionTime(this->getAPosition(), temp.toDouble(&ok),this->feedrate);
            this->jogAxis("A",temp.toDouble(&ok));
        }else if(command[0] == "B"){
            QString temp = command.remove(0,1);
            tempB = this->getBPosition();
            //   this->totalTime = this->totalTime + calculateMotionTime(this->getBPosition(), temp.toDouble(&ok),this->feedrate);
            this->jogAxis("B",temp.toDouble(&ok));
        }else if(command[0] == "C"){
            QString temp = command.remove(0,1);
            tempC = this->getCPosition();
            //    this->totalTime = this->totalTime + calculateMotionTime(this->getCPosition(), temp.toDouble(&ok),this->feedrate);
            this->jogAxis("C",temp.toDouble(&ok));
        }


        emit this->signal_Refresh();
    }

    this->totalTime = this->totalTime + calculateMotionTime(this->getXPosition(), this->getYPosition(), tempX, tempY, tempFeedrate);
}

double AxisController::getAxisPosition(QString axis) const{
    if(axis == "X"){
        return xPosition;
    }

    if(axis == "Y"){
        return yPosition;
    }

    if(axis == "Z"){
        return zPosition;
    }

    if(axis == "A"){
        return aPosition;
    }

    if(axis == "B"){
        return bPosition;
    }

    if(axis == "C"){
        return cPosition;
    }

    return 0;
}
void AxisController::jogAxis(QString axis, double position){
    qDebug() << "jogAxis " << axis << "  " << position;
    if(axis == "X"){
        this->setXPosition(position);
    }

    if(axis == "Y"){
        this->setYPosition(position);
    }

    if(axis == "Z"){
        this->setZPosition(position);
    }

    if(axis == "A"){
        this->setAPosition(position);
    }

    if(axis == "B"){
        this->setBPosition(position);
    }

    if(axis == "C"){
        this->setCPosition(position);
    }

    emit signal_Refresh();
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


QString previousMotionType = "";
void AxisController::executeCommand(QStringList commands, QString function, bool isExecuting){
    if(!this->startReading){
        if(function != ""){
            if(function[0] == "M" || function[0] == "T"){
                //M203 - max Feedrate
                if(function == "M203"){
                    foreach(QString command, commands){
                        qDebug() <<"Command "<< command;
                        bool ok = true;
                        QString temp = command;
                        QString tempValue = temp.remove(0,1);

                    }
                }
            }else if(function[0] == "G"){
                previousMotionType = function;
                if(isExecuting){
                    calculateTravelTime(commands,previousMotionType);
                }else{
                    emit signal_Drawing(commands, previousMotionType);
                }
            }
        }
    }
}
