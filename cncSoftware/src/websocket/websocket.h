#ifndef WEBSOCKET_H
#define WEBSOCKET_H

#include <Qt>
#include <QObject>
#include <QCoreApplication>
#include <QWindow>
#include <QString>
#include <QDebug>
#include "httplistener.h"
#include "httprequesthandler.h"
#include "staticfilecontroller.h"
#include "../core/axiscontroller.h"
using namespace stefanfrings;

extern StaticFileController* staticFileController;

class Websocket : public HttpRequestHandler {
    Q_OBJECT
public:
    explicit Websocket(QObject* parent=0,AxisController *axisController=nullptr);
    void service(HttpRequest& request, HttpResponse& response);
protected:
    void serviceIndex(HttpRequest &request, HttpResponse &response);
signals:
    void signal_RequestCommand(QString command,QString type);
private:
    AxisController *m_AxisController;
    QSettings m_settings;
    HttpListener* m_pListener;
    StaticFileController *m_pStaticFileCtrl;
};


#endif // WEBSOCKET_H
