#ifndef CONSOLE_H
#define CONSOLE_H

#include <Qt>
#include <QObject>
#include <QString>
#include <QDebug>

class Console : public QObject
{
     Q_OBJECT


signals:
    void getData(const QByteArray &data);

public:

    explicit Console(QObject *parent = nullptr);

    //get consoleLog message details
    Q_INVOKABLE QString getType(int position);
    Q_INVOKABLE QString getSource(int position);
    Q_INVOKABLE QString getMessage(int position);
    Q_INVOKABLE QString getTime(int position);
    Q_INVOKABLE QString getTextColor(int position);


    //delete items in console
    Q_INVOKABLE void clearConsole();


    Q_INVOKABLE int countMessages();
    Q_INVOKABLE void debug();
    void displayMessages();
    //create new message
    Q_INVOKABLE void log(QString type, QString source, QString message);
    Q_INVOKABLE void log(QString type, QString source, QString message, QString textColor);
    void refreshConsoleDummy();

private:

public slots:
    void displayEachSecond();

signals:
    void refreshConsole();
    void consoleDebug(QString text);


};
#endif // CONSOLE_H
