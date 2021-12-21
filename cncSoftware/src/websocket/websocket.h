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


using namespace stefanfrings;
extern StaticFileController* staticFileController;

class Websocket : public HttpRequestHandler {
    Q_OBJECT
public:
    explicit Websocket(QObject* parent=0);
    void service(HttpRequest& request, HttpResponse& response);
protected:
    typedef enum{
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
    }TFormButtons;

    TFormButtons GetButtonFromRequest(HttpRequest& request);
    void serviceIndex(HttpRequest &request, HttpResponse &response);

private:
    QSettings m_settings;
    HttpListener* m_pListener;
    StaticFileController *m_pStaticFileCtrl;
};


#endif // WEBSOCKET_H
