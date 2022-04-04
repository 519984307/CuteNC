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
double feedrate = 500;
void AxisController::setZeros(){
    setXPosition(0);
    setYPosition(0);
    setZPosition(0);
    setAPosition(0);
    setBPosition(0);
    setCPosition(0);
}


//void AxisController::nextSegment(QStringList segment){
//    totalTime = 0;
//    foreach(QString line, segment){
//        calculateTravelTime(line);
//    }
//}
void AxisController::calculateTravelTime(AxisController *parent, QStringList commands, QString motionType){
    bool ok = true;

    if(motionType == "G28" && commands.length() == 0){
        parent->jogAxis("X",-parent->getXPosition());
        parent->jogAxis("Y",-parent->getYPosition());
        parent->jogAxis("Z",-parent->getZPosition());
    }
    foreach(QString command, commands){
       // qDebug() << "command " << command << "motion type" << motionType;
        QString mt = motionType;

        if(mt == "G92"){
            //set 0
            parent->jogAxis((QString)command[0],-parent->getAxisPosition((QString)command[0]));
            continue;
        }

        if(mt == "G28" && commands.length() > 0){
            parent->jogAxis((QString)command[0],-parent->getAxisPosition((QString)command[0]));
        }


        if(command[0] == "F"){
            QString temp = command.remove(0,1);
            feedrate = temp.toDouble(&ok);
            qDebug() << feedrate;
            //convert from mm/min to mm/s
            //feedrate = feedrate * (1/60);


//# G1 Z0.200 F5400.000
//newZ = 0.2 mm
//mmPerSecond = 5400 / 60 = 90 mm/s
//deltaZ = newZ - currentZ = 0.2 - 0 = 0.2 mm
//segmentLength = deltaZ  = 0.2 mm
//moveTime = segmentLength / mmPerSecond = 0.2 / 90 = 0.002 s
//totalTime = totalTime + moveTime = 0 + 0.002 = 0.002 s

        }else if(command[0] == "X"){
            QString temp = command.remove(0,1);

            double oldpos = parent->getXPosition();
            double newpos = temp.toDouble(&ok);
            double delta = abs(newpos - oldpos);
            double moveTime = delta / (feedrate/60);
            parent->totalTime = parent->totalTime + moveTime;

            parent->jogAxis("X",temp.toDouble(&ok));



        }else if(command[0] == "Y"){
            QString temp = command.remove(0,1);

            double oldpos = parent->getYPosition();
            double newpos = temp.toDouble(&ok);
            double delta = abs(newpos - oldpos);
            double moveTime = delta / (feedrate/60);
            parent->totalTime = parent->totalTime + moveTime;

            parent->jogAxis("Y",temp.toDouble(&ok));

        }else if(command[0] == "Z"){
            QString temp = command.remove(0,1);

            double oldpos = parent->getZPosition();
            double newpos = temp.toDouble(&ok);
             double delta = abs(newpos - oldpos);
            double moveTime = delta / (feedrate/60);
            parent->totalTime = parent->totalTime + moveTime;

            parent->jogAxis("Z",temp.toDouble(&ok));

        }else if(command[0] == "A"){
            QString temp = command.remove(0,1);

            double oldpos = parent->getAPosition();
            double newpos = temp.toDouble(&ok);
            double delta = abs(newpos - oldpos);
            double moveTime = delta / (feedrate/60);
            parent->totalTime = parent->totalTime + moveTime;

            parent->jogAxis("A",temp.toDouble(&ok));

        }else if(command[0] == "B"){
            QString temp = command.remove(0,1);

            double oldpos = parent->getBPosition();
            double newpos = temp.toDouble(&ok);
             double delta = abs(newpos - oldpos);
            double moveTime = delta / (feedrate/60);
            parent->totalTime = parent->totalTime + moveTime;

            parent->jogAxis("B",temp.toDouble(&ok));

        }else if(command[0] == "C"){
            QString temp = command.remove(0,1);

            double oldpos = parent->getCPosition();
            double newpos = temp.toDouble(&ok);
             double delta = abs(newpos - oldpos);
            double moveTime = delta / (feedrate/60);
            parent->totalTime = parent->totalTime + moveTime;

            parent->jogAxis("C",temp.toDouble(&ok));
        }
        qDebug() << "totalTime " << parent->totalTime;

        emit parent->signal_Refresh();
        //parent->saveToFile();
    }
    //qDebug() << "moving " << c << " with feedrate of " << feedrate;
}
void AxisController::saveToFile(){

    QString fileName = "WebWidgetPositions.json";
    QString binDir = QCoreApplication::applicationDirPath();

    QStringList searchList;
    searchList.append(binDir);
    searchList.append(binDir+"/data");
    searchList.append(binDir+"/../data");
    searchList.append(binDir+"/../data/webserver");
    searchList.append(binDir+"/../data/webserver/assets");
    searchList.append(binDir+"/../cncSoftware/data"); // for development with shadow build (Linux)
    searchList.append(binDir+"/../../cncSoftware/data"); // for development with shadow build (Windows)
    searchList.append(binDir+"/../cncSoftware/webserver"); // for development with shadow build (Linux)
    searchList.append(binDir+"/../../cncSoftware/webserver/assets"); // for development with shadow build (Windows)
    searchList.append(QDir::rootPath()+"data/webserver");
    searchList.append(QDir::rootPath()+"data/webserver/assets");
    searchList.append(QDir::rootPath()+"data/opt");
    searchList.append(QDir::rootPath()+"data");

    qDebug() << "Root path: " << QDir::rootPath();
    qDebug() << "Dir path: " << binDir;
    foreach (QString dir, searchList)
    {
        QFile file(dir+"/"+fileName);
        if (file.exists())
        {
            fileName=QDir(file.fileName()).canonicalPath();
        }
    }

    QString pathToFile = fileName;
    QDir dir;
    if(!dir.exists(pathToFile)){
        dir.mkpath(pathToFile);
    }

    QFile file(pathToFile);
    if(!file.open(QIODevice::ReadWrite)) {
        qDebug() << "failed creating file" << file.fileName() << file.errorString() << file.error();
    } else {
        qDebug() <<"file created! "+pathToFile;

        file.resize(0);

        QJsonObject mainObj;
        mainObj.insert("x",this->getXPosition());
        mainObj.insert("y",this->getYPosition());
        mainObj.insert("z",this->getZPosition());
        QJsonDocument jsonDoc;
        jsonDoc.setObject(mainObj);
        file.write(jsonDoc.toJson());
        file.close();
    }

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
}
void AxisController::jogAxis(QString axis, double position){
    qDebug() << "jogAxis " << axis << "  " << position;
    if(axis == "X"){
        this->setXPosition(position);
        //emit signal_MoveX(position);
    }

    if(axis == "Y"){
        this->setYPosition(position);
        //emit signal_MoveY(position);
    }

    if(axis == "Z"){
        this->setZPosition(position);
        //emit signal_MoveZ(position);
    }

    if(axis == "A"){
        this->setAPosition(position);
       // emit signal_MoveA(position);
    }

    if(axis == "B"){
        this->setBPosition(position);
        //emit signal_MoveB(position);
    }

    if(axis == "C"){
        this->setCPosition(position);
       // emit signal_MoveC(position);
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

void AxisController::draw2D(){
    qDebug() << "moving..";




}

void AxisController::executeMCommand(const QString command, const QString type){
    qDebug() << command << " G<<<";
}


QString previousMotionType = "";
void AxisController::executeCommand(QStringList commands, QString motionType, bool isExecuting){
    if(!this->startReading){
        if(motionType != ""){
            if(motionType[0] == "M" || motionType[0] == "T"){

            }else if(motionType[0] == "G"){
                previousMotionType = motionType;
            }
            if(isExecuting){
                calculateTravelTime(this,commands,previousMotionType);
            }else{
                //qDebug() << "commands " << commands;
                emit signal_Drawing(commands, previousMotionType);
            }
        }

        if(previousMotionType != "" && previousMotionType[0] == "G"){
            //calculateTravelTime(this,commands,previousMotionType);
        }else{
            qDebug() << previousMotionType << "T or M";
        }
    }
}
