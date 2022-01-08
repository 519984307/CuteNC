#ifndef COMPORT_H
#define COMPORT_H

#include <Qt>
#include <QObject>
#include <QString>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QThread>
#include <QTimer>

#include <QByteArray>

#include "console.h"

class Comport : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Comport)
signals:
    void receivedCommand(const QByteArray &data);
public:
    /**
      Constructor.
      Creates a Comport handler.
      @param parent Parent object.
    */
    explicit Comport(QObject* parent = nullptr, Console *console = nullptr);

    /** Destructor */
    virtual ~Comport();

    /**
     Closes the Comport
    */
    void close();

    /**
     Gets available ports
    */
    void startUp();


    QString connectedPortName;
    bool connected;

    Q_INVOKABLE void openSerialPort(QString serialPort);
    Q_INVOKABLE void closeSerialPort();
    Q_INVOKABLE void getAvailablePorts();
    Q_INVOKABLE void debug();
    Q_INVOKABLE int numberOfAvailablePorts();
    Q_INVOKABLE QString getPortName(int position);
    Q_INVOKABLE void connectionError(QString message);
    //QList<QString> getPortNames();



    //send data to device (comport)
    void write(QString command);

    //display comport info into console
    void portInfo();

    //get ports.at(o) o - number
    int getPortPos();
    bool eom();

private slots:
    void writeData(const QByteArray &data);
    void readData();
    void handleError(QSerialPort::SerialPortError error);
private:

    Console *m_Console;

    QSerialPort *qserialPort = nullptr;
    QThread *m_Thread = nullptr;
signals:
    void signal_ReadyForNextCommand();

    void signal_OpenPort();
    void signal_ClosePort();

    void signal_GetPorts();
};

#endif // COMPORT_H
