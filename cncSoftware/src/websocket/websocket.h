#ifndef WEBSOCKET_H
#define WEBSOCKET_H

#include <Qt>
#include <QObject>
#include <QCoreApplication>
#include <QWindow>
#include <QString>
#include <QDebug>
#include "httprequesthandler.h"
#include "staticfilecontroller.h"

using namespace stefanfrings;
extern StaticFileController* staticFileController;

class Websocket : public HttpRequestHandler {
    Q_OBJECT
public:
    Websocket(QObject* parent=0);
    void service(HttpRequest& request, HttpResponse& response);
protected:
    typedef enum{
        FB_NONE,
        FB_DEBUG,
    }TFormButtons;

    TFormButtons GetButtonFromRequest(HttpRequest& request);
    void serviceIndex(HttpRequest &request, HttpResponse &response);
};

#endif // WEBSOCKET_H
