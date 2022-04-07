#ifndef WIDGETS_H
#define WIDGETS_H

#include <QObject>

class Widgets : public QObject
{
    Q_OBJECT
public:
    explicit Widgets(QObject *parent = nullptr);
    Q_INVOKABLE void refreshWidgets();
signals:
    void refresh();
};

#endif // WIDGETS_H
