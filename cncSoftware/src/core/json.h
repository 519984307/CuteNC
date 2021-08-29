#ifndef JSON_H
#define JSON_H


#include <QObject>
class Json : public QObject
{
    Q_OBJECT
public:
    explicit Json(QObject *parent = nullptr);
signals:
    void refresh();
};

#endif // JSON_H
