import QtQuick 2.0

import "../buttons/"

Rectangle {
    id: connectionWidget

    color: "#00000000"

    property bool connected: connectBtn.connected
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

    Connections{
        target: comport
        function onSignal_ClosePort(){
            connectBtn.close();

        }
    }


    ConnectButton{id:connectBtn ; width:parent.width/2; anchors.left: comboBox.right; anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: comboBox.bottom; anchors.bottomMargin: 0; anchors.leftMargin: 5; anchors.rightMargin: 0; anchors.topMargin: 0
        onClicked: {
            if(comboBox.selectedPort == "" || comboBox.selectedPort == null || comboBox.selectedPort === undefined){
               comport.connectionError(qsTr("Please select serial port before connecting"));
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
            function close(){
                comboBox.enabled = true
                connectBtn.connected = false
            }

        }

    }
    SerialPortComboBox{
        id:comboBox;
        width:parent.width/2;
        anchors.left: parent.left;
        anchors.top: parent.top;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 0;
        anchors.leftMargin: 0;
        anchors.topMargin: 0}
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:2;height:480;width:640}D{i:1}D{i:2}D{i:3}
}
##^##*/
