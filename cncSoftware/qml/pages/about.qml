import QtQuick 2.0
import QtQuick.Controls 2.15

import QtQuick 2.15
import QtQuick.Window 2.15

import QtQuick.Extras 1.4
import QtQuick.Window 2.12

import QtGraphicalEffects 1.15
import QtQuick.Timeline 1.0

import QtQuick.Controls.Material 2.15

import "../components"
Item {
    id: aboutPage
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
    property color backgroundColor
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
        var JsonString = backend.getJsonFile("TemplateFile.json");
        var JsonObject = JSON.parse(JsonString);

        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        backgroundColor = JsonObjectTheme.backgroundColor;

        //retrieve values from JSON
        name = JsonObject.name;
        value = JsonObject.value;

        borderVisible = JsonObject.borderVisible;
        borderWidth = JsonObject.borderWidth;
        borderRadius = JsonObject.borderRadius;

        textColorLight = JsonObject.colors.textColorLight;
        textColorDark = JsonObject.colors.textColorDark;
        defaultColor = JsonObject.colors.defaultColor;
        onHoverColor = JsonObject.colors.onHoverColor;
        onPressedColor = JsonObject.colors.onPressedColor

        borderColor = JsonObject.colors.borderColor;

        setWidth = JsonObject.width;
        setHeight = JsonObject.height;
        minimumWidth = JsonObject.minimumWidth;
        minimumHeight = JsonObject.minimumHeight;
        maximumWidth = JsonObject.maximumWidth;
        maximumHeight = JsonObject.maximumHeight;
        setMaximumSize = JsonObject.setMaximumSize;
        setMinimumSize = JsonObject.setMinimumSize;
        fontAwesomeIcon = JsonObject.fontAwesomeIcon;
        text = JsonObject.text;

    }

    Rectangle{
        id:background
        color: backgroundColor
        anchors.fill:parent

        Component.onCompleted: {
            jsonSettings()
        }

        Image {
            id: image
            x: 240
            width: 200
            height: 200
            anchors.top: parent.top
            source: "../../data/images/logo/logo1.svg"
            anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit


            MouseArea {
                id: mouseArea2
                anchors.fill:parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://feew.dev/")
            }

        }
        ColorOverlay{
            source: image
            antialiasing: true
            anchors.fill:image
            color:textColorDark
        }


        Image {
            id: imageKoFi
            x: 240
            width: 200
            height: 40
            anchors.top: image2.bottom
            source: "../../data/images/ko-fi/BuyMeACoffee_dark@2x.png"
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit


            MouseArea {
                id: mouseArea3
                anchors.fill:parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://ko-fi.com/I3I17I6WR")
            }

        }


        Label {
            id: text1
            x: 389
            text: "Designed & Created by Szymon lach"
            anchors.top: image.bottom
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Noto Sans"
            textFormat: Text.RichText
            anchors.topMargin: 25
            color:textColorDark
        }

        Label {
            id: text2
            x: 389
            text: "Copyright © 2021"
            anchors.top: text1.bottom
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Noto Sans"
            textFormat: Text.RichText
            anchors.topMargin: 10
            color:textColorDark
        }

        Image {
            id: image2
            x: 300
            y: 378
            width: 200
            height: 100
            anchors.top: text2.bottom
            source: "../../data/images/githublogo/logo.png"
            anchors.topMargin: 20
            antialiasing: true
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            smooth: true




            MouseArea {
                id: mouseArea
                anchors.fill:parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://github.com/xFeew")
            }
        }
        ColorOverlay{
            source:image2
            anchors.fill:image2
            color:textColorDark
        }


        //Add new element (widget)

    }

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }
}



/*##^##
Designer {
    D{i:0;height:0}D{i:3}D{i:2}D{i:4}D{i:6}D{i:5}D{i:7}D{i:8}D{i:10}D{i:9}D{i:11}D{i:1}
D{i:12}
}
##^##*/
