import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../components"
import "../GCodeMacros"
import "../ConsoleWidget"
import "../ConnectionWidget"
import "../DROWidget"
Item {
    id: homePage
    width: 800
    height: 600


    property int setWidth
    property int setHeight
    property int minimumWidth
    property int minimumHeight
    property int maximumWidth
    property int maximumHeight
    property bool setMaximumSize
    property bool setMinimumSize
    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor: "white"
    property color borderColor

    property bool borderVisible
    property int borderWidth
    property int borderRadius

    property int fontPointSize
    property string fontFamily

    property string fontAwesomeIcon
    property string text
    property string name
    property string value


    function jsonSettings(){
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        backgroundColor = JsonObjectTheme.backgroundColor;

    }

    Rectangle{
        id:background
        color: backgroundColor
        anchors.fill:parent
//CONTENT


        GCodeMacros{
            id:macros
            width: 200
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.rightMargin: 0
        }

        ConnectionWidget{
            id:connectionWidget
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.leftMargin: 0
        }
        Rectangle{
            id: consoleWidget
            anchors.left: parent.left
            anchors.right: macros.left
            anchors.top: droWidget.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            Loader {
                id:consoleLoader
                anchors.fill:parent;
                }
        }
        DROWidget{
            id: droWidget
            width: 300
            height: 200
            anchors.left: parent.left
            anchors.top: connectionWidget.bottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
        }



//ENDOF CONTENT




    }
    Connections{
        target: backend
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
        function onSignal_Ready(){
            consoleLoader.source = "qrc:/qml/ConsoleWidget/ConsoleWidget.qml";
        }
    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:800;width:1200}D{i:2}D{i:3}D{i:4}D{i:5}D{i:1}D{i:6}
}
##^##*/
