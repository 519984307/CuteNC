#ifndef CONTROLLERS_H
#define CONTROLLERS_H

#include <Qt>
#include <QObject>
#include <QCoreApplication>
#include <QWindow>
#include <QString>
#include <QDebug>


class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    //start backend side, load everything
    Q_INVOKABLE void startUp();

    Q_INVOKABLE void debug();
//    Q_INVOKABLE QVariantList getAvaiableSerialPorts();
    Q_INVOKABLE void commandReceived(QString command);
    Q_INVOKABLE QString getJSONFile(QString path, QString filename);

    Q_INVOKABLE void setTheme(QString themeName);
    Q_INVOKABLE QString getThemeName(int position);
    void getAllThemes();
    Q_INVOKABLE int numberOfThemes();
    Q_INVOKABLE void refreshWidgetsInvoker();

    //load jsonsettingsfirst
    void setup();
private:

    void getJsonSettingsFile();
    void updateJsonSettingsFile();

    void setupJsonSettingsFile();
signals:
    void appendPortsToComboBox();
    void getThemes();
    void debugSingal(QString text);
    void refreshWidgets();
};

#endif // CONTROLLERS_H
