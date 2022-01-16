import QtQuick 2.0
import QtQuick.Controls 2.15

import QtQuick 2.15
import QtQuick.Window 2.15

import QtQuick.Extras 1.4
import QtQuick.Window 2.12

import QtGraphicalEffects 1.15
import QtQuick.Timeline 1.0

import QtQuick.Controls.Material 2.15
import "../qml/components/"
Window {

    id: window
    width: rectangle.width+50
    height: 410
    visible: true
    color: "#00000000"
    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    QtObject{
        id: internal
        function openMainWindow(){
            mainWindowdropshadow.visible = false
            win.show()
        }
        function closeWindow(){
            window.close()
        }
    }

    Component.onCompleted: {
        visible = true
        spinAnimation.start();
    }

    DropShadow{
        id:mainWindowdropshadow
        anchors.fill: rectangle
        source: rectangle
        visible: true
        verticalOffset:  0
        horizontalOffset: 0
        radius: 10
        color: "#000000"
        z:0
    }

    Item{
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    Rectangle {
        id: rectangle
        x: 155
        y: 211
        z: 2
        width: 360
        height: 360
        opacity: 1
        visible: true
        radius: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter


        Material.theme: Material.Light

        Label {
            id: author
            y: 535
            opacity: 1
            visible: true
            text: qsTr("Designed & Created by Szymon Lach")
            font.family: "Noto Sans"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 10
            MouseArea {
                width: author.width
                height: author.height
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://feew.dev")
            }
        }

        Label {
            id: loadingLbl
            opacity: 1
            visible: true
            text: qsTr("Loading...")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 16

        }



        Image {
            id: spin6
            width: 100
            height: 100
            anchors.verticalCenter: parent.verticalCenter 
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../data/images/spin6.svg"
            antialiasing: true
            enabled: false
            cache: false
            smooth: false
            sourceSize.height: 100
            sourceSize.width: 100

            RotationAnimation on rotation{
                id:spinAnimation
                loops: Animation.Infinite
                from: 0
                to: 360
            }
        }

    }
    }

    }




/*##^##
Designer {
    D{i:0;formeditorZoom:2}D{i:1}D{i:2}D{i:4}D{i:3}
}
##^##*/
