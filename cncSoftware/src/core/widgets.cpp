#include "widgets.h"
#include <QDebug>
#include <QSettings>
Widgets::Widgets(QObject *parent) : QObject(parent){
    qDebug() << "Widgets ready";

}

void Widgets::refreshWidgets(){
    emit refresh();
}
