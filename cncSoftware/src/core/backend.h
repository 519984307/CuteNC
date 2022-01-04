#ifndef CONTROLLERS_H
#define CONTROLLERS_H


#include <Qt>
#include <QObject>
#include <QCoreApplication>
#include <QWindow>
#include <QString>
#include <QDebug>

#include "settings.h"
#include "comport.h"

#define SETTINGS_FILE "settings.xml"

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);


    /** Destructor */
    virtual ~Backend();

    /**
     Closes backend
    */
    void close();

      //start backend side, load everything
    Q_INVOKABLE void startUp();

    Q_INVOKABLE void debug();
    //    Q_INVOKABLE QVariantList getAvaiableSerialPorts();
    Q_INVOKABLE void commandReceived(QString command);
    Q_INVOKABLE QString getJsonFile(QString fileName);

    void setupWebWidget(QString hostAddress, QString port);


    Q_INVOKABLE void setTheme(QString themeName);
    Q_INVOKABLE QString getThemeName(int position);
    void getAllThemes();
    Q_INVOKABLE int numberOfThemes();
    Q_INVOKABLE void refreshWidgetsInvoker();

    //load jsonsettingsfirst
    void setup();
    Q_INVOKABLE QString getSelectedTheme();

    //Q_INVOKABLE void showNotificationInvoker(QString message);
    //Q_INVOKABLE QVariantList getFunctions();

    void getWidgets();

    //Determine which font color (black or white) is better with given color QString
    //returns true if white, false if black is better
    Q_INVOKABLE bool determineFontColor(QString color);

    QString searchFile(QString fileName);
    Settings *m_Settings;
    Q_INVOKABLE Comport *m_Comport;
public slots:
    void handleQuit();
private:


    void getJsonSettingsFile();
    void updateJsonSettingsFile();

    void setupJsonSettingsFile();

signals:
    void appendPortsToComboBox();
    void getThemes();
    void debugSignal(QString text);
    void refreshWidgets();
    void showNotification(QString v_type, QString v_message);
};

#endif // CONTROLLERS_H
