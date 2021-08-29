import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle{
    id: mainRect
    width: internal.dynamicWidth
    height: internal.dynamicHeight
    color: "#6cc1e8"
    border.width: 0
    border.color: "#C32C30"

    property string name
    property int minimumWidth
    property int minimumHeight

    Loader{
        id: stackView
        anchors.fill: parent
        source: Qt.resolvedUrl("TemplateWidget.qml")
        z: 0
        clip: false
        enabled: false
        Component.onCompleted: {
            //stackView.item.name - saved in json file called "name"
            mainRect.name = stackView.item.name
            mainRect.minimumWidth = stackView.item.minimumWidth
            mainRect.minimumHeight = stackView.item.minimumHeight
        }
    }

    QtObject{
        id:internal
        property var dynamicHeight:{
            if(mainRect.height < minimumHeight){
                mainRect.height = minimumHeight
            }
        }
        property var dynamicWidth:{
            if(mainRect.width < minimumWidth){
                mainRect.width = minimumWidth
            }
        }
        property bool isSelected: false
        function on_thisSelected(){
            mainRect.border.width = 2
            mainRect.border.width = 0
        }
    }

    MouseArea {
        id: resizeRectBL
        x: 864
        y: 1
        width: 10
        height: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeFDiagCursor
        onPressed: {
            previousY = mouseY
            previousX = mouseX;
        }
        onMouseXChanged: {
            if(mainRect.width >= minimumWidth){
                var dx = mouseX - previousX
                mainRect.width = mainRect.width+dx
            }
        }
        onMouseYChanged: {
            if(mainRect.height >= minimumHeight){
                var dy = mouseY - previousY
                mainRect.height = mainRect.height + dy
            }
        }
        Rectangle{
            color: "#095476"
            anchors.fill: parent
        }


    }


    property int previousY
    property int previousX

    MouseArea {
        id: resizeRectR
        x: 869
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: resizeRectBL.top
        anchors.topMargin: 0
        cursorShape: Qt.SizeHorCursor

        onPressed: {
            previousX = mouseX
        }
        onMouseXChanged: {
            if(mainRect.width >= minimumWidth){
                var dx = mouseX - previousX
                mainRect.width = mainRect.width+dx
            }
        }

        Rectangle {
            color: "#14de80"
            anchors.fill: parent
        }
    }

    MouseArea {
        id: resizeRectB
        height: 10
        anchors.left: parent.left
        anchors.right: resizeRectBL.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        cursorShape: Qt.SizeVerCursor
        onPressed: {
            previousY = mouseY

        }

        onMouseYChanged: {
            if(mainRect.height >= minimumHeight){
                var dy = mouseY - previousY
                mainRect.height = mainRect.height + dy
            }
        }
        Rectangle {
            color: "#b638d4"
            anchors.fill: parent
        }
    }

    MouseArea {
        id: dragArea
        anchors.left: parent.left
        anchors.right: resizeRectR.left
        anchors.top: parent.top
        anchors.bottom: resizeRectB.top
        anchors.bottomMargin: 0
        anchors.rightMargin: 0

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        drag.target: mainRect
        drag.axis: Drag.XAxis | Drag.YAxis

        cursorShape: Qt.SizeAllCursor

        onPressed:{
            editorPage.selected = mainRect
        }
        onClicked: {
             if (mouse.button === Qt.RightButton)
                 contextMenu.popup()
         }
         onPressAndHold: {
             if (mouse.source === Qt.MouseEventNotSynthesized)
                 contextMenu.popup()
         }

         Menu {
             id: contextMenu
             MenuItem { text: "Delete"; onClicked: mainRect.destroy()}
             MenuItem { text: "Copy" }
             MenuItem { text: "Paste" }
         }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3;height:50;width:100}
}
##^##*/
