#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>

class Backend
{
public:
    explicit Backend(QObject *parent = nullptr);

    Q_INVOKABLE void setUnits(bool units);
    Q_INVOKABLE bool getSelectedUnits() const;

    Q_INVOKABLE void setLanguage(QString lang);
    Q_INVOKABLE QString getSelectedLanguage() const;
    void setTheme(QString themeName);
    /** Returns true if 'white' color suits the best for passed parameter color. @param color is the color to determine.*/
    Q_INVOKABLE bool determineFontColor(QString color);

    /** load file to memory from gcode editor */
    Q_INVOKABLE void setupFile(QString fileContent);
    Q_INVOKABLE QString getGcodeFile();

    QString loadedFile;
    QString selectedThemeName;
    private:
       // QString loadedFile;
};

#endif // BACKEND_H
