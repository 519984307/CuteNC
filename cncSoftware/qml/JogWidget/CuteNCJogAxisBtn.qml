import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: moveBtn

    //Custom properties
    property string btnLabel: "Y+"
    property string fontFamily:"fontello"
    property string btnIcon: "\uE85C"
    property color colorDefault: "#1f1f1f"
    property color colorMouseOver: "#313131"
    property color colorPressed: "#00a1f1"
    property color colorText: "#ffffff"
    readonly property bool isActive: false

    property int iconSize: 16
    property int textSize: 24
    property int rotationAngle: 0
    enabled:false
    QtObject{
        id:internal
        property bool containsMouse: false
        property var dynamicColor: if(!moveBtn.enabled){
                                       moveBtn.enabled ? colorDefault : "#adb5bd";
                                   }else{
                                       if(moveBtn.down){
                                           moveBtn.down ? colorPressed : colorDefault
                                       }else{
                                           moveBtn.hovered ? colorMouseOver : colorDefault
                                       }
                                   }
    }



    width: 64
    height: 64

    visible: true
    background: Rectangle{

        id:bgBtnColor
        color:internal.dynamicColor


        Rectangle{
            anchors{
                top:parent.top
                bottom: parent.bottom
                left: parent.left
            }
            color: highlightedColorLeft
            width: 3
            visible: isActive
        }



    }
    contentItem: Item{
        anchors.fill: parent
        id:content

        Label{
            id: lbl
            text: moveBtn.btnLabel
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14
            font.weight: Font.Normal
            font.bold: false
            font.family: "Noto Sans"
            anchors.topMargin: 5
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            wrapMode: Text.Wrap
            color: backend.determineFontColor(bgBtnColor.color) ? "#ffffff" : "#000000"
        }

        Label {
            id: btnImage
            color: backend.determineFontColor(bgBtnColor.color) ? "#ffffff" : "#000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: lbl.bottom
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            font.pointSize: 24
            font.family: moveBtn.fontFamily
            text:btnIcon

            transform: Rotation { origin.x: btnImage.width/2; origin.y: btnImage.height/2; angle: rotationAngle}

        }


    }



}



/*##^##
Designer {
    D{i:0;formeditorZoom:3}D{i:1}
}
##^##*/
