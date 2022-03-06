import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: moveBtn

    //Custom properties
    property string axisLabel: "Y+"
    property color colorDefault: "#1f1f1f"
    property color colorMouseOver: "#313131"
    property color colorPressed: "#00a1f1"
    property color colorText: "#ffffff"
    property color highlightedColorLeft: "#f77f00"
    property color highlightedColorRight: "#313131"
    readonly property bool isActive: false

    property int iconSize: 16
    property int textSize: 24
    property int rotationAngle: 0
    property string axis: "y+"

    QtObject{
        id:internal
        property bool containsMouse: false
        property var dynamicColor: if(moveBtn.down){
                                       moveBtn.down ? colorPressed : colorDefault
                                   }else{
                                       moveBtn.hovered ? colorMouseOver : colorDefault
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
            text: axisLabel
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14
            font.weight: Font.Normal
            font.bold: false
            font.family: "Roboto"
            anchors.topMargin: 5
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            color: "#ffffff"
        }

        Image {
            id: btnImage
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: lbl.bottom
            anchors.bottom: parent.bottom
            source: btnIcon
            fillMode: Image.PreserveAspectFit
            anchors.topMargin: 0
            anchors.rightMargin: 5
            anchors.bottomMargin: 5
            anchors.leftMargin: 5
            width: iconSize
            height: iconSize
            transform: Rotation { origin.x: btnImage.width/2; origin.y: btnImage.height/2; angle: rotationAngle}

        }
        ColorOverlay{

            source: btnImage

            anchors.fill: btnImage
            color: "#ffffff"
            antialiasing: true
            transform: Rotation { origin.x: btnImage.width/2; origin.y: btnImage.height/2; angle: rotationAngle}
        }

    }



}



/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
