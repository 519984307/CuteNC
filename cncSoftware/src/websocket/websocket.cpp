#include "websocket.h"
#include "../global.h"

#include <QHostAddress>
#include <QDebug>
#include <QFile>
#include <QNetworkInterface>

Websocket websocket;

Websocket::Websocket(QObject *parent) : HttpRequestHandler(parent){
    QString versionString = QString::fromUtf8(getQtWebAppLibVersion());
    connect(this,SIGNAL(signal_RequestCommand(QString,QString)),parent,SLOT(commandReceived(QString,QString)));
    //console.log("info","WebWidget",tr("Running QWebApp ")+versionString);
}


void Websocket::service(HttpRequest &request, HttpResponse &response) {
    QByteArray path = request.getPath();

    if(path == "/" || path == ""){
        serviceIndex(request, response);
    }else if(path.startsWith("/js")){
        staticFileController->service(request, response);
    }else if(path.startsWith("/css")){
        staticFileController->service(request, response);
    }else if(path.startsWith("/assets")){
        staticFileController->service(request, response);

    }else{
        response.setStatus(404, "Not found");
        response.write("Provided URL is invalid.");
    }
}

void Websocket::serviceIndex(HttpRequest &request, HttpResponse &response){
    //QFile tfile(WEBUI_TEMPLATE_DIR + "index.html");
    staticFileController->service(request,response);



    //Move
    if(request.getParameter("moveAxis") != "" && request.getParameter("feedrate") != "" && request.getParameter("resolution") != ""){
        qDebug() << "moving "+request.getParameter("moveAxis") + " " + request.getParameter("feedrate")+ " " +  request.getParameter("resolution");
        QString resolution =request.getParameter("resolution");
        QString feedrate = request.getParameter("feedrate");
        QString axis = request.getParameter("moveAxis");
        emit signal_RequestCommand("G0 "+axis+""+resolution+" F"+feedrate, "WebWidget");
    }
    //Set zero
    if(request.getParameter("setZero") != ""){
        qDebug() << "setzero " + request.getParameter("setZero");
        emit signal_RequestCommand("G92 "+request.getParameter("setZero")+"0", "WebWidget");
    }
    //Home
    if(request.getParameter("home") != ""){
        QString axis = request.getParameter("home");
        if(axis == "ALL"){
            emit signal_RequestCommand("G28", "WebWidget");
        }else{
            emit signal_RequestCommand("G28 " + axis, "WebWidget");
        }
        qDebug() << "home " + request.getParameter("home");
    }
}
