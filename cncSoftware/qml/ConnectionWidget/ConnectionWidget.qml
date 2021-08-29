import QtQuick 2.0

import "../buttons/"

Rectangle {
    id: connectionWidget


    property int minimumWidth: 250
    property int minimumHeight: 40
    property int maximumWidth: 250
    property int maximumHeight: 40


    width: 250
    height: 100
    color: "#00000000"

    //minimum & maximum widget size
    function setWidgetSize(){
        if(jogWidget.width < minimumWidth){
            jogWidget.width = minimumWidth
        }
        if(jogWidget.height < minimumHeight){
            jogWidget.height = minimumHeight
        }


        if(jogWidget.width > maximumWidth){
            jogWidget.width = maximumWidth
        }
        if(jogWidget.height > maximumHeight){
            jogWidget.height = maximumHeight
        }

    }

    onWidthChanged: {setWidgetSize()}
    onHeightChanged: {setWidgetSize()}



    ConnectButton{id:connectBtn ; anchors.left: parent.left; anchors.right: comboBox.right; anchors.top: comboBox.bottom; anchors.bottom: parent.bottom; anchors.bottomMargin: 24; anchors.leftMargin: 5; anchors.rightMargin: 0; anchors.topMargin: 5
        onClicked: {
            if(comboBox.selectedPort == "" || comboBox.selectedPort == null || comboBox.selectedPort === undefined){
               comport.connectionError("Select Serial Port");
               connectBtn.connected = false
               comboBox.enabled = true
            }
            else if(connectBtn.connected == false){

               comport.openSerialPort(comboBox.selectedPort);
               comboBox.enabled = false
               connectBtn.connected = true
            }
            else if(connectBtn.connected == true){

               comport.closeSerialPort(comboBox.selectedPort);
               comboBox.enabled = true
               connectBtn.connected = false
            }

        }
    }
    SerialPortComboBox{id:comboBox ; height: 40;anchors.left: parent.left;anchors.top: parent.top; anchors.leftMargin: 5;anchors.topMargin: 5}
    ImageButton{id:imageButton ; width: 40; height: 40; anchors.right: parent.right; anchors.top: parent.top; checkable: false; btnIcon: "\uE80E"; anchors.topMargin: 5;anchors.rightMargin: 5}
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/
