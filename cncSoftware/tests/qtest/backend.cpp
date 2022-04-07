#include "backend.h"

Backend::Backend(QObject *parent){

}

QString Backend::getGcodeFile(){
    return loadedFile;
}
void Backend::setupFile(QString fileContent){
    loadedFile = "";
    loadedFile = fileContent;
}

////Getting and setting a color theme
void Backend::setTheme(QString themeName){
   // m_Settings->setThemeName(themeName);
    selectedThemeName = themeName+".json";
   // emit signal_RefreshWidgets();
}
//QString Backend::getSelectedTheme() const{
//    return m_Settings->getThemeName();
//}

////Getting and setting units
//void Backend::setUnits(bool units){
//    m_Settings->setUnits(units);
//    emit signal_RefreshWidgets();
//}
//bool Backend::getSelectedUnits() const{
//    return m_Settings->getUnits();
//}

////Getting and setting language
//void Backend::setLanguage(QString lang){
//    m_Settings->setLanguage(lang);
//    emit signal_RefreshWidgets();
//}
//QString Backend::getSelectedLanguage() const{
//    return m_Settings->getLanguage();
//}

//Determine which font color (black or white) is better with given color(ex. background color) QString
//returns true if white, false if black is better
bool Backend::determineFontColor(QString color){
    int threshold = 149; //186
    QChar colorArray[color.length()];
    QString sRed,sGreen,sBlue;
    double r,g,b;
    bool ok;

    for(int i = 0; i < color.length(); i++){
        colorArray[i] = color.at(i);
    }

    sRed = colorArray[1];
    sRed += colorArray[2];
    sGreen = colorArray[3];
    sGreen += colorArray[4];
    sBlue = colorArray[5];
    sBlue += colorArray[6];

    r = static_cast<double>(sRed.toInt(&ok, 16));
    g = static_cast<double>(sGreen.toInt(&ok, 16));
    b = static_cast<double>(sBlue.toInt(&ok, 16));


    if(((r*0.299 + g*0.587 + b*0.114) > threshold)){
        return 0;
    }else{
        return 1;
    }
}
