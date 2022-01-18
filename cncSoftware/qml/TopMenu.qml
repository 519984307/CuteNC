import QtQuick 2.4
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.3 as QDiag
import Qt.labs.platform 1.1 as Platform

import "components"
import "ConnectionWidget"

Rectangle {
    id:topMenu
    anchors.fill:parent;
    color: "#5d5d5d";
    property string statusText: qsTr("Waiting")

    Platform.FileDialog {
        id: openDialog
        title: qsTr("Open gcode file")
        folder: shortcuts.desktop
        onAccepted: {
            console.log("opened "+openDialog.currentFile)
            backend.openFile(openDialog.currentFile);
        }
        nameFilters: ["G-code files (*.gcode;*.gco;*.g;*.nc)"]
        fileMode: Platform.FileDialog.OpenFile

    }
    Platform.FileDialog {
        id: saveDialog
        title: qsTr("Save gcode file")
        folder: shortcuts.desktop
        onAccepted: {
            backend.saveFile(saveDialog.currentFile);
            console.log("saved "+saveDialog.currentFile)
        }
        nameFilters: ["G-code files (*.gcode;*.gco;*.g;*.nc)"]
        fileMode: Platform.FileDialog.SaveFile
    }


    Platform.MenuBar {
        id: menuBar

       Platform.Menu {
            id: fileMenu
            title: qsTr("File")

            Platform.MenuItem {
                text: qsTr("&New")
                // onTriggered: Qt.quit()
            }

            Platform.MenuSeparator{}

            Platform.MenuItem {
                text: qsTr("&Open")
                onTriggered: openDialog.open();
            }
            Platform.MenuItem {
                text: qsTr("&Save")
                onTriggered: saveDialog.open();
            }
        }

        Platform.Menu {
            id: windowMenu
            title: qsTr("&Window")

            Platform.MenuItem {
                text: qsTr("&Minimize")
                //onTriggered: messageDialog.show(qsTr("Open action triggered"))
            }
            Platform.MenuSeparator{}

        }



        Platform.Menu {
            id: helpMenu
            title: qsTr("&Help")
            Platform.MenuItem {
                text: qsTr("&View Website")
                //onTriggered: messageDialog.show(qsTr("Open action triggered"))
            }
        }
    }

    QtObject{
        id:internal
        function disableButtonIfDisconnected(){
            if(connectionWidget.connected){
                stopButton.enabled = true
            }else{
                stopButton.enabled = false
            }
        }
    }

    Rectangle {
        id: firstHalf
        width: parent.width/2
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        anchors.leftMargin: 2
        color:"transparent"

        ConnectionWidget{
            id:connectionWidget
            width: 250
            height: 40
            anchors.left: parent.left
            anchors.top: parent.top
        }

        Button{
            id: stopButton
            width: 80
            anchors.left: connectionWidget.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.leftMargin: 5

            background: Rectangle{
                color: "#C32C30"
            }

            contentItem: Item {
                id: item1


                anchors.fill:parent

                Label{
                    id:textLbl
                    color: "#000000"
                    text: qsTr("STOP")
                    anchors.left: parent.left
                    anchors.right: icon.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    font.pointSize: 12
                    font.family: "Noto Sans"
                }
                Label{
                    id:icon
                    color: "#000000"
                    text: qsTr("\uf256")
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 5
                    font.pointSize: 16
                    font.family: "fontawesome"
                }
            }
        }
    }

    Rectangle {
        id: secondHalf
        width: parent.width/2
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 2
        anchors.bottomMargin: 2
        anchors.topMargin: 2
        color:"transparent"

        Rectangle{
            id: statusRectangle
            anchors.fill: parent
            radius: 0

            Rectangle {
                id: rectangle
                color: "#00000000"
                anchors.bottom: progressBar.top
                anchors.fill: parent

                Label{
                    id:statusMessageTypeIcon

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.family: "Noto Sans"
                    text: "Status:"
                    font.pointSize: 14

                }

                Label{
                    id:statusMessage
                    text: statusText
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: statusMessageTypeIcon.right
                    anchors.right: statusDestroyMessage.left
                    font.pointSize: 14
                    font.family: "Noto Sans"
                    anchors.rightMargin: 30
                    anchors.leftMargin: 15
                }

            }
        }

    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:50;width:1000}D{i:1}D{i:2}D{i:3}D{i:14}D{i:16}D{i:17}D{i:15}
D{i:25}D{i:26}D{i:24}D{i:23}D{i:22}
}
##^##*/
