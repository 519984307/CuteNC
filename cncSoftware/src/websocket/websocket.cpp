#include "websocket.h"
#include "../global.h"

#include <QHostAddress>
#include <QDebug>
#include <QFile>

Websocket websocket;


Websocket::Websocket(QObject *parent) : HttpRequestHandler(parent){
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
    TFormButtons button = GetButtonFromRequest(request);
    staticFileController->service(request,response);
    /*
        BTN_NONE,
        BTN_DEBUG,
        BTN_HOME_X,
        BTN_HOME_Y,
        BTN_HOME_Z,
        BTN_HOME_A,
        BTN_HOME_ALL,
        BTN_SET_ZERO_X,
        BTN_SET_ZERO_Y,
        BTN_SET_ZERO_Z,
        BTN_SET_ZERO_A,
        BTN_MOVE_X_PLUS,
        BTN_MOVE_X_MINUS,
        BTN_MOVE_Y_PLUS,
        BTN_MOVE_Y_MINUS,
        BTN_MOVE_Z_PLUS,
        BTN_MOVE_Z_MINUS,
        BTN_MOVE_A_PLUS,
        BTN_MOVE_A_MINUS
*/
    switch(button)
    {
    case BTN_NONE:
        break;
    case BTN_DEBUG:
        qDebug() << "debug from html!";
        break;
    case BTN_HOME_ALL:
        break;
    case BTN_HOME_X:
        break;
    case BTN_HOME_Y:
        break;
    case BTN_HOME_Z:
        break;
    case BTN_HOME_A:
        break;
    case BTN_SET_ZERO_X:
        break;
    case BTN_SET_ZERO_Y:
        break;
    case BTN_SET_ZERO_Z:
        break;
    case BTN_SET_ZERO_A:
        break;
    case BTN_MOVE_X_PLUS:
        break;
    case BTN_MOVE_X_MINUS:
        break;
    case BTN_MOVE_Y_PLUS:
        break;
    case BTN_MOVE_Y_MINUS:
        break;
    case BTN_MOVE_Z_PLUS:
        break;
    case BTN_MOVE_Z_MINUS:
        break;
    case BTN_MOVE_A_PLUS:
        break;
    case BTN_MOVE_A_MINUS:
        break;
    }
    qInfo()<< "----------------------------";
    qInfo()<< request.getBody();
    qInfo()<< "----------------------------";
}

Websocket::TFormButtons Websocket::GetButtonFromRequest(HttpRequest &request){
    TFormButtons ret;

    if(request.getParameter("debugBtn")!=""){
        ret = BTN_DEBUG;
    }else{
        ret = BTN_NONE;
    }

    return ret;
}
