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
    color: "#dee2e6"
    property string statusText: qsTr("Waiting")

    property color stopButtonColor: "#dc3545"
    property color startButtonColor: "#f8f9fa"
    property color disabledColor: "#adb5bd"
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


    Rectangle {
        id: rectangle
        width: 200
        height: 2
        visible: false
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
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

    Component.onCompleted: {
        startButton.enabled = false;
        stopButton.enabled = false;
    }

    Rectangle {
        id: firstHalf
        width: parent.width/2
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: rectangle.top
        anchors.topMargin: 2
        anchors.bottomMargin: 0
        anchors.leftMargin: 2
        color:"transparent"

        ConnectionWidget{
            id:connectionWidget
            width: 250
            height: 40
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
        }

        Connections{
            target: comport
            function onSignal_DisconnectedFromSerialPort(){
                consoleLog.isRunning = false;
                stopButton.enabled = false;
                startButton.enabled = false;
                stopButtonBgRect.color = disabledColor
                stopButtonBgRect1.color = disabledColor
            }
            function onSignal_ConnectedToSerialPort(){
                stopButton.enabled = true;
                startButton.enabled = true;
                stopButtonBgRect.color = stopButtonColor
                stopButtonBgRect1.color = startButtonColor
            }
        }
    }

    Rectangle {
        id: secondHalf
        width: parent.width/2
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: rectangle.top
        anchors.rightMargin: 2
        anchors.bottomMargin: 0
        anchors.topMargin: 2
        color:"transparent"

        Button{
            id: stopButton
            x: -241
            y: 0
            width: 80
            anchors.left: startButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.leftMargin: 5

            background: Rectangle{
                id:stopButtonBgRect
                color: "#C32C30"
            }
            onEnabledChanged: {
                if(stopButton.enabled == false){
                    stopButtonBgRect.color = disabledColor
                }else{
                    stopButtonBgRect.color = stopButtonColor
                }
            }
            onClicked:{

                if(comport.isConnected() && consoleLog.isRunning){
                    consoleLog.isRunning = false;
                    backend.emergencyStop();
                }

                if(!consoleLog.isRunning){
                    backend.showNotification("warn",qsTr("Run a program first."))
                }
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


        Connections{
            target:backend
            function onSignal_DoneRunningProgram(){
                console.log("stopping program")
                startButton.stopProgram();
            }
        }

        Button {
            id: startButton
            width: 150
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            function runProgram(){
                startButton.enabled = false;
                stopButtonBgRect1.color = disabledColor
                backend.startParsingFile();

            }
            function stopProgram(){
                startButton.enabled = true;
                stopButtonBgRect1.color = startButtonColor
            }

//            onEnabledChanged: {
//                if(startButton.enabled == false){
//                    stopButtonBgRect1.color = disabledColor
//                    setDisabled();
//                    icon1.color = "#000000"
//                    consoleLog.isRunning = false;
//                }else{
//                    console.log("enabled true")
//                    stopButtonBgRect1.color = startButtonColor
//                    setDisabled();

//                }
//            }

            onClicked:{
                if(consoleLog.isRunning){
                    stopProgram();
                }else{
                    runProgram();
                }
            }



//            function setDisabled(){

//                textLbl1.text = qsTr("Run program")
//                icon1.text = "\ue8a0"
//                icon1.color ="#20c997"
//            }

//            function setEnabled(){
//                textLbl1.text = qsTr("Stop program")
//                icon1.text = "\ue86b"
//                icon1.color ="#dc3545"
//            }

            background: Rectangle {
                id: stopButtonBgRect1
                color: "#f8f9fa"
            }
//            function runProgram(){
//                setEnabled()
//                backend.startParsingFile();
//                consoleLog.isRunning = true
//                startButton.enabled = false;
//            }
//            function stopProgram(){
//                console.log("stopping")
//                consoleLog.isRunning = false;
//                startButton.enabled = true;
//                //setDisabled()
//                //backend.commandReceived("M18","Application");
//                //backend.commandReceived("M84","Application");
//            }





            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            contentItem: Item {
                id: item2
                anchors.fill: parent
                Label {
                    id: textLbl1
                    color: "#000000"
                    text: qsTr("Run program")
                    anchors.left: icon1.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Noto Sans"
                    anchors.leftMargin: 5
                    font.pointSize: 12
                    anchors.rightMargin: 0
                }

                Label {
                    id: icon1
                    color: "#20c997"
                    text: "\ue8a0"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 5
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "fontawesome"
                    font.pointSize: 16
                }
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:35;width:1000}D{i:1}D{i:2}D{i:3}D{i:4}
D{i:16}D{i:17}D{i:15}D{i:19}D{i:24}D{i:25}D{i:18}
}
##^##*/
