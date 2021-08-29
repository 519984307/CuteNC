#include "json.h"
#include <QDebug>
Json::Json(QObject *parent) : QObject(parent){
    qDebug() << "Json ready";
}

