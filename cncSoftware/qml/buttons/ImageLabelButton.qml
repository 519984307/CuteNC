import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: imgLblBtn

    //Custom properties
    property string btnIcon: "\uF1D8"
    property string label: "Send"
    property color colorDefault: "#FFFFFF"
    property color colorMouseOver: "#E6E6E6"
    property color colorPressed: "#404040"
    property color colorText: "#222222"

    property int iconSize: 16
    property int textSize: 12




    QtObject{
        id:internal
        property bool containsMouse: false
        property var dynamicColor: if(imgLblBtn.down){
                                       imgLblBtn.down ? colorPressed : colorDefault
                                   }else{
                                       imgLblBtn.hovered ? colorMouseOver : colorDefault
                                   }
    }




    width: 120
    height: 50
    visible: true

    background: Rectangle{
        id:bgBtnColor
        color:internal.dynamicColor
    }




    contentItem: Item{
        anchors.fill: parent
        id:content



        Label {
            id: label1
            color: "#222222"
            text: "Send"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: labelIcon.contentWidth+10
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            font.pointSize: textSize
            font.weight: Font.Normal
            font.bold: true
            font.family: "Roboto"
        }

        Label {
            id: labelIcon
            color: "#222222"
            text: btnIcon
            anchors.left: parent.left
            anchors.right: label1.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pointSize: textSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 5
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.leftMargin: 5
            font.family: "fontello"
        }

    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:1.75;height:50;width:200}
}
##^##*/
