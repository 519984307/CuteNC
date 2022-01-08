#include "settings.h"
#include "../global.h"

using namespace CuteNC;

Settings::Settings(const Backend *backend) : QObject()
{
    qDebug() << "Settings initialized";
    settingsPtr = new ApplicationSettings();
    this->backend = backend;
    connect(backend, SIGNAL(signal_SaveSettings()), this, SLOT(SaveSettings()));
    connect(backend, SIGNAL(signal_LoadSettings()), this, SLOT(LoadSettings()));
}
Settings::~Settings()
{
    close();
    qDebug("Settings: destroyed");
}

void Settings::close() {
   // SaveSettings();
    qDebug("Settings: closed");
    //clear data
}


void Settings::slotDebug(){
    qDebug() << "slot debug";
}

void Settings::LoadSettings(){
    qDebug() << "Loading settings file";
    QString pathToFile = backend->getSettingsFilePath();
    QFile file;
    QString result;
    QDir dir;

    //if file doesn't exist > create new one with default settings
    if(!dir.exists(pathToFile)){
        SaveSettings();
    }

    file.setFileName(pathToFile);

    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "failed to open file" << file.fileName() << file.errorString() << file.error();
        qDebug() << pathToFile;
    }else{
        qDebug() << "Success reading json Settings file";
        QTextStream file_text(&file);
        result = file.readAll();
        file.close();
    }

    settingsJsonDocument = QJsonDocument::fromJson(result.toUtf8());
    QJsonObject jObject = settingsJsonDocument.object();

    this->settingsPtr->defaultTheme = jObject["defaultTheme"].toString();
    if(this->settingsPtr->defaultTheme == "" || this->settingsPtr->defaultTheme == " "){
        this->settingsPtr->defaultTheme = "LightTheme.json";
    }
    this->settingsPtr->appName = jObject["appName"].toString();
    this->settingsPtr->windowTitle = jObject["windowTitle"].toString();
    this->settingsPtr->website = jObject["website"].toString();
    this->settingsPtr->version = jObject["version"].toString();
    this->settingsPtr->height = jObject["height"];
    this->settingsPtr->width = jObject["width"];
    qDebug() << this->settingsPtr->defaultTheme;
    qDebug() << this->settingsPtr->appName;
    qDebug() << this->settingsPtr->windowTitle;

    qDebug() << this->settingsPtr->website;
    qDebug() << this->settingsPtr->version;
    qDebug() << this->settingsPtr->height;
    qDebug() << this->settingsPtr->width;
}
QString Settings::getThemeName(){
    return this->settingsPtr->defaultTheme.toString();
}
void Settings::SaveSettings(){
    qDebug() << "Saving settings file";
    QString pathToFile = backend->getSettingsFilePath();

    QDir dir;

    if(!dir.exists(pathToFile)){
        dir.mkpath(pathToFile);
    }

    QFile file(pathToFile);
    if(!file.open(QIODevice::ReadWrite)) {
        qDebug() << "failed creating file" << file.fileName() << file.errorString() << file.error();
    } else {
        qDebug() <<"file created! "+pathToFile;

        file.resize(0);

        QJsonObject mainObj;
        mainObj.insert("appName","CuteNC");
        mainObj.insert("title","CNC Controller");
        mainObj.insert("website","feew.dev");
        mainObj.insert("version",QString::fromUtf8(getCuteNCVersion()));
        mainObj.insert("height",800);
        mainObj.insert("width",1200);
        mainObj.insert("defaultTheme",backend->getSelectedTheme());
        QJsonDocument jsonDoc;
        jsonDoc.setObject(mainObj);
        file.write(jsonDoc.toJson());
        file.close();
        qDebug() << jsonDoc;
    }

}
