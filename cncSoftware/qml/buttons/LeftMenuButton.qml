import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnLeftMenu

    //Custom properties
    property url btnIcon: "../svgs/home_icon.svg"
    property color colorDefault: "#1f1f1f"
    property color colorMouseOver: "#313131"
    property color colorPressed: "#00a1f1"
    property color colorText: "#ffffff"
    property color highlightedColorLeft: "#f77f00"
    property color highlightedColorRight: "#313131"
    property bool isActive: false

    property string textBtn: ""
    property int iconSize: 18

    QtObject{
        id:internal
        property bool containsMouse: false
        property var dynamicColor: if(btnLeftMenu.down){
                                       btnLeftMenu.down ? colorPressed : colorDefault
                                   }else{
                                       btnLeftMenu.hovered ? colorMouseOver : colorDefault
                                   }
        property var dynamicWidth:{
            if(btnLeftMenu.hovered){
                extend.running = true
            }else{
                descend.running = true
            }
        }
    }

    PropertyAnimation{
        id: extend
        target: btnLeftMenu
        property: "width"
        to: 200
        duration: 300
        easing.type: Easing.OutExpo
    }
    PropertyAnimation{
        id: descend
        target: btnLeftMenu
        property: "width"
        to: 70
        duration: 300
        easing.type: Easing.OutExpo
    }


    width: 70
    height: 60

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
        Image {
            id: btnImage
            width: iconSize
            height: iconSize
            source: btnIcon
            anchors.verticalCenterOffset: 1
            anchors.leftMargin: 26
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: iconSize
            sourceSize.height: iconSize
            visible: false
            fillMode: Image.PreserveAspectFit
            antialiasing: true
        }
        ColorOverlay{
            width: iconSize
            height: iconSize
            source: btnImage
            anchors.verticalCenterOffset: 1
            anchors.leftMargin: 26

            color: colorText
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left

            antialiasing: true
        }

        Rectangle{
            width: 250
            height: parent.height;
            color: "#00000000"
            z:-1

            Text{
                color: "#ffffff"
                text: textBtn
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 75
                visible: true
                z:-1

            }
        }

    }



}


