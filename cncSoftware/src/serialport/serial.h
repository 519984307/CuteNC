#ifndef SERIAL_H
#define SERIAL_H

#include <Qt>
#include <QObject>
#include <QString>
#include <QSerialPort>
#include "src/console/console.h"

class Comport : public QObject
{
     Q_OBJECT
signals:
    void receivedCommand(const QByteArray &data);
public:
    QString connectedPortName;
    bool connected;
    explicit Comport(QObject *parent = nullptr);
    Q_INVOKABLE void openSerialPort(QString serialPort);
    Q_INVOKABLE void closeSerialPort();
    Q_INVOKABLE void getAvailablePorts();
    Q_INVOKABLE void debug();
    Q_INVOKABLE int numberOfAvaiablePorts();
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

    /** Destructor */
    virtual ~Comport();

    /** Closes Comport */
    void close();

private slots:
    void writeData(const QByteArray &data);
    void readData();
    void handleError(QSerialPort::SerialPortError error);
private:
    QSerialPort *qserialPort = nullptr;
    Console *qconsole = new Console;
    QThread *m_thread = nullptr;
};

#endif // SERIAL_H
