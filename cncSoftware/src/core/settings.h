#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QList>
#include <QString>
#include <QProcess>
#include <QXmlStreamReader>
#include <QXmlStreamWriter>
#include <QFile>

#include <QDebug>

class Settings : public QObject
{
    Q_OBJECT
public:
    explicit Settings(QObject *parent = 0);

    void LoadSettings(QString fileName);
protected:

};

#endif // SETTINGS_H
