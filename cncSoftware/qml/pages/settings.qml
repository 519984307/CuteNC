import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../components"
import QtQuick.Layouts 1.11
Item {
    id: settingsPage
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


    property string selectedTheme
    function getThemeNames() {
        model.clear()
        for(var i = 0; i < backend.numberOfThemes();i++){
            console.log(backend.getThemeName(i));
            model.append({text: backend.getThemeName(i).replace(".json","")})
        }
    }
    Rectangle{
        id:background
        color: backgroundColor
        anchors.fill:parent

        Component.onCompleted: {
            jsonSettings()
        }

        TabBar {
            id: bar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            TabButton {
                text: qsTr("Theme")
                width: implicitWidth

            }
            TabButton {
                text: qsTr("Connection")
                width: implicitWidth
            }
            TabButton {
                text: qsTr("Misc")
                width: implicitWidth
            }
        }

        StackLayout {
            id: stackLayout
            width: 800
            anchors.top: bar.bottom
            anchors.topMargin: 0
            currentIndex: bar.currentIndex
            Item {
                id: themeTab

                ScrollView {
                    id: scrollView
                    anchors.fill: parent

                    Rectangle{
                        id: rectangle
                        anchors.fill:parent
                        anchors.topMargin: bar.top
                        ComboBox {
                            id: comboBox
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 20
                            anchors.topMargin: 20
                            model: ListModel {
                                id: model
                            }

                            onCurrentValueChanged: {
                                selectedTheme = currentText;
                            }

                        }
                        //Add new element (widget)
                        Button {
                            id: button
                            text: qsTr("Set Selected")
                            anchors.left: comboBox.right
                            anchors.top: parent.top

                            anchors.topMargin: 20
                            anchors.leftMargin: 20
                            onClicked:{
                                backend.setTheme(selectedTheme)
                                backend.refreshWidgetsInvoker();
                                backend.showNotification("confirm",qsTr("Theme set!"))
                                settingsPage.parent.reload();
                            }
                        }


                    }
                }
            }
            Item {
                id: connectionTab
            }
            Item {
                id: miscTab
            }
        }


    }

    Connections{
        target: backend
        function onSignal_GetThemes(){
            getThemeNames()
        }
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
    }
    Component.onCompleted: {
        getThemeNames()
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:1000}D{i:3}D{i:4}D{i:5}D{i:2}D{i:10}D{i:12}D{i:9}
D{i:8}D{i:7}D{i:13}D{i:14}D{i:6}D{i:1}D{i:15}
}
##^##*/
