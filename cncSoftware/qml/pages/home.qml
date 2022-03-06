import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.15
import "../components"
import "../GCodeMacros"
import "../ConsoleWidget"
import "../ConnectionWidget"
import "../DROWidget"
import "../VisualizerWidget"
import "../JogWidget"
Item {
    id: homePage
    width: 800
    height: 600


    property int setWidth
    property int setHeight
    property int minimumWidth
    property int minimumHeight
    property int maximumWidth
    property int maximumHeight
    property bool setMaximumSize
    property bool setMinimumSize
    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor: "white"
    property color borderColor

    property bool borderVisible
    property int borderWidth
    property int borderRadius

    property int fontPointSize
    property string fontFamily

    property string fontAwesomeIcon
    property string text
    property string name
    property string value


    function jsonSettings(){
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        backgroundColor = JsonObjectTheme.backgroundColor;

    }

    Rectangle{
        id:background
        color: backgroundColor
        anchors.fill:parent
        //CONTENT

        SplitView {
            anchors.fill: parent
            orientation: Qt.Horizontal
            width:parent.width
            height: parent.height
            Rectangle {
                id: leftR
                height: homePage.height
                SplitView.minimumWidth: 50
                SplitView.preferredWidth: 300
                SplitView.maximumWidth: 300
                clip: true

                DROWidget{
                    id: droWidget
                    width: parent.width
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                }
                JogWidget{
                    id:jogWidget
                    width: parent.width
                    height: parent.height/3
                    anchors.left: parent.left
                    anchors.top: droWidget.bottom
                   // anchors.bottom: macrosWidget.top
                    anchors.right: parent.right
                }

                GCodeMacros{
                    id:macrosWidget
                    width: parent.width
                    anchors.top: jogWidget.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }

            }

            Rectangle {
                id: rightR
                width: background.width
                SplitView.minimumWidth: 50
                clip: true
                SplitView {
                    anchors.fill: parent
                    orientation: Qt.Vertical
                    width: parent.width
                    height: parent.height
                    Rectangle {
                        id: right_top
                        clip: true
                        SplitView.minimumHeight: 200
                        SplitView.minimumWidth: 200
                        SplitView.maximumHeight: homePage.height-200
                        SplitView.fillHeight: true
                        SplitView.fillWidth: true
                        SplitView {
                            id:split_top
                            anchors.fill: parent
                            orientation: Qt.Horizontal
                            width: parent.width
                            height: parent.height
                            Rectangle{
                                id:right_top_1
                                SplitView.minimumWidth: 100
                                SplitView.minimumHeight: 100
                                SplitView.preferredWidth: 300
                                SplitView.fillHeight: true
                                SplitView.fillWidth: true
                                clip: true
                                VisualizerWidget {
                                    id: visualizerWidget
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                }
                            }
                            Rectangle{
                                id:right_top_2
                                SplitView.minimumWidth: 100
                                SplitView.minimumHeight: 100
                                SplitView.preferredWidth: 300
                                clip: true
                                CuteNCGCodeTextEditor {
                                    id: mainGcodeEditor
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    Connections {
                                        target: backend
                                    }
                                }
                            }
                        }

                    }

                    Rectangle {
                        id: right_bottom_1
                        clip: true
                        width: parent.width;
                        height: 200
                        SplitView.maximumHeight: homePage.height-200
                        SplitView.minimumHeight: 200
                        SplitView.fillWidth: true
                        Rectangle{
                            id: consoleWidget
                            anchors.fill:parent
                            Loader {
                                id:consoleLoader
                                anchors.fill:parent
                            }
                        }
                    }
                }
            }
        }
        //ENDOF CONTENT




    }
    Connections{
        target: backend
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
        function onSignal_Ready(){
            consoleLoader.source = "qrc:/qml/ConsoleWidget/ConsoleWidget.qml";
        }
    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66;height:1000;width:1600}D{i:4}D{i:3}D{i:8}D{i:10}D{i:9}D{i:7}
D{i:12}D{i:14}D{i:13}D{i:11}D{i:6}D{i:5}D{i:2}D{i:1}D{i:15}
}
##^##*/
