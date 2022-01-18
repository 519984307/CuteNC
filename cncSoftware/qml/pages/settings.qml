import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../components"
import QtQuick.Layouts 1.11
Item {
    id: settingsPage
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


    property string selectedTheme
    function getThemeNames() {
        model.clear()
        for(var i = 0; i < backend.numberOfThemes();i++){
            console.log(backend.getThemeName(i));
            model.append({text: backend.getThemeName(i).replace(".json","")})
        }
    }
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
                text: qsTr("General")
                font.family: "Noto Sans"
                font.pointSize: 10
                width: implicitWidth
            }
            TabButton {
                text: qsTr("Styles")
                font.family: "Noto Sans"
                font.pointSize: 10
                width: implicitWidth

            }
            TabButton {
                text: qsTr("Misc")
                font.family: "Noto Sans"
                font.pointSize: 10
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
                id: generalTab

                ScrollView {
                    id: scrollView
                    anchors.fill: parent

                    Rectangle{
                        id: rectangle
                        anchors.fill:parent
                        anchors.topMargin: bar.top
                        //Add new element (widget)

                        Item {
                            id: themeSettings
                            height: 150
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.leftMargin: 0
                            anchors.topMargin: 0
                            Label {
                                id: label
                                text: "Theme"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 15
                                anchors.topMargin: 15
                                font.pointSize: 20
                                font.family: "Noto Sans"
                            }

                            CuteNCSeparatorLine {
                                id: separatorLine1
                                height: 2
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: label.bottom
                                anchors.leftMargin: 20
                                anchors.topMargin: 5
                                anchors.rightMargin: 80
                            }

                            Rectangle {
                                id: rectangle4
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: separatorLine1.bottom
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 10

                                ComboBox {
                                    id: comboBox
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.leftMargin: 20
                                    anchors.topMargin: 0
                                    onCurrentValueChanged: {
                                        selectedTheme = currentText;
                                    }
                                    model: ListModel {
                                        id: model
                                    }
                                }

                                Button {
                                    id: button
                                    text: qsTr("Set Selected")
                                    anchors.left: comboBox.right
                                    anchors.top: parent.top
                                    anchors.leftMargin: 20
                                    anchors.topMargin: 0
                                    onClicked: {
                                        backend.setTheme(selectedTheme)
                                        backend.refreshWidgetsInvoker();
                                        backend.showNotification("confirm",qsTr("Theme set!"))
                                        settingsPage.parent.reload();
                                    }
                                }
                                anchors.rightMargin: 0
                            }
                            anchors.rightMargin: 0
                        }

                        Item {
                            id: unitsSettings
                            height: 150
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: themeSettings.bottom
                            anchors.leftMargin: 0
                            anchors.topMargin: 0
                            Label {
                                id: label1
                                text: "Units"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 15
                                anchors.topMargin: 15
                                font.pointSize: 20
                                font.family: "Noto Sans"
                            }

                            CuteNCSeparatorLine {
                                id: separatorLine3
                                height: 2
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: label1.bottom
                                anchors.leftMargin: 20
                                anchors.topMargin: 5
                                anchors.rightMargin: 80
                            }

                            Rectangle {
                                id: rectangle5
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: separatorLine3.bottom
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 10
                                ComboBox {
                                    id: comboBox1
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.leftMargin: 20
                                    anchors.topMargin: 0
                                    model: ListModel {
                                        id: model1
                                    }
                                    Component.onCompleted: {
                                        model1.append({text:qsTr("Metric")});
                                        model1.append({text:qsTr("Imperial")});
                                    }
                                }

                                Button {
                                    id: button1
                                    text: qsTr("Change units")
                                    anchors.left: comboBox1.right
                                    anchors.top: parent.top
                                    anchors.leftMargin: 20
                                    anchors.topMargin: 0
                                    onClicked: {
                                         backend.showNotification("confirm",qsTr("Units changed to ")+"\n\r"+comboBox1.currentText)
                                    }
                                }
                                anchors.rightMargin: 0
                            }
                            anchors.rightMargin: 0
                        }



                    }
                }
            }
            Item {
                id: stylesTab


                ScrollView {
                    id: scrollView1
                    anchors.fill: parent

                    CuteNCSeparatorLine{
                        anchors.left: parent.left
                        anchors.right: parent.right
                    }


                    Item{
                        id:buttonThemeSettings
                        height: 500
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        Label{
                            id:btnLbl
                            text: "Button"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            font.pointSize: 20
                            font.family: "Noto Sans"
                            anchors.leftMargin: 15
                            anchors.topMargin: 15

                        }

                        CuteNCSeparatorLine{
                            id: separatorLine
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: btnLbl.bottom
                            anchors.topMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                        }

                        Rectangle{
                            id: rectangle3
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: separatorLine.bottom
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.bottomMargin: 0
                            anchors.topMargin: 0

                            Label{
                                text:qsTr("Default color")
                                anchors.left: btnDefaultColor.left
                                anchors.bottom: btnDefaultColor.top
                                font.pointSize: 10
                                font.family: "Noto Sans"
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 5
                            }

                            CuteNCTextInput{
                                id:btnDefaultColor
                                width: 150
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: 25
                                anchors.topMargin: 50
                            }


                            CuteNCSeparatorLine{
                                id: separatorLine2
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0

                            }

                            Rectangle{
                                id:previewRectangle
                                anchors.left: separatorLine2.right
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.rightMargin: 0
                                CuteNCButton{
                                    id:previewBtn
                                    width: 100
                                    height: 50
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }



                        }

                    }

                }



            }
            Item {
                id: miscTab
            }
        }


    }

    Connections{
        target: backend
        function onSignal_GetThemes(){
            getThemeNames()
        }
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
    }
    Component.onCompleted: {
        getThemeNames()
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.75;height:1000}D{i:3}D{i:4}D{i:5}D{i:2}D{i:11}D{i:12}D{i:14}
D{i:16}D{i:13}D{i:10}D{i:18}D{i:19}D{i:21}D{i:23}D{i:20}D{i:17}D{i:9}D{i:8}D{i:7}
D{i:26}D{i:28}D{i:29}D{i:31}D{i:32}D{i:33}D{i:35}D{i:34}D{i:30}D{i:27}D{i:25}D{i:24}
D{i:36}D{i:6}D{i:1}D{i:37}
}
##^##*/
