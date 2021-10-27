#include "websocket.h"
#include "../global.h"

#include <QHostAddress>
#include <QDebug>

Websocket websocket;

Websocket::Websocket(QObject *parent) : HttpRequestHandler(parent) {
    // empty
    console.debug();
}


void Websocket::service(HttpRequest &request, HttpResponse &response) {
    response.write("Hello World",true);
    QByteArray q_b;
    int i;
    for(i= 0; i <= 100; i++){
        q_b.setNum(i);
        response.write(q_b,true);
        if(i == 100){
            i = 0;
        }
    }

}
