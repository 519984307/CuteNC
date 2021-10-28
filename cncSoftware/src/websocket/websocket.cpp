#include "websocket.h"
#include "../global.h"

#include <QHostAddress>
#include <QDebug>
#include <QFile>

Websocket websocket;


Websocket::Websocket(QObject *parent) : HttpRequestHandler(parent) {

}


void Websocket::service(HttpRequest &request, HttpResponse &response) {
    QByteArray path = request.getPath();
    if(path == "/" || path == ""){
        serviceIndex(request, response);


    }else{
        response.setStatus(404, "Not found");
        response.write("Provided URL is invalid.");
    }
}

void Websocket::serviceIndex(HttpRequest &request, HttpResponse &response){
    //QFile tfile(WEBUI_TEMPLATE_DIR + "index.html");
    TFormButtons button = GetButtonFromRequest(request);
    staticFileController->service(request,response);

    switch(button)
    {
    case FB_NONE:
        break;
    case FB_DEBUG:
        qDebug() << "debug from html!";
        break;
    }
    qInfo()<< "----------------------------";
    qInfo()<< request.getBody();
    qInfo()<< "----------------------------";
}

Websocket::TFormButtons Websocket::GetButtonFromRequest(HttpRequest &request){
    TFormButtons ret;

    if(request.getParameter("debugBtn")!=""){
        ret = FB_DEBUG;
    }else{
        ret = FB_NONE;
    }

    return ret;
}
