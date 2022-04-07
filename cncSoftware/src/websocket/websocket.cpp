#include "websocket.h"
#include "../global.h"

#include <QHostAddress>
#include <QDebug>
#include <QFile>
#include <QNetworkInterface>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QVariantMap>
Websocket websocket;

Websocket::Websocket(QObject *parent,AxisController *axisController) : HttpRequestHandler(parent){
    QString versionString = QString::fromUtf8(getQtWebAppLibVersion());
    this->m_AxisController = axisController;
    connect(this,SIGNAL(signal_RequestCommand(QString,QString)),parent,SLOT(commandReceived(QString,QString)));

    //console.log("info","WebWidget",tr("Running QWebApp ")+versionString);
}


void Websocket::service(HttpRequest &request, HttpResponse &response) {
    qDebug()<< "Http Server start" <<endl;
    QByteArray path = request.getPath();
    QHostAddress peer = request.getPeerAddress();


    if(path == "/" || path == ""){
        serviceIndex(request, response);
    }else if(path=="/getData"){
         response.setHeader("Content-Type", "application/json");
         QJsonDocument tmp;
         QJsonObject data;

         data.insert("x",this->m_AxisController->getXPosition());
         data.insert("y",this->m_AxisController->getYPosition());
         data.insert("z",this->m_AxisController->getZPosition());
         tmp.setObject(data);
         QByteArray jsondata = tmp.toJson(QJsonDocument::Compact);

         response.write(jsondata);
         response.flush();

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
    QByteArray path = request.getPath();
    QHostAddress peer = request.getPeerAddress();

    if(request.getParameter("moveAxis") != "" && request.getParameter("feedrate") != "" && request.getParameter("resolution") != ""){
        qDebug() << "moving "+request.getParameter("moveAxis") + " " + request.getParameter("feedrate")+ " " +  request.getParameter("resolution");
        QString resolution =request.getParameter("resolution");
        QString feedrate = request.getParameter("feedrate");
        QString axis = request.getParameter("moveAxis");
        bool ok = true;
        double stepSize = resolution.toDouble(&ok);
        double currentPos = this->m_AxisController->getAxisPosition(axis);
        double sum = currentPos+stepSize;

        emit signal_RequestCommand("G0 "+axis+""+QString::number(sum)+" F"+feedrate, "WebWidget");
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
