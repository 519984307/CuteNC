#ifndef WEBSOCKET_H
#define WEBSOCKET_H

#include <Qt>
#include <QObject>
#include <QCoreApplication>
#include <QWindow>
#include <QString>
#include <QDebug>
#include "httprequesthandler.h"

using namespace stefanfrings;

class Websocket : public HttpRequestHandler {
    Q_OBJECT
public:
    Websocket(QObject* parent=0);
    void service(HttpRequest& request, HttpResponse& response);
};

#endif // WEBSOCKET_H
