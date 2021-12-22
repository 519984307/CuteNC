import QtQuick 2.0
import QtQuick.Window 2.12
import QtGraphicalEffects 1.15
import QtQuick.Timeline 1.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "../qml/components/"
Window {

    id: window
    width: rectangle.width+50
    height: rectangle.height+50
    visible: true
    color: "#00000000"
    property alias rectangleWidth: rectangle.width
    title: qsTr("Hello");

    flags: Qt.SplashScreen | Qt.FramelessWindowHint


    QtObject{
        id: internal
        function openMainWindow(){
            mainWindowdropshadow.visible = false
            var component = Qt.createComponent("main.qml")
            var win = component.createObject()
            win.show()
        }
        function closeWindow(){
            window.close()
        }
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

    Rectangle {
        id: rectangle
        x: 155
        y: 211
        z: 2
        width: 360
        height: 560
        opacity: 1
        visible: true
        color: Style.mybackgroundColor
        radius: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter


        Material.theme: Material.Light

        Image {
            id: githublogo
            x: 85
            y: 86
            width: 300
            height: 120
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            source: "images/logo.png"
            anchors.verticalCenterOffset: 145
            anchors.horizontalCenterOffset: 2
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit

            MouseArea {
                width: githublogo.width
                height: githublogo.height
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://github.com/xFeew")
            }


        }

        CircularProgressBar {
            id: circularProgressBar
            x: 55
            y: 266
            width: 120
            height: 120
            opacity: 1
            visible: true
            text: "%"
            anchors.verticalCenter: parent.verticalCenter
            focus: false
            textFontFamily: qsTr("Roboto")
            baselineOffset: 0
            antialiasing: true
            textShowValue: true
            dropShadowRadius: 45
            activeFocusOnTab: false
            enableDropShadow: true
            roundCap: true
            clip: false
            z: 100
            value: 50
            progressColor: Style.myaccentColor
            progressWidth: 7
            samples: 8
            strokeBgWidth: 4
            textSize: 28
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter          
        }

        Label {
            id: author
            x: 8
            y: 535
            opacity: 1
            visible: false
            color: Style.mytextColor
            text: qsTr("Designed & Created by Szymon Lach @ feew.dev")
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                width: author.width
                height: author.height
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://feew.dev")
            }
        }

        Button {
            id: button
            x: 55
            y: 266
            z: 10
            width: 147
            height: 48
            opacity: 0
            visible: true
            text: qsTr("Launch")

            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 2
            anchors.horizontalCenter: parent.horizontalCenter



            Material.accent: Style.mytextColor
            Material.foreground: "#000000"

            MouseArea {
                width: button.width
                height: button.height
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    button.text = ""
                    timelineAnimation1.start()
                }

            }
        }

        Label {
            id: programTitle
            x: -3
            y: 54
            visible: false

            color: Style.mytextColor
            text: "\"Nazwa własna\""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 22
            anchors.horizontalCenterOffset: 2
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: desc
            x: -5
            y: 95
            width: 339
            height: 33
            visible: true
            color: Style.mytextColor
            text: "Oprogramowanie sterujące ruchem maszyn CNC"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            textFormat: Text.AutoText
            font.pointSize: 14
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: desc1
            x: 4
            y: 146
            visible: false
            color: Style.mytextColor
            text: "Praca dyplomowa 2022"
            font.pointSize: 11
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                loops: 1
                duration: 3000
                running: true
                to: 3000
                from: 0
            },
            TimelineAnimation {
                id: timelineAnimation1
                running: false
                loops: 1
                duration: 80
                to: 5146
                from: 5000
                onFinished: {
                internal.openMainWindow()
                internal.closeWindow()
                }
            }
        ]
        enabled: true
        endFrame: 5146
        startFrame: 0

        KeyframeGroup {
            target: circularProgressBar
            property: "value"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 1300
                value: 100
            }
        }

        KeyframeGroup {
            target: button
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 1915
                value: 1
            }

            Keyframe {
                frame: 1699
                value: 0
            }
        }

        KeyframeGroup {
            target: circularProgressBar
            property: "opacity"
            Keyframe {
                frame: 1300
                value: 1
            }

            Keyframe {
                frame: 1565
                value: 0
            }

            Keyframe {
                frame: 0
                value: 1
            }
        }

        KeyframeGroup {
            target: rectangle
            property: "visible"

            Keyframe {
                value: true
                frame: 0
            }

            Keyframe {
                value: false
                frame: 5147
            }
        }

        KeyframeGroup {
            target: rectangle
            property: "width"
            Keyframe {
                value: 360
                frame: 0
            }

            Keyframe {
                value: 1200
                frame: 5119
            }

            Keyframe {
                value: 360
                frame: 4948
            }
        }

        KeyframeGroup {
            target: rectangle
            property: "height"
            Keyframe {
                value: 560
                frame: 0
            }

            Keyframe {
                value: 900
                frame: 5119
            }

            Keyframe {
                value: 560
                frame: 4948
            }
        }

        KeyframeGroup {
            target: githublogo
            property: "visible"
            Keyframe {
                value: true
                frame: 0
            }

            Keyframe {
                value: false
                frame: 5002
            }
        }

        KeyframeGroup {
            target: author
            property: "visible"
            Keyframe {
                value: true
                frame: 0
            }

            Keyframe {
                value: false
                frame: 5002
            }
        }

        KeyframeGroup {
            target: programTitle
            property: "visible"
            Keyframe {
                value: false
                frame: 5002
            }

            Keyframe {
                value: true
                frame: 0
            }
        }

        KeyframeGroup {
            target: desc
            property: "visible"
            Keyframe {
                value: false
                frame: 5002
            }

            Keyframe {
                value: true
                frame: 0
            }
        }

        KeyframeGroup {
            target: desc1
            property: "visible"
            Keyframe {
                value: true
                frame: 0
            }

            Keyframe {
                value: false
                frame: 5002
            }
        }
    }




}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:1}D{i:2}D{i:5}D{i:4}
D{i:6}D{i:8}D{i:7}D{i:10}D{i:9}D{i:11}D{i:12}D{i:13}D{i:3}D{i:14}
}
##^##*/
