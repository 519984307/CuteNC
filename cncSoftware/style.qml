// style.qml
pragma Singleton
import QtQuick 2.0

QtObject {
    id: style
    property bool isLightOrDark: true
    property color mybackgroundColor: "#313131"
    readonly property string mybackgroundColor2: "#1f1f1f"
    readonly property string mytextColor: "#eeeeee"
    readonly property string myaccentColor: "#673AB7"

    readonly property string myRedColor: "#8A1616"
    readonly property string myYellowColor: "#f6c90e"
    readonly property string myGreenColor: "#23D723"


    readonly property string myWhiteTextColor: "#eeeeee"


    readonly property string myQuitIco: "\uE814"
    readonly property string fontFamilyIco: "fontello"



    function changeStyle(){
        if(isLightOrDark){
            mybackgroundColor = "#313131"
        }else{
            mybackgroundColor = "#ffffff"
        }
    }


}
