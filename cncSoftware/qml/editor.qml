
import QtQuick 2.15
import QtQuick.Window 2.15

import QtQuick.Extras 1.4

import QtGraphicalEffects 1.15
import QtQuick.Timeline 1.0

import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15


//3D
import QtQuick3D 1.15





//Styl
import Style 1.0
import "qml"
import "components"

Window {
    id: mainWindow
    width: 1200
    height: 800
    visible: true
    color: "#00000000"
    title: qsTr("Hello World")

    minimumWidth: 800
    minimumHeight: 500

    flags: Qt.Window | Qt.FramelessWindowHint


    property int windowStatus: 0
    property int windowMargin: 10
    QtObject{
        id: internal

        function resetResizeBorders(){
            resizeBottom.visible = true;
            resizeTop.visible = true;
            resizeLeft.visible = true;
            resizeRight.visible = true;
            resizeWindow.visible = true;
        }

        function maximizeRestore(){
            if(windowStatus == 0){
                windowMargin = 0;
                windowStatus = 1;
                mainWindow.showMaximized()
                resizeBottom.visible = false;
                resizeTop.visible = false;
                resizeLeft.visible = false;
                resizeRight.visible = false;
                resizeWindow.visible = false;
                maximizeApplicationBtn.btnIcon = "res/images/restore_icon.svg"

            }else{
                windowMargin = 10;
                windowStatus = 0;
                mainWindow.showNormal()
                internal.resetResizeBorders()
                maximizeApplicationBtn.btnIcon = "res/images/maximize_icon.svg"

            }
        }

        function ifMaximizedWindowState(mouseY, mouseX){
            if(windowStatus == 1){

                mainWindow.showNormal()

                windowStatus = 0
                windowMargin = 10

                internal.resetResizeBorders()
                maximizeApplicationBtn.btnIcon = "res/images/maximize_icon.svg"



                if(mainWindow.x < mouseX){
                    mainWindow.x = mouseX-(topBar.width/2)
                }else if(mainWindow.x > mouseX){
                    mainWindow.x = mouseX-(topBar.width/2)
                }
                    mainWindow.y = mouseY-(topBar.height/2)


            }
        }

        function restoreMargin(){
            windowMargin = 10
            windowStatus = 0
            internal.resetResizeBorders()
            maximizeApplicationBtn.btnIcon = "res/images/maximize_icon.svg"
        }

    }



    Rectangle {
        id: background
        color: "#00000000"
        border.color: "#000000"
        anchors.fill: parent
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                width: 60
                height: 35
                color: "#212121"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    DragHandler{
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizedWindowState(titleBarMouseArea.mouseY,titleBarMouseArea.mouseX)
                                         }

                    }

                    MouseArea{
                        id: titleBarMouseArea
                        anchors.fill: parent
                        onDoubleClicked: internal.maximizeRestore()

                    }


                    Image {
                        id: appIcon
                        width: 25
                        height: 25
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "res/images/rocket-solid.svg"
                        anchors.leftMargin: 5
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    ColorOverlay{
                        source: appIcon
                        anchors.fill: appIcon
                        color: "#ffffff"
                        antialiasing: true
                    }

                    Label {
                        id: appTitle
                        color: "#ffffff"
                        text: qsTr("Edytor")
                        anchors.left: appIcon.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 12
                        font.family: "Roboto"
                        styleColor: "#000000"
                        anchors.leftMargin: 15
                    }
                }

                Row {
                    id: rowBtns
                    x: 947
                    width: 105
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.topMargin: 0
                    anchors.rightMargin: 0


                    TopBarButton {
                        id: minimizeApplicationBtn
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        btnIcon: "res/images/minimize_icon.svg"
                        colorMouseOver: "#A18206"
                        iconSize: 16
                        onClicked: {
                            internal.restoreMargin()
                            mainWindow.showMinimized()
                        }
                    }

                    TopBarButton{
                        id: maximizeApplicationBtn
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        colorMouseOver: "#147B14"
                        iconSize: 16
                        btnIcon: "res/images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }


                    TopBarButton {
                        id: quitApplicationBtn
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        colorMouseOver: "#8A1616"
                        iconSize: 16
                        btnIcon: "res/images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: bottombar.top
                anchors.bottomMargin: 0
                anchors.topMargin: 0



            }


            Rectangle {
                id: bottombar
                y: 453
                height: 25
                color: "#444444"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                Label {
                    id: bottomBarDescriptionText
                    color: "#ffffff"
                    text: qsTr("Designed & Created by Szymon Lach @ feew.dev")
                    anchors.left: parent.left
                    anchors.right: resizeWindow.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Roboto"
                    anchors.leftMargin: 10
                    font.pointSize: 8
                }

                MouseArea {
                    id: resizeWindow
                    x: 864
                    y: 1
                    width: 25
                    height: 25
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    Image {
                        id: image1
                        width: 25
                        height: 25
                        opacity: 0.5
                        anchors.fill: parent
                        source: "res/images/resize_icon.svg"
                        sourceSize.width: 1000
                        anchors.topMargin: 5
                        sourceSize.height: 1000
                        anchors.leftMargin: 5
                        fillMode: Image.PreserveAspectCrop
                        smooth: true
                    }

                    DragHandler {
                        target: null
                        onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge )}
                    }
                    z: 1
                    cursorShape: Qt.SizeFDiagCursor
                    anchors.rightMargin: 0
                }
                z: 1
                anchors.rightMargin: 0
            }

        }
    }

    DropShadow{
        x: 20
        y: 20
        anchors.fill: background
        horizontalOffset: 0
        verticalOffset: 0
        radius: 8
        samples: 16
        color:"#80000000"
        source: background
        z: -1


    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.LeftEdge)}
        }
    }


    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.RightEdge)}
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.BottomEdge)}
        }
    }

    MouseArea {
        id: resizeTop
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.TopEdge)}
        }
    }

    Connections{
        target: backend
    }


}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
