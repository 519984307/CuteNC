import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.11

Button{
    id: jogAuxBtn

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
    enabled:false
    QtObject{
        id:internal
        property bool containsMouse: false
        property var dynamicColor: {
            if(!jogAuxBtn.enabled){
                jogAuxBtn.enabled ? colorDefault : "#adb5bd";
            }else{
                if(jogAuxBtn.down){
                    jogAuxBtn.down ? colorPressed : colorDefault
                }else{
                    jogAuxBtn.hovered ? colorMouseOver : colorDefault
                }
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

        GridLayout {
            anchors.fill: parent
            rowSpacing: 0
            columnSpacing: 0

            columns: 2
            rows: 2

            Label {
                id: btnImage
                Layout.column: 2
                Layout.columnSpan: 1
                Layout.row: 1
                Layout.rowSpan: 2
                Layout.fillHeight: true
                Layout.leftMargin: 5
                color: backend.determineFontColor(bgBtnColor.color) ? "#ffffff" : "#000000"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 18
                font.family: jogAuxBtn.fontFamily
                text:btnIcon
            }

            Label{
                id: lbl
                Layout.column: 1
                Layout.columnSpan: 1
                Layout.row: 1
                Layout.rowSpan: 2
                Layout.fillHeight: true
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                text: jogAuxBtn.btnLabel
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
                font.weight: Font.Normal
                font.bold: false
                font.family: "Noto Sans"
                color: backend.determineFontColor(bgBtnColor.color) ? "#ffffff" : "#000000"
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:1.75;height:50;width:200}D{i:1}
}
##^##*/
