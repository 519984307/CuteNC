import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: topBarBtn

    //Custom properties
    property url btnIcon: ""
    property color colorDefault: "#1f1f1f"
    property color colorMouseOver: "#313131"
    property color colorPressed: colorMouseOver
    property color colorText: "#ffffff"
    property color overlayColor: "#ffffff"
    property int iconSize: 15

    QtObject{
        id:internal
        property var dynamicColor: if(topBarBtn.down){
                                       topBarBtn.down ? colorPressed : colorDefault
                                   }else{
                                       topBarBtn.hovered ? colorMouseOver : colorDefault
                                   }
    }



    width: 35
    height: 35

    background: Rectangle{

        id:bgBtnColor
        color:internal.dynamicColor
        Image {
            id: btnImage
            source: btnIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: iconSize
            height: iconSize
            visible: false
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }
        ColorOverlay{
            anchors.fill: btnImage
            source: btnImage
            color: overlayColor
            antialiasing: false
        }

    }
}


