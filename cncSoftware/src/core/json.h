#ifndef JSON_H
#define JSON_H


#include <QObject>
class Json : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void createMacro(QString macroName);
    void updateMacro(QString macroName);
signals:
    void refresh();
};

#endif // JSON_H
