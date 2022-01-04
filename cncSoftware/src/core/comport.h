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

class Comport : public QObject
{
    Q_OBJECT
signals:
    void receivedCommand(const QByteArray &data);
public:
    /**
      Constructor.
      Creates a Comport handler.
      @param parent Parent object.
    */
    explicit Comport(QObject* parent=nullptr);

    /** Destructor */
    virtual ~Comport();

    /**
     Closes the Comport
    */
    void close();


    QString connectedPortName;
    bool connected;

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

private slots:
    void writeData(const QByteArray &data);
    void readData();
    void handleError(QSerialPort::SerialPortError error);
private:
    QList<QString> portNames;
    QByteArray receivedData;
    QList<QSerialPortInfo> availablePorts = QSerialPortInfo::availablePorts();
    QSerialPort *qserialPort = nullptr;
    QThread *m_thread = nullptr;
};

#endif // COMPORT_H
