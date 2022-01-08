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

    property bool setMaximumSize
    property bool setMinimumSize
    property bool borderVisible

    property int minimumWidth: 320
    property int minimumHeight: 300
    property int maximumWidth: 320
    property int maximumHeight: 300

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
        var JsonString = backend.getJSONFile("../json/","JogWidgetSettings.json");
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



      //  spacingBetween = JsonObject.spacingBetween;

//        for (var i = 0; i < JsonObject.repository.length; i++) {
//            rbTexts[i] = JsonObject.repository[i].text
//            rbValues[i] = JsonObject.repository[i].value
//        }

       // numberOfRadioBtns = JsonObject.repository[JsonObject.repository.length-1].id;
    }

    width: 320
    height: 260

    function setWidgetSize(){
        if(setMinimumSize == true){
            if(this.width < minimumWidth){
                this.width = minimumWidth
            }
            if(this.height < minimumHeight){
                this.height = minimumHeight
            }
        }
        if(setMaximumSize == true){
            if(this.width > maximumWidth){
                this.width = maximumWidth
            }
            if(this.height > maximumHeight){
                this.height = maximumHeight
            }
        }
    }
    onWidthChanged: {setWidgetSize()}
    onHeightChanged: {setWidgetSize()}

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


    Rectangle{
        id: jogSettings
        height: 100
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: jogBtns.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0



        MyRadioGroup {
            id: radioGroup1
            //selected by default
            Component.onCompleted: {
                radioGroup1.selected = repeaterVer.itemAt(0)
            }
        }

        Row{
            id: row
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.topMargin: 5

            spacing: spacingBetween

            Repeater{
                id:repeaterVer
                model: numberOfRadioBtns
                MyRadioButton {
                        text: rbTexts[index]
                        value: rbValues[index]
                        radioGroup: radioGroup1
                    }
                }
            }

        }
    }

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:300;width:320}
}
##^##*/
