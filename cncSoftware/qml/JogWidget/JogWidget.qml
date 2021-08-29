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

    property bool setMaximumHeight: false
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
        var JsonString = backend.getJSONConfigFile("JogWidgetSettings.json");
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



        spacingBetween = JsonObject.spacingBetween;

        for (var i = 0; i < JsonObject.repository.length; i++) {
            rbTexts[i] = JsonObject.repository[i].text
            rbValues[i] = JsonObject.repository[i].value
        }

        numberOfRadioBtns = JsonObject.repository[JsonObject.repository.length-1].id;
    }

    width: 320
    height: 260

    function setWidgetSize(){
        if(templateWidget.width < minimumWidth){
            templateWidget.width = minimumWidth
        }
        if(templateWidget.height < minimumHeight){
            templateWidget.height = minimumHeight
        }

        if(setMaximumHeight == true){
            if(templateWidget.width > maximumWidth){
                templateWidget.width = maximumWidth
            }
            if(templateWidget.height > maximumHeight){
                templateWidget.height = maximumHeight
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

        Grid {
            id: grid
            anchors.fill: parent
            z: 8

            Column {
                id: c1
                width: 64
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                z: 9
                anchors.leftMargin: 5
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                Row{
                    id: r1
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: xminusyplus
                        anchors.fill: parent
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        rotationAngle: -45
                        axisLabel: "X- Y+"

                    }
                }
                Row{
                    id: r2
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: r1.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: xminus
                        anchors.fill: parent
                        rotationAngle: -90
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        axisLabel: "X-"

                    }
                }
                Row{
                    id: r3
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: r2.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: xminusyminus
                        width: 64
                        height: 64
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        rotationAngle: -135
                        axisLabel: "X- Y-"
                    }
                }

            }
            Column {
                id: c2
                width: 64
                anchors.left: c1.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                Row{
                    id: r4
                    width: 64
                    height: 64
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: yplus
                        anchors.fill: parent
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                    }
                }
                Row{
                    id: r5
                    width: 64
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: r4.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                }
                Row{
                    id: r6
                    x: 0
                    height: 64
                    anchors.top: r5.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: yminus
                        width: 64
                        height: 64
                        text: "Y-"
                        rotationAngle: 180
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        axisLabel: "Y-"
                    }
                }

            }
            Column {
                id: c3
                width: 64
                anchors.left: c2.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                Row{
                    id: r7
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: xplusyplus
                        width: 64
                        height: 64
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        rotationAngle: 45
                        axisLabel: "X+ Y+"
                    }
                }
                Row{
                    id: r8
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: r7.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: xplus
                        width: 64
                        height: 64
                        rotationAngle: 90
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        axisLabel: "X+"

                    }
                }

                Row{
                    id: r9
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: r8.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: xplusyminus
                        width: 64
                        height: 64
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        rotationAngle: 135
                        axisLabel: "X+ Y-"
                    }
                }


            }
            Column {
                id: c4
                width: 64
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 5
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                Row{
                    id: r10
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: zplus
                        width: 64
                        height: 64
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        axisLabel: "Z+"

                    }
                }
                Row{
                    id: r11
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: r10.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                }
                Row{
                    id: r12
                    height: 64
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: r11.bottom
                    anchors.topMargin: 5
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    spacing: 4
                    MoveXYZBtn {
                        id: zminus
                        width: 64
                        height: 64
                        text: "Y-"
                        btnIcon: "../../res/images/arrow-up-solid.svg"
                        axisLabel: "Z-"
                        rotationAngle: 180
                    }
                }

            }
        }
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
