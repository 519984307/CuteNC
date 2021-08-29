#include "widgets.h"
#include <QDebug>
Widgets::Widgets(QObject *parent) : QObject(parent){
    qDebug() << "Widgets ready";
}

void Widgets::refreshWidgets(){
    emit refresh();
}
