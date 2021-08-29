#include "websocket.h"
#include "global.h"

#include <QHostAddress>




#include <QDebug>
QHostAddress hostAddress;
Websocket websocket;

Websocket::Websocket(QObject *parent) : QObject(parent){

//    connect(&tcpServer, SIGNAL(newConnection()),
//            this, SLOT(acceptConnection()));
//    connect(&tcpClient, SIGNAL(connected()),
//            this, SLOT(clientSendMessageToServer()));
//    connect(&tcpClient, SIGNAL(bytesWritten(qint64)),
//            this, SLOT(updateClientProgress(qint64)));
//    connect(&tcpClient, SIGNAL(error(QAbstractSocket::SocketError)),
//            this, SLOT(displayError(QAbstractSocket::SocketError)));

}

void Websocket::websocketSetup(){
    console.log("info","websocket","starting websocket...");
    //createWebserver();
}

void createWebserver(){

}
