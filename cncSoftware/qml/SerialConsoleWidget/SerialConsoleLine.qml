import QtQuick 2.0
import QtQuick.Controls 2.15

Row{
    id: myRow
    property int rowHeight: 25
    property int rowWidth: 800

    property int spacingBetween: 10

    property int fontPointSize: 12

    property color backgroundColor: "#ffffff"
    property color highlightedColor: "#e1e1e1"


    property color timeColor: "#222222"
    property color sourceColor: "#222222"
    property color messageColor: "#222222"

    property color warnColor: "#ECAB57" //orange
    property color infoColor: "#2E6DA4" //blue
    property color logColor: "#65B762"  //green
    property color errorColor: "#D35152" //red
    property color defaultColor: "#222222" //black

    property color greyedOutText: "#858585"
    property color greenedOutText: "#65B762"
    property color rededOutText: "#D35152"

    property string timeText: "00:00:00"
    property string sourceText: "Debug"
    property string messageText: "Message"

    property string fontFamily: "Arial"

    property string suffix: " ]"
    property string prefix: "[ "

    property string sourceType: ""
    property string textColor: ""


    //fill the row width to parent width
    width: list.width

    QtObject{
        id: internal

        function typeColor(){
            if(sourceType == "log"){
               return logColor
            }

            else if(sourceType == "warn"){
               return warnColor
            }

            else if(sourceType == "error"){
               return errorColor
            }

            else if(sourceType == "info"){
               return infoColor
            }

            else{
               return defaultColor
            }

        }

        function msgTextColor(){
            if(textColor == "greyedOut"){
                return greyedOutText
            }else if(textColor == "greenedOut"){
                return greenedOutText
            }else if(textColor == "rededOut"){
                return rededOutText
            }else{
                return defaultColor
            }
        }

        property bool isRowSelected: false



        function selectRow(){
            if(!isRowSelected){
                wrapperRectangle.color = "#e1e1e1"
                isRowSelected = true
            }else{
                wrapperRectangle.color = "#ffffff"
                isRowSelected = false
            }
        }

        function selectRowsWhenPressedAndHold(){
            if(mouseArea.pressedButtons == Qt.LeftButton){

                if(!isRowSelected){
                    wrapperRectangle.color = "#e1e1e1"
                    isRowSelected = true
                }else{
                    wrapperRectangle.color = "#ffffff"
                    isRowSelected = false
                }
            }
        }

    }

    Rectangle{
        id: wrapperRectangle
        width: parent.width
        height: messageTxt.lineCount*22

        Text{
            id: timeTxt
            color: timeColor
            text: prefix + timeText + suffix
            anchors.left: parent.left
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            anchors.leftMargin: 0
            font.pointSize: fontPointSize

        }

        Text{
            id: sourceTxt
            color: internal.typeColor()
            text: prefix + sourceText + suffix
            anchors.left: timeTxt.right
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            anchors.leftMargin: spacingBetween
            clip: true
            font.pointSize: fontPointSize


        }

        TextEdit{
            id: messageTxt
            y: 0
            color: internal.msgTextColor()
            text: messageText

            anchors.left: sourceTxt.right
            anchors.right: parent.right
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.pointSize: fontPointSize
            wrapMode: Text.WordWrap
            font.family: "Arial"
            anchors.leftMargin: 10
            textFormat: Text.AutoText
            anchors.rightMargin: 0
            selectByMouse: true
            readOnly: true

        }

//        MouseArea {
//            id: mouseArea
//            anchors.fill: parent
//            hoverEnabled: true
//            onPressed: internal.selectRow()
//            onEntered: internal.selectRowsWhenPressedAndHold()
//        }
    }

    Connections{
        target:backend
    }



}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75;height:22;width:600}
}
##^##*/
