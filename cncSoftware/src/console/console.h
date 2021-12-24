#ifndef CONSOLE_H
#define CONSOLE_H

#include <Qt>
#include <QObject>
#include <QString>
#include <QDebug>
/**
  The console is used to display messages send or received to host and device.
*/
class Console : public QObject
{
     Q_OBJECT


signals:
    /**
      Get array of bytes of data.
      @param data is the data that's send to host from a device.
    */
    void getData(const QByteArray &data);

public:
    /**
      Constructor.
    */
    explicit Console(QObject *parent = nullptr);

    /** Get type returns the type of a message. */
    Q_INVOKABLE QString getType(int position);
    /** Get source returns the source of a message. */
    Q_INVOKABLE QString getSource(int position);
    /** Get message returns the message. */
    Q_INVOKABLE QString getMessage(int position);
    /** Get time returns the time message was created. */
    Q_INVOKABLE QString getTime(int position);
    /** Get text color returns color of the message. */
    Q_INVOKABLE QString getTextColor(int position);


    /** Clears the console. */
    Q_INVOKABLE void clearConsole();

    Q_INVOKABLE int countMessages();
    Q_INVOKABLE void debug();
    void displayMessages();


    /** log function, creates and sends a message to console output.
        @param type is a string representing type of a message with corresponding color defined in theme, type can only be: info, error, warning, debug, log.
        @param source is a string representing from where a message was sent eg. backend, comport.
        @param message is a string that can be anything.
    */
    Q_INVOKABLE void log(QString type, QString source, QString message, QString textColor = nullptr);
    void refreshConsoleDummy();

private:

public slots:
    void displayEachSecond();

signals:
    void refreshConsole();
    void consoleDebug(QString text);
    void sendToConsole(QString time, QString type, QString source, QString message, QString textColor);


};
#endif // CONSOLE_H
