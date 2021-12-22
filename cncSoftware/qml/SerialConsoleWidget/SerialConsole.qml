import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml.Models 2.15
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.15

import "../buttons"

Rectangle {
    id: serialConsole
    property int minimumHeight: 100
    property int minimumWidth: 100
    property int previousY
    property bool setMaximumSize:false
    property bool setMinimumSize:false



    property int index: 0

    //refreshing lines in console basically adding last message
    function refresh(){
        serialConsole.index = consoleLog.countMessages()
        myModel.append(createListElement(serialConsole.index-1));

        ///! TODO
        //if my model size > max lines -> mymodel.clear()
    }


    function createListElement(position) {
        if(consoleLog.getMessage(position) !== ""){
            return {
                type: consoleLog.getType(position),
                source: consoleLog.getSource(position),
                message: consoleLog.getMessage(position),
                time: consoleLog.getTime(position),
                textColor: consoleLog.getTextColor(position)
            };
        }
    }

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

    MouseArea {
        id: resizeRectTop
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        cursorShape: Qt.SizeVerCursor
        onPressed: {
            previousY = mouseY
        }

        onMouseYChanged: {
            if(serialConsole.height >= minimumHeight){
                var dy = mouseY - previousY
                serialConsole.y = serialConsole.y + dy
                serialConsole.height = serialConsole.height - dy
            }
        }
        Rectangle {
            color: "#b638d4"
            anchors.fill: parent
        }
    }


    ListModel {
        id: myModel
        //ListElement{} (...)
        //lines in console
    }
    property bool isHoldingScrollBar: true
    property double previousPos: 0
    height: 480
    border.width: 1



    //TODO zamienic na TableView


    Rectangle {
        id: wrapper
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: resizeRectTop.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1

        ScrollView{
            id: list
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: controls.top
            anchors.bottomMargin: 0


            smooth: false

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AsNeeded




            ListView {
                id: listView
                anchors.fill: parent
                model: myModel
                orientation: Qt.Vertical

                //automatically scroll to bottom
                onContentHeightChanged: {
                    if(!isHoldingScrollBar)
                        listView.positionViewAtEnd()
                }

                clip: true
                delegate:
                    SerialConsoleLine {
                    sourceType: model.type
                    sourceText: model.source
                    messageText: model.message
                    timeText: model.time
                    textColor: model.textColor
                    visible: true

                }
            }

        }

        Rectangle {
            id: controls
            height: 30
            color: "#ffffff"
            border.width: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0

            Rectangle{
                id: consoleSendCommandLine
                x: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 1
                z: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0



                ImageLabelButton{ id: sendCommand; x: 514; width: 85; anchors.right: clearConsole.left; anchors.top: parent.top; anchors.bottom: parent.bottom; textSize: 12; anchors.rightMargin: 0; z: 1; anchors.bottomMargin: 0; anchors.topMargin: 0;                function activate() {
                    if(inputCommand.text != ""){
                        backend.commandReceived(inputCommand.text)
                        inputCommand.text = ""
                    }
                }
                onClicked: sendCommand.activate();
                }

                ImageButton{ id: clearConsole; width: parent.height; height: parent.height; anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: parent.bottom; z: 1; anchors.bottomMargin: 0; anchors.topMargin: 0; anchors.rightMargin: 0
                    onClicked: {
                        myModel.clear();
                    }
                }


                ImageButton {
                    id: terminalIcon
                    width: 29
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    font.bold: true
                    btnIcon: "\uF120"
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    z: 1
                    enabled: false
                }

                Rectangle {
                    id: inputTextBackground
                    color: "#e6e6e6"
                    anchors.left: terminalIcon.right
                    anchors.right: sendCommand.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    TextInput{
                        id: inputCommand
                        color: "#000000"
                        text: ""
                        anchors.fill: parent

                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        selectByMouse: true
                        autoScroll: true
                        wrapMode: TextInput.NoWrap
                        anchors.rightMargin: 5
                        anchors.leftMargin: 5
                        overwriteMode: false
                        font.hintingPreference: Font.PreferNoHinting
                        z: 0

                        ToolTip {
                            parent: inputCommand.cursorRectangle.x;
                            visible: inputCommand.focus
                            text: "tooltip"
                        }

                        focus: true

                        Keys.onPressed: {
                            if(inputCommand.focus == true && event.key === Qt.Key_Return){
                                sendCommand.activate()
                            }
                        }

                    }
                }
            }
        }
    }

    Connections{
        target: consoleLog
        function onRefreshConsole(){
            serialConsole.refresh();
        }
        function onConsoleDebug(){
            console.log(text)
        }
    }
    Connections{
        target: backend
        function onDebugSignal(){
            console.log(text)
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.1;height:200;width:400}D{i:7}
}
##^##*/
