import QtQuick 2.0

import "../components"
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: nodeRoot
    width: 120
    height: 60
    radius: 4
    border.width: 1
    color: "#FFFFFF"
    clip: true
    property string macroName
    property string macroIcon
    property string macroShortcut
    property var macroLines
    property string macroFileName
    Rectangle{
        id:labels
        anchors.left: parent.left
        anchors.right: btnGroup.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5

        Label {
            id: label

            text: nodeRoot.macroName
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            wrapMode: Text.NoWrap
            clip: true
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 0
            font.pointSize: 12
            font.family: "Noto Sans"
            anchors.leftMargin: 0
            anchors.topMargin: 0
        }
        Label {
            id: icon
            width:parent.width/2
            text: nodeRoot.macroIcon
            anchors.left: parent.left
            anchors.top: label.bottom
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            anchors.bottomMargin: 0
            clip: true
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
            font.family: "fontello"
            anchors.leftMargin: 0
            anchors.topMargin: 0
        }
        Label {
            id: shortcut
            width:parent.width/2
            text: nodeRoot.macroShortcut
            anchors.right: parent.right
            anchors.top: label.bottom
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 0
            font.pointSize: 18
            font.family: "fontello"
        }


    }

    Rectangle{
        id:btnGroup
        color: "#c52626"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        width: parent.width*0.25

        Button {
            id: buttonRun
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: parent.height/2
            onClicked: {
                if(comport.isConnected() && consoleLog.isRunning){
                    backend.showNotification("error",qsTr("Cannot send macro when g-code is being processed!"))
                }
                if(!comport.isConnected() && !consoleLog.isRunning){
                    backend.showNotification("warn",qsTr("Connect to a device first!"))
                }

                if(comport.isConnected() && !consoleLog.isRunning){
                    var array = [];
                    for(var line in macroLines){
                        var string = macroLines[line].toString();
                        array.push(string);
                    }
                    backend.setupFile(array.join('\n'))
                    backend.startParsingFile()
                }

            }

            Label{
                font.family: "fontello"
                text: "\uE8A0"
                anchors.bottom: parent.bottom
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#2ECC71"
            }
        }


        Button {
            id: buttonEdit
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height/2

            onClicked: {
                var array = [];
                for(var line in macroLines){
                    var string = macroLines[line].toString();
                    array.push(string);
                }
                console.log(array);



                var component = Qt.createComponent("GCodeMacrosPopupWindow.qml");
                var sprite;

                if( component.status !== Component.Ready )
                {
                    if( component.status === Component.Error )
                        console.debug("Error:"+ component.errorString() );
                    return; // or maybe throw
                }
                sprite = component.createObject(nodeRoot);
                sprite.macroLines = array.join('\n');
                sprite.macroName = nodeRoot.macroName;
                //sprite.macroFileName = nodeRoot.macroFileName
                sprite.show()

                sprite.setValues();
            }

            Label{
                font.family: "fontello"
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "\uE832"
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}D{i:2}D{i:3}D{i:4}D{i:1}D{i:7}D{i:6}D{i:9}D{i:8}D{i:5}
}
##^##*/
