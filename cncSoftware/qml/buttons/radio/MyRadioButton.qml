import QtQuick 2.0

Rectangle {
    id: sideButton

    property string text: ""
    property var value: 0.0
    property MyRadioGroup radioGroup

    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor
    property color borderColor


    property int radioButtonHeight
    property int radioButtonWidth

    property bool borderVisible
    property int borderWidth
    property int borderRadius
    property int fontPointSize
    property string fontFamily

    color:  radioGroup.selected == sideButton ? onPressedColor :
                                                (sideButtonMouseArea.containsMouse ? onHoverColor : backgroundColor)

    border.color: borderColor
    border.width: borderVisible ? borderWidth:0
    radius: borderRadius

    width: radioButtonWidth
    height: radioButtonHeight

    Component.onCompleted: {
        var JsonString = backend.getJSONConfigFile("RadioButtonSettings.json");
        var JsonObject = JSON.parse(JsonString);

        //retrieve values from JSON

        borderVisible = JsonObject.borderVisible;
        borderWidth = JsonObject.borderWidth;
        borderRadius = JsonObject.borderRadius;
        textColorLight = JsonObject.colors.textColorLight;
        textColorDark = JsonObject.colors.textColorDark;
        defaultColor = JsonObject.colors.defaultColor;
        onHoverColor = JsonObject.colors.onHoverColor;
        onPressedColor = JsonObject.colors.onPressedColor;
        backgroundColor = JsonObject.colors.backgroundColor;
        borderColor = JsonObject.colors.borderColor;
        fontFamily = JsonObject.fontFamily;
        fontPointSize = JsonObject.fontPointSize;

        radioButtonHeight = JsonObject.radioButtonHeight;
        radioButtonWidth = JsonObject.radioButtonWidth;

    }

    MouseArea {
        id: sideButtonMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: sideButton.radioGroup.selected = sideButton
    }

    Text {
        id: sideButtonLabel
        text: sideButton.text
        font.pointSize: fontPointSize
        font.family: fontFamily
        anchors.centerIn: sideButton
        color: radioGroup.selected == sideButton ? textColorDark : textColorDark
    }

}
