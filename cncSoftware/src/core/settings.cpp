#include "settings.h"
#include <QXmlStreamWriter>

Settings::Settings(QObject *parent) :
    QObject(parent)
{

}

void Settings::LoadSettings(QString fileName)
{
    QFile file(fileName);

    QXmlStreamReader xmlReader(&file);

    while (!xmlReader.atEnd()) {
          xmlReader.readNext();
          qDebug() << xmlReader.text();

    }
    if (xmlReader.hasError()) {

    }

}
