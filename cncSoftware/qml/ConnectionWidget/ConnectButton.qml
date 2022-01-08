import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: connectBtn

    //Custom properties
    property color colorDefault: "#F6F7F8"
    property color colorMouseOver: "#E6E6E6"
    property color colorPressed: "#E6E6E6"
    property color colorConnect: "#65B762"
    property color colorDisconnect: "#D35152"
    property color colorConnectHover: "#4E9C4A"
    property color colorDisconnectHover: "#C32C30"

    property color colorText: "#000000"

    property int textSize: 12

    property bool connected: false


    QtObject{
        id:internal
        property bool containsMouse: false
        property var connectedColor: if(connectBtn.down){
                                         if(connectBtn.connected==true){
                                             return colorDisconnect
                                         }else if(connectBtn.connected==false){
                                             return colorConnect
                                         }
                                     }else{
                                         if(connectBtn.connected==true){
                                             connectBtn.hovered ? colorDisconnectHover : colorDisconnect
                                         }else if(connectBtn.connected==false){
                                             connectBtn.hovered ? colorConnectHover : colorConnect
                                         }
                                     }

        property var connectedText: if(connectBtn.connected==true){
                                       return qsTr("Disconnect")
                                     }else if(connectBtn.connected==false){
                                       return qsTr("Connect")
                                     }
    }
    width:120
    height:50
    visible: true

    checkable: true

    background: Rectangle{
        id: bgRectangle
        color: internal.connectedColor
    }

    contentItem: Item{
        anchors.fill: parent
        id:content


        Label{
            id: lbl
            text: internal.connectedText
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            font.pointSize: textSize
            color: colorText
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
