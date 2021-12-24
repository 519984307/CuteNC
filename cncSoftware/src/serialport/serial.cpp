#include "serial.h"
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QObject>
#include <QThread>
#include "../global.h"


#include <QTimer>
#include <QByteArray>



QList<QSerialPortInfo> ports = QSerialPortInfo::availablePorts();
QList<QString> portNames;


Comport comport;
QByteArray receivedData;




int i;
Comport::Comport(QObject *parent) : QObject(parent), qserialPort(new QSerialPort(this)), m_thread(new QThread(this)){

    qDebug() << "Serial communication created";

    connect(qserialPort, &QSerialPort::errorOccurred, this, &Comport::handleError);
    connect(qserialPort, &QSerialPort::readyRead, this, &Comport::readData);
    connect(&comport, &Comport::receivedCommand, this, &Comport::writeData);
}

Comport::~Comport(){
    qDebug() << "Comport: destroyed";
    close();
}

void Comport::close(){
    qDebug() << "Comport: closed";
    qserialPort->close();
    //if marlin emergency stop or M108 // break
   //writeData("M112");

}

void Comport::writeData(const QByteArray &data){
    qserialPort->write(data);
}



void Comport::readData(){
        QByteArray data;
        data = qserialPort->readAll();
        receivedData.append(data);
        console.log("log","comport",receivedData);
}

//todo make eom better
//end of message determined by new line \n <- marlin
bool Comport::eom(){
    int index = receivedData.indexOf('\n');
    if(index > 0){
        receivedData.remove(index,2);

        //if 1st char is " " <- just for esthetics while printing message into console
//        if(receivedData.indexOf(" ")==0){
//            receivedData.remove(receivedData.indexOf(" "),1);
//        }

        console.log("log","comport",receivedData);
        return true;
    }
    return false;
}

void Comport::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        console.log("error","comport","Critical Error "+qserialPort->errorString());
        closeSerialPort();
    }
}


void Comport::debug(){
        qDebug() << "comport debug";
        console.log("info","comport","debug","greyedOut");

        qserialPort->write("M119");
}

void Comport::connectionError(QString message){
    console.log("error","comport",message);
}

void Comport::openSerialPort(QString serialPortName){
    if(connected == false && !qserialPort->isOpen()){
        connected = true;
        console.log("info","comport","Connecting to " + serialPortName);
        connectedPortName = serialPortName;

        //if sucessfully connected
        if(serialPortName == "dummy"){
            console.log("info","comport","Connected successfully to "+serialPortName,"greenedOut");
            console.log("info","comport","DEBUG MODE","greyedOut");
        }else{
            qserialPort->setPortName(serialPortName);
            int serialPortBaudRate = 250000;
            qserialPort->setBaudRate(serialPortBaudRate);

            qserialPort->setParity(QSerialPort::NoParity);
            qserialPort->setDataBits(QSerialPort::Data8);
            qserialPort->setStopBits(QSerialPort::OneStop);
            qserialPort->setFlowControl(QSerialPort::NoFlowControl);

            console.log("info","comport","Connected successfully to "+serialPortName+" with baud rate of "+QString::number(serialPortBaudRate),"greenedOut");

            portInfo();

            //error opening port

            if(!qserialPort->open(QIODevice::ReadWrite)) {
                console.log("error","comport","Failed opening port "+serialPortName+", error: "+qserialPort->errorString());
                closeSerialPort();
            }else{
                console.log("info","comport","Connected successfully","greenedOut");
            }
        }

    }
    else if(connected == true && qserialPort->isOpen()){
        console.log("warn","comport","Alredy connected to " + serialPortName);
    }
}
void Comport::closeSerialPort(){
    if(connected == true){
        connected = false;
        connectedPortName = "";
        console.log("info","comport","Port closed");
        qserialPort->close();
    }
    if(connected == true && qserialPort->isOpen()){
        connected = false;
        qserialPort->close();

        connectedPortName = "";
        console.log("info","comport","Port closed");
    }else{
        connected = false;
        qserialPort->close();
    }
}
void Comport::getAvailablePorts(){
    portNames.append("dummy");

    //display avaiable ports
    //i=0 reserved for dummy
    for(int i = 0; i < ports.size(); i++){
        qDebug() << ports.at(i).portName();
        portNames.append(ports.at(i).portName());
    }
}
int Comport::numberOfAvaiablePorts(){
    return ports.size();
}
QString Comport::getPortName(int position){
    return portNames.at(position);
}

int Comport::getPortPos(){
    for(int i = 0; i < ports.size(); i++){
        if(ports.at(i).portName() == connectedPortName){
            return i;
        }
    }
    return true;
}


//Display port info
void Comport::portInfo(){
        if(connected == true){

            QString vendorID,productID,busy,manufacturer,description,location,port;
            int portPos = getPortPos();

            port = ports.at(portPos).portName();
            location = ports.at(portPos).systemLocation();
            description = ports.at(portPos).description();
            manufacturer = ports.at(portPos).manufacturer();
            vendorID = QString::number(ports.at(portPos).vendorIdentifier());
            productID = QString::number(ports.at(portPos).productIdentifier());

            console.log("info","comport","Port: "+port+ "\nLocation: "+location+ "\nDescription: "+description+ "\nManufacturer: "+manufacturer+"\nVendor ID: " + vendorID + "\nProduct ID: "+productID);
        }else{
            console.log("warn","comport","Cannot display port info. Serial port is not connected");
        }
}
//QList<QString> comPort::getPortNames(){
//    return portNames;
//}
