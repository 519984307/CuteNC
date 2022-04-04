#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QList>
#include <QString>
#include <QProcess>
#include <QFile>
#include <QDir>

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QVariantMap>

#include <QDebug>

#include "backend.h"

namespace CuteNC{

class Settings : public QObject{
    Q_OBJECT
    Q_DISABLE_COPY(Settings)
public:
    explicit Settings(const Backend* backend);

    /** Destructor */
    virtual ~Settings();

    /**
     Closes Settings.
    */
    void close();

    QString getThemeName();
    void setThemeName(QString themeName);

    bool getUnits();
    void setUnits(bool units);

    QString getLanguage();
    void setLanguage(QString lang);

private:
    const Backend* backend;

    struct ApplicationSettings {

        /** Initial application window width */
        QJsonValue width;

        /** Initial application window height */
        QJsonValue height;

        /** Initial application theme */
        QJsonValue selectedTheme;

        /** Application version */
        QJsonValue version;

        /** Application name */
        QJsonValue appName;

        /** Author website */
        QJsonValue website;

        /** Window title */
        QJsonValue windowTitle;

        /** Metric system */

        QJsonValue unitsInMetric;
        /** Selected language */

        QJsonValue language;

        /** Baud rate */
        QJsonValue baudRate;

        /** Parity bits */
        QJsonValue parityBits;

        /** Data bits */
        QJsonValue dataBits;

        /** Stop bits */
        QJsonValue stopBits;

        /** Flow control */
        QJsonValue flowControl;
    };

    /** Pointer to the shared settings. */
    ApplicationSettings *settingsPtr;
protected:
    QJsonDocument settingsJsonDocument;

public slots:
    void LoadSettings();
    void SaveSettings();
    void slotDebug();
};

}


#endif // SETTINGS_H
