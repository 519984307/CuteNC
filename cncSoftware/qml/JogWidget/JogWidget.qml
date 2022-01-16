import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

import "../buttons"
import "../buttons/radio"

Rectangle {
    id: jogWidget
    color: defaultColor

    border.color: borderColor
    border.width: borderVisible ? borderWidth:0
    radius: borderRadius

    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor
    property color borderColor

    property int spacingBetween


    property int borderWidth
    property int borderRadius
    property int fontPointSize
    property string fontFamily

    property int numberOfRadioBtns
    property var rbTexts: []
    property var rbValues: []

    property string name
    property string value

    Component.onCompleted: {
        var JsonString = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObject = JSON.parse(JsonString);

        //retrieve values from JSON

        borderVisible = JsonObject.borderVisible;
        borderWidth = JsonObject.borderWidth;
        borderRadius = JsonObject.borderRadius;

        textColorLight = JsonObject.colors.textColorLight;
        textColorDark = JsonObject.colors.textColorDark;
        defaultColor = JsonObject.colors.defaultColor;
        onHoverColor = JsonObject.colors.onHoverColor;
        onPressedColor = JsonObject.colors.onPressedColor
        backgroundColor = JsonObject.colors.backgroundColor;
        borderColor = JsonObject.colors.borderColor;

    }

    Rectangle{
        id: jogBtns
        height: 225
        color: textColorLight
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        z: 2
        anchors.topMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:300;width:320}
}
##^##*/
