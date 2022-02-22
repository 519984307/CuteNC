#include "comport.h"

QList<QSerialPortInfo> availablePorts;
QList<QString> portNames;
QByteArray receivedData;

bool justStarted = true;
Comport::Comport(QObject *parent, Console *console) : QObject(parent), qserialPort(new QSerialPort(this)), m_Thread(new QThread(this)){
    qDebug() << "Serial communication created";
    this->m_Console = console;

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
void Comport::startUp(){
    qDebug() << "Comport: startUp()";

    m_Console->log("info","Serial port",tr("Reading available COM ports."));

    getAvailablePorts();
}

void Comport::writeData(const QByteArray &data){
    qserialPort->write(data);
}

void Comport::readData(){

    QByteArray data;

    //this blocks the thread, can be rewritten to NOT do that but the interval is so small it doesn't matter.
    //made to read large amount of data that gets split into few segments causing it not to display properly.
    if(justStarted){
        QElapsedTimer t;
        t.start();

        while (t.elapsed() < 100) {
            data = qserialPort->readAll();
            receivedData.append(data);
        }
        justStarted = false;
        m_Console->m_AxisController->startReading = true;
        m_Console->log("info","Serial port", receivedData, nullptr ,true);
    }else{
        data = qserialPort->readAll();
        m_Console->log("log","Serial port", data, nullptr ,true);
    }
}

void Comport::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        m_Console->log("error","Serial port",tr("Critical Error ")+qserialPort->errorString());
        closeSerialPort();
    }
}


void Comport::debug(){
    qDebug() << "comport debug";
    m_Console->log("info","Serial port","debug","greyedOut");

    QList<QSerialPortInfo> ap = QSerialPortInfo::availablePorts();
    for(int i = 0 ; i < ap.length(); i++){
        m_Console->log("error","Serial port","Visible port: "+ap[i].portName());
    }

}

void Comport::connectionError(QString message){
    m_Console->log("error","Serial port",message);
}

void Comport::openSerialPort(QString serialPortName){
    if(connected == false && !qserialPort->isOpen()){
        connected = true;
        m_Console->log("info","Serial port",tr("Connecting... "));
        connectedPortName = serialPortName;

        //if sucessfully connected
        if(serialPortName == "dummy"){
            m_Console->log("info","Serial port",tr("Connected successfully to ")+serialPortName,"greenedOut");
            m_Console->log("info","Serial port",tr("DEBUG MODE"),"greyedOut");
        }else{
            qserialPort->setPortName(serialPortName);
            int serialPortBaudRate = 250000;
            qserialPort->setBaudRate(serialPortBaudRate);

            qserialPort->setParity(QSerialPort::NoParity);
            qserialPort->setDataBits(QSerialPort::Data8);
            qserialPort->setStopBits(QSerialPort::OneStop);
            qserialPort->setFlowControl(QSerialPort::NoFlowControl);

            m_Console->log("info","Serial port",tr("Connected successfully to ")+serialPortName+tr(" with baud rate of ")+QString::number(serialPortBaudRate),"greenedOut");

            portInfo();

            //error opening port

            if(!qserialPort->open(QIODevice::ReadWrite)) {
                m_Console->log("error","Serial port",tr("Failed opening port ")+serialPortName+tr(", error: ")+qserialPort->errorString());
                closeSerialPort();
                emit signal_ClosePort();
            }
        }

    }
    else if(connected == true && qserialPort->isOpen()){
        m_Console->log("warn","Serial port",tr("Alredy connected to ") + serialPortName);
    }
}
void Comport::closeSerialPort(){
    if(connected == true){
        m_Console->log("info","Serial port",tr("Disconnecting..."));
        connected = false;
        connectedPortName = nullptr;
    }
    if(qserialPort->isOpen()){
        qserialPort->close();
    }

    m_Console->log("info","Serial port",tr("Port closed"));
}
void Comport::getAvailablePorts(){
    availablePorts = QSerialPortInfo::availablePorts();

    if(availablePorts.isEmpty()){
        m_Console->log("warn","Serial port",tr("No serial ports found."));
    }else{
        for(int i = 0; i < availablePorts.size(); i++){
            portNames.append(availablePorts.at(i).portName());
        }
    }
}

int Comport::numberOfAvailablePorts(){
    return availablePorts.length();
}

QString Comport::getPortName(int position){
    if(!portNames.isEmpty()){
        return portNames.at(position);
    }
    return "";
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

        m_Console->log("info","Serial port","Port: "+port+"\nLocation: "+location+ "\nDescription: "+description+ "\nManufacturer: "+manufacturer+"\nVendor ID: " + vendorID + "\nProduct ID: "+productID);
    }else{
        m_Console->log("warn","Serial port",tr("Cannot display port info. Serial port is not connected"));
    }
}
