import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../components"
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

        borderVisible = JsonObjectTheme.borderVisible;
        borderWidth = JsonObjectTheme.borderWidth;
        borderRadius = JsonObjectTheme.borderRadius;

        textColorLight = JsonObjectTheme.colors.textColorLight;
        textColorDark = JsonObjectTheme.colors.textColorDark;
        defaultColor = JsonObjectTheme.colors.defaultColor;
        onHoverColor = JsonObjectTheme.colors.onHoverColor;
        onPressedColor = JsonObjectTheme.colors.onPressedColor

        borderColor = JsonObjectTheme.colors.borderColor;

        setWidth = JsonObjectTheme.width;
        setHeight = JsonObjectTheme.height;
        minimumWidth = JsonObjectTheme.minimumWidth;
        minimumHeight = JsonObjectTheme.minimumHeight;
        maximumWidth = JsonObjectTheme.maximumWidth;
        maximumHeight = JsonObjectTheme.maximumHeight;
        setMaximumSize = JsonObjectTheme.setMaximumSize;
        setMinimumSize = JsonObjectTheme.setMinimumSize;
        fontAwesomeIcon = JsonObjectTheme.fontAwesomeIcon;
        text = JsonObjectTheme.text;

    }


    property string selectedTheme
    function getThemeNames() {
        model.clear()
        for(var i = 0; i < backend.numberOfThemes();i++){
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

        ComboBox {
            id: comboBox
            x: 8
            y: 8
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
            x: 166
            y: 8
            text: qsTr("Set Selected")

            anchors.topMargin: 20
            anchors.leftMargin: 20
            onClicked:{                            
                backend.setTheme(selectedTheme)
                backend.refreshWidgetsInvoker();
                backend.showNotification(qsTr("confirm"),qsTr("Theme set!"))
                settingsPage.parent.reload();
            }
        }


    }

    Connections{
        target: backend
        function onGetThemes(){
            getThemeNames()
        }
        function onRefreshWidgets(){
            jsonSettings()
        }
    }
    Component.onCompleted: {
        getThemeNames()
    }
}


