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
    QJsonObject comport = jObject["comport"].toObject();
    this->settingsPtr->selectedTheme = jObject["selectedTheme"].toString();
    if(this->settingsPtr->selectedTheme == "" || this->settingsPtr->selectedTheme == " "){
        this->settingsPtr->selectedTheme = "LightTheme.json";
    }
    this->settingsPtr->appName = jObject["appName"].toString();
    this->settingsPtr->windowTitle = jObject["windowTitle"].toString();
    this->settingsPtr->website = jObject["website"].toString();
    this->settingsPtr->version = jObject["version"].toString();
    this->settingsPtr->height = jObject["height"];
    this->settingsPtr->width = jObject["width"];
    this->settingsPtr->unitsInMetric = jObject["unitsInMetric"];



    this->settingsPtr->baudRate = comport["baudRate"];
    this->settingsPtr->dataBits = comport["dataBits"];
    this->settingsPtr->flowControl = comport["flowControl"];
    this->settingsPtr->parityBits = comport["parityBits"];
    this->settingsPtr->stopBits = comport["stopBits"];

}
void Settings::setThemeName(QString themeName){
    qDebug() << themeName <<"set theme name<";
    this->settingsPtr->selectedTheme = themeName+".json";
}
QString Settings::getThemeName(){
    return this->settingsPtr->selectedTheme.toString();
}

void Settings::setUnits(bool units){
    this->settingsPtr->unitsInMetric = units;
}
bool Settings::getUnits(){
    return this->settingsPtr->unitsInMetric.toBool();
}

void Settings::setLanguage(QString lang){
    this->settingsPtr->language = lang;
}
QString Settings::getLanguage(){
    return this->settingsPtr->language.toString();
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
        mainObj.insert("selectedTheme",backend->getSelectedTheme());
        mainObj.insert("unitsInMetric",backend->getSelectedUnits());
        mainObj.insert("language",backend->getSelectedLanguage());
        QJsonObject comportObj;
        comportObj.insert("baudRate",115200);
        comportObj.insert("dataBits",0);
        comportObj.insert("flowControl",8);
        comportObj.insert("parityBits",1);
        comportObj.insert("stopBits",0);
        mainObj.insert("comport",comportObj);
        QJsonDocument jsonDoc;
        jsonDoc.setObject(mainObj);
        file.write(jsonDoc.toJson());
        file.close();
        qDebug() << jsonDoc;
    }
}
