#include "comport.h"

Comport::Comport(QObject *parent) : QObject(parent), qserialPort(new QSerialPort(this)), m_thread(new QThread(this)){

    qDebug() << "Serial communication created";

    connect(qserialPort, &QSerialPort::errorOccurred, this, &Comport::handleError);
    connect(qserialPort, &QSerialPort::readyRead, this, &Comport::readData);
    connect(this, &Comport::receivedCommand, this, &Comport::writeData);
}

Comport::~Comport(){
    qDebug() << "Comport: destroyed";
    close();
}

void Comport::close(){
    qDebug() << "Comport: closed";
    connected = false;
    connectedPortName = "";
    qserialPort->close();
}


void Comport::writeData(const QByteArray &data){
    qserialPort->write(data);
}

void Comport::readData(){
        QByteArray data;
        data = qserialPort->readAll();
        receivedData.append(data);
        // console.log("log","comport", data);
}

void Comport::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        // console.log("error","comport","Critical Error "+qserialPort->errorString());
        closeSerialPort();
    }
}


void Comport::debug(){
        qDebug() << "comport debug";
        // console.log("info","comport","debug","greyedOut");

        qserialPort->write("M119");
}

void Comport::connectionError(QString message){
    // console.log("error","comport",message);
}

void Comport::openSerialPort(QString serialPortName){
    if(connected == false && !qserialPort->isOpen()){
        connected = true;
        // console.log("info","comport","Connecting to " + serialPortName);
        connectedPortName = serialPortName;

        //if sucessfully connected
        if(serialPortName == "dummy"){
            // console.log("info","comport","Connected successfully to "+serialPortName,"greenedOut");
            // console.log("info","comport","DEBUG MODE","greyedOut");
        }else{
            qserialPort->setPortName(serialPortName);
            int serialPortBaudRate = 250000;
            qserialPort->setBaudRate(serialPortBaudRate);

            qserialPort->setParity(QSerialPort::NoParity);
            qserialPort->setDataBits(QSerialPort::Data8);
            qserialPort->setStopBits(QSerialPort::OneStop);
            qserialPort->setFlowControl(QSerialPort::NoFlowControl);

            // console.log("info","comport","Connected successfully to "+serialPortName+" with baud rate of "+QString::number(serialPortBaudRate),"greenedOut");

            portInfo();

            //error opening port

            if(!qserialPort->open(QIODevice::ReadWrite)) {
                // console.log("error","comport","Failed opening port "+serialPortName+", error: "+qserialPort->errorString());
                closeSerialPort();
            }else{
                // console.log("info","comport","Connected successfully","greenedOut");
            }
        }

    }
    else if(connected == true && qserialPort->isOpen()){
        // console.log("warn","comport","Alredy connected to " + serialPortName);
    }
}
void Comport::closeSerialPort(){
    if(connected == true){
        connected = false;
        connectedPortName = nullptr;
    }
    if(qserialPort->isOpen()){
        qserialPort->close();
    }

    // console.log("info","comport","Port closed");
}
void Comport::getAvailablePorts(){
    for(int i = 0; i < availablePorts.size(); i++){
        portNames.append(availablePorts.at(i).portName());
    }
}
int Comport::numberOfAvaiablePorts(){
    return availablePorts.size();
}
QString Comport::getPortName(int position){
    return portNames.at(position);
}

int Comport::getPortPos(){
    for(int i = 0; i < availablePorts.size(); i++){
        if(availablePorts.at(i).portName() == connectedPortName){
            return i;
        }
    }
    return true;
}

void Comport::portInfo(){
        if(connected == true){

            QString vendorID,productID,busy,manufacturer,description,location,port;
            int portPos = getPortPos();

            port = availablePorts.at(portPos).portName();
            location = availablePorts.at(portPos).systemLocation();
            description = availablePorts.at(portPos).description();
            manufacturer = availablePorts.at(portPos).manufacturer();
            vendorID = QString::number(availablePorts.at(portPos).vendorIdentifier());
            productID = QString::number(availablePorts.at(portPos).productIdentifier());

            // console.log("info","comport","Port: "+port+ "\nLocation: "+location+ "\nDescription: "+description+ "\nManufacturer: "+manufacturer+"\nVendor ID: " + vendorID + "\nProduct ID: "+productID);
        }else{
            // console.log("warn","comport","Cannot display port info. Serial port is not connected");
        }
}
