#ifndef WEBSOCKET_H
#define WEBSOCKET_H

#include <Qt>
#include <QObject>
#include <QCoreApplication>
#include <QWindow>
#include <QString>
#include <QDebug>

#include <QTcpSocket>
#include <QTcpServer>

class Websocket : public QObject
{
    Q_OBJECT
public:
    explicit Websocket(QObject *parent = nullptr);
    void websocketSetup();
private:
    void createWebserver();

    // QTcpServer class provides a TCP-based server.
    QTcpServer tcpServer;
    QTcpSocket tcpClient;
    QTcpSocket *tcpServerConnection;

    int bytesToWrite;
    int bytesWritten;
    int bytesReceived;
};

#endif // WEBSOCKET_H
