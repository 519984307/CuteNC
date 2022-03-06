import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../components"
import "../GCodeViewer"
import QtQuick.Layouts 1.11

Item {
    Rectangle{
        id:background
        color: backgroundColor
        anchors.fill:parent

        Component.onCompleted: {
            jsonSettings()
        }

        TabBar {
            id: bar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            TabButton {
                text: qsTr("2D Viewer")
                width: implicitWidth
            }
        }

        StackLayout {
            id: stackLayout
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: bar.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            currentIndex: bar.currentIndex
            Item {
                id: visualizer2d
                GcodeViewer2D{
                    id:gcodeViewer2D
                    anchors.fill:parent;
                }

            }

        }

        Connections{
            target: backend
            function onSignal_GetThemes(){
                getThemeNames()
            }
            function onSignal_OpenFile(fileContent){
                mainGcodeEditor.setText(fileContent);
            }
            function onSignal_SaveFile(){
                backend.getFileToBeSavedContents(mainGcodeEditor.getText());
            }

            function onSignal_RefreshWidgets(){
                jsonSettings()
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:500;width:500}D{i:3}D{i:4}D{i:2}D{i:7}D{i:6}D{i:10}D{i:9}
D{i:8}D{i:5}D{i:11}D{i:1}
}
##^##*/
