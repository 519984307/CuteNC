import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: imgLblBtn

    //Custom properties
    property string btnIcon: "\uE837"
    property color colorDefault: "#FFFFFF"
    property color colorMouseOver: "#E6E6E6"
    property color colorPressed: "#404040"
    property color colorText: "#222222"

    property bool setMaximumHeight: false
    property bool borderVisible

    property int minimumWidth: 320
    property int minimumHeight: 300
    property int maximumWidth: 320
    property int maximumHeight: 300

    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor
    property color borderColor

    property int borderWidth
    property int borderRadius
    property int fontPointSize:12
    property string fontFamily

    property string name
    property string value


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
        radius: borderRadius
    }

    contentItem: Item{
        anchors.fill: parent
        id:content

        Label {
            id: labelIcon
            color: "#222222"
            text: btnIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "fontello"
            font.pointSize: fontPointSize
        }

    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:3;height:24;width:24}
}
##^##*/
