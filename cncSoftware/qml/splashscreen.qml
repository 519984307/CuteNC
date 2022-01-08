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
    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    function debug(){
        console.log("debug");
    }
    function launchProgress(){
        progressBar.value = 0;
        progressBarAnimation.start();
    }
    function stopProgress(){
        progressBarAnimation.stop();
        progressBar.value = 100
    }



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
        radius: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter


        Material.theme: Material.Light

        Label {
            id: author
            x: 8
            y: 535
            opacity: 1
            visible: true
            text: qsTr("Designed & Created by Szymon Lach @ feew.dev")
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
                width: author.width
                height: author.height
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.openUrlExternally("https://feew.dev")
            }
        }

        Label {
            id: author1
            opacity: 1
            visible: true
            text: qsTr("Loading...")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            anchors.horizontalCenter: parent.horizontalCenter

        }

        ProgressBar {
            id: progressBar
            height: 20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: author1.bottom
            anchors.topMargin: 10
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            from: 0
            to: 100
        }

        PropertyAnimation{
            id:progressBarAnimation
            target: progressBar
            property: "value"
            to: 100
            duration: 2000
            onStopped: {
                console.log("koniec")
            }
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
    }





}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:1}D{i:2}D{i:5}D{i:4}D{i:6}D{i:7}D{i:8}D{i:3}D{i:9}
}
##^##*/
