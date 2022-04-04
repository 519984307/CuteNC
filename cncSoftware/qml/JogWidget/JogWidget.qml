import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

Rectangle {
    id: jogWidget
    color: backgroundColor

    property bool enabled: false;
    property color backgroundColor

    property string fontFamily
    property string btnIcon

    property string xPlus
    property string xMinus

    property string yPlus
    property string yMinus

    property string zPlus
    property string zMinus

    property double jogResolution_1
    property double jogResolution_2
    property double jogResolution_3
    property double jogResolution_4
    property double jogResolution_5
//    property double jogResolution_6
//    property double jogResolution_7
//    property double jogResolution_8

    property int jogFeedrateMin
    property int jogFeedrateMax
    property int jogFeedrateDefault
    property int jogFeedrateStepSize

    property string jogWidgetXColor
    property string jogWidgetYColor
    property string jogWidgetZColor
    property string jogWidgetAColor
    property string jogWidgetBColor
    property string jogWidgetCColor

    Connections{
        target:comport
        function onSignal_ConnectedToSerialPort(){
            jogWidget.enabled = true;
        }
        function onSignal_DisconnectedFromSerialPort(){
            jogWidget.enabled = false;
        }
    }

    Component.onCompleted: {
        var JsonString = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObject = JSON.parse(JsonString);

        jogWidget.backgroundColor = JsonObject.jogWidget.backgroundColor;
        jogWidget.fontFamily = JsonObject.jogWidget.fontFamily;
        jogWidget.btnIcon = JsonObject.jogWidget.btnIcon;

        jogWidget.xPlus = JsonObject.jogWidget.X.labelPlus;
        jogWidget.xMinus = JsonObject.jogWidget.X.labelMinus;
        jogWidget.yPlus = JsonObject.jogWidget.Y.labelPlus;
        jogWidget.yMinus = JsonObject.jogWidget.Y.labelMinus;
        jogWidget.zPlus = JsonObject.jogWidget.Z.labelPlus;
        jogWidget.zMinus = JsonObject.jogWidget.Z.labelMinus;


        jogWidget.jogResolution_1 = JsonObject.jogWidget.jogResolution.jogResolution_1;
        jogWidget.jogResolution_2 = JsonObject.jogWidget.jogResolution.jogResolution_2;
        jogWidget.jogResolution_3 = JsonObject.jogWidget.jogResolution.jogResolution_3;
        jogWidget.jogResolution_4 = JsonObject.jogWidget.jogResolution.jogResolution_4;
        jogWidget.jogResolution_5 = JsonObject.jogWidget.jogResolution.jogResolution_5;
//        jogWidget.jogResolution_6 = JsonObject.jogWidget.jogResolution.jogResolution_6;
//        jogWidget.jogResolution_7 = JsonObject.jogWidget.jogResolution.jogResolution_7;
//        jogWidget.jogResolution_8 = JsonObject.jogWidget.jogResolution.jogResolution_8;

        jogWidget.jogFeedrateMin = JsonObject.jogWidget.jogFeedrate.min;
        jogWidget.jogFeedrateMax = JsonObject.jogWidget.jogFeedrate.max;

        jogWidget.jogFeedrateDefault = JsonObject.jogWidget.jogFeedrate.defaultValue;
        jogWidget.jogFeedrateStepSize = JsonObject.jogWidget.jogFeedrate.stepSize;

        jogWidget.jogWidgetXColor = JsonObject.jogWidget.X.color;
        jogWidget.jogWidgetYColor = JsonObject.jogWidget.Y.color;
        jogWidget.jogWidgetZColor = JsonObject.jogWidget.Z.color;
        //        jogWidget.jogWidgetAColor = JsonObject.jogWidget.A.color;
        //        jogWidget.jogWidgetBColor = JsonObject.jogWidget.B.color;
        //        jogWidget.jogWidgetCColor = JsonObject.jogWidget.C.color;
    }

    Rectangle{
        id: jogPanel
        height: 250
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top


        Rectangle {
            id: jogBtns
            width: 318
            color: "#ffffff"
            anchors.left: parent.left
            anchors.top: label2.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            GridLayout {
                anchors.fill: parent

                columns: 5
                rows: 3

                CuteNCJogAxisBtn {
                    id:moveX_plus

                    Layout.column: 3
                    Layout.columnSpan: 1
                    Layout.row: 1
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetXColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: jogWidget.xPlus
                    btnIcon: jogWidget.btnIcon
                    rotationAngle: 90
                    enabled: jogWidget.enabled
                    onClicked:{
                        let step = parseFloat(resolutionWrapper.resolution) + parseFloat(axisController.getXPosition());
                        backend.commandReceived("G0 X"+step+" F"+slider.value,"JogWidget");
                    }
                }

                CuteNCJogAxisBtn {
                    id:moveX_minus
                    Layout.column: 0
                    Layout.columnSpan: 1
                    Layout.row: 1
                    Layout.rowSpan: 1
                    enabled: jogWidget.enabled
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetXColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: jogWidget.xMinus
                    btnIcon: jogWidget.btnIcon
                    rotationAngle: -90
                    onClicked:{
                        let step = parseFloat(axisController.getXPosition()) - parseFloat(resolutionWrapper.resolution);
                        backend.commandReceived("G0 X"+step+" F"+slider.value,"JogWidget");
                    }
                }

                CuteNCJogAxisBtn {
                    id:moveY_plus
                    enabled: jogWidget.enabled
                    Layout.column: 1
                    Layout.columnSpan: 1
                    Layout.row: 0
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetYColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: jogWidget.yPlus
                    btnIcon: jogWidget.btnIcon
                    onClicked:{
                        let step = parseFloat(axisController.getYPosition()) + parseFloat(resolutionWrapper.resolution);
                        backend.commandReceived("G0 Y"+step+" F"+slider.value,"JogWidget");
                    }
                }

                CuteNCJogAxisBtn {
                    id:moveY_minus
                    Layout.column: 1
                    Layout.columnSpan: 1
                    Layout.row: 2
                    Layout.rowSpan: 1

                    enabled: jogWidget.enabled
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetYColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: jogWidget.yMinus
                    btnIcon: jogWidget.btnIcon
                    rotationAngle: 180
                    onClicked:{
                        let step = parseFloat(axisController.getYPosition()) - parseFloat(resolutionWrapper.resolution);
                        backend.commandReceived("G0 Y"+step+" F"+slider.value,"JogWidget");
                    }
                }


                CuteNCJogAxisBtn {
                    id:moveZ_plus
                    enabled: jogWidget.enabled
                    Layout.column: 4
                    Layout.columnSpan: 1
                    Layout.row: 0
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetZColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: jogWidget.zPlus
                    btnIcon: jogWidget.btnIcon
                    onClicked:{
                        let step = parseFloat(axisController.getZPosition()) + parseFloat(resolutionWrapper.resolution);
                        backend.commandReceived("G0 Z"+step+" F"+slider.value,"JogWidget");
                    }
                }

                CuteNCJogAxisBtn {
                    id:moveZ_minus
                    enabled: jogWidget.enabled
                    Layout.column: 4
                    Layout.columnSpan: 1
                    Layout.row: 2
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetZColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: jogWidget.zMinus
                    btnIcon: jogWidget.btnIcon
                    rotationAngle: 180
                    onClicked:{
                        let step = parseFloat(axisController.getZPosition()) - parseFloat(resolutionWrapper.resolution);
                        backend.commandReceived("G0 Z"+step+" F"+slider.value,"JogWidget");
                    }
                }
            }
        }

        Rectangle {
            id: extraBtns
            height: 200
            color: "#ffffff"
            anchors.left: jogBtns.right
            anchors.right: parent.right
            anchors.top: label2.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 15
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.rightMargin: 15

            GridLayout {
                anchors.fill: parent

                columns: 2
                rows: 4

                CuteNCJogAuxButton{
                    id:zeroX
                    Layout.column: 0
                    Layout.columnSpan: 1
                    Layout.row: 0
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetXColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Zero X"
                    btnIcon: "\ue873"
                    enabled: jogWidget.enabled
                    onClicked:{
                        backend.commandReceived("G92 X0","JogWidget");
                    }
                }
                CuteNCJogAuxButton{
                    id:zeroY
                    Layout.column: 0
                    Layout.columnSpan: 1
                    Layout.row: 1
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetYColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Zero Y"
                    btnIcon: "\ue873"
                    enabled: jogWidget.enabled
                    onClicked:{
                        backend.commandReceived("G92 Y0","JogWidget");
                    }
                }
                CuteNCJogAuxButton{
                    id:zeroZ
                    Layout.column: 0
                    Layout.columnSpan: 1
                    Layout.row: 2
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetZColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Zero Z"
                    btnIcon: "\ue873"
                    enabled: jogWidget.enabled
                    onClicked:{
                        backend.commandReceived("G92 Z0","JogWidget");
                    }
                }
                CuteNCJogAuxButton{
                    id:zeroXYZ
                    Layout.column: 0
                    Layout.columnSpan: 1
                    Layout.row: 3
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Zero XYZ"
                    btnIcon: "\ue873"
                    enabled: jogWidget.enabled
                    onClicked:{
                        backend.commandReceived("G92 X0 Y0 Z0","JogWidget");
                    }
                }

                //


                CuteNCJogAuxButton{
                    id:homeX
                    Layout.column: 3
                    Layout.columnSpan: 1
                    Layout.row: 0
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    colorDefault: jogWidget.jogWidgetXColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Home X"
                    btnIcon: "\ue81f"
                    enabled: jogWidget.enabled
                    onClicked:{
                        backend.commandReceived("G28 X","JogWidget");
                    }
                }
                CuteNCJogAuxButton{
                    id:homeY
enabled: jogWidget.enabled
                    Layout.column: 3
                    Layout.columnSpan: 1
                    Layout.row: 1
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetYColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Home Y"
                    btnIcon: "\ue81f"
                    onClicked:{
                        backend.commandReceived("G28 Y","JogWidget");
                    }
                }
                CuteNCJogAuxButton{
                    id:homeZ
                    Layout.column: 3
                    Layout.columnSpan: 1
                    Layout.row: 2
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    colorDefault: jogWidget.jogWidgetZColor;
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Home Z"
                    btnIcon: "\ue81f"
                    enabled: jogWidget.enabled
                    onClicked:{
                        backend.commandReceived("G28 Z","JogWidget");
                    }
                }
                CuteNCJogAuxButton{
                    id:homeALL
                    Layout.column: 3
                    Layout.columnSpan: 1
                    Layout.row: 3
                    Layout.rowSpan: 1
                    Layout.fillHeight: true
                    Layout.fillWidth: true
enabled: jogWidget.enabled
                    fontFamily: jogWidget.fontFamily
                    btnLabel: "Home XYZ"
                    btnIcon: "\ue81f"
                    onClicked:{
                        backend.commandReceived("G28","JogWidget");
                    }
                }
            }
        }

        Label {
            id: label2
            text: qsTr("Jog widget")
            anchors.left: parent.left
            anchors.top: parent.top
            font.family: "Noto Sans"
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }


    }

    Rectangle {
        id: jogSettings
        width: 200
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: jogPanel.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        Row {
            id: row1
            width: 200
            height: 80
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: row2.bottom
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            Rectangle {
                id: feedrateWrapper
                anchors.fill: parent
                Layout.column: 0
                Layout.columnSpan: 1
                Layout.row: 1
                Layout.rowSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
                Slider {
                    id: slider
                    enabled: jogWidget.enabled
                    width: parent.width-50
                    anchors.left: parent.left
                    anchors.right: feedrateLabelWrapper.left
                    anchors.top: label3.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.rightMargin: 50
                    anchors.leftMargin: 0
                    from: jogWidget.jogFeedrateMin
                    value: jogWidget.jogFeedrateDefault
                    stepSize: jogWidget.jogFeedrateStepSize
                    to: jogWidget.jogFeedrateMax

                }


                Label {
                    id: label3
                    text: qsTr("Feedrate")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.family: "Noto Sans"
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                }

                Label {
                    id: feedrate
                    x: 750
                    y: 0
                    text: slider.value
                    anchors.left: slider.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    font.pointSize: 12
                    font.family: "Consolas"
                }
            }
        }

        Row {
            id: row2
            width: 200
            height: 80
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            Rectangle {
                id: resolutionWrapper
                anchors.fill: parent
                Layout.column: 0
                Layout.columnSpan: 1
                Layout.row: 3
                Layout.rowSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true

                property double resolution:10
                Label {
                    id: label
                    text: qsTr("Jog step size")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.family: "Noto Sans"
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                }

                Row {
                    id: row
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: label.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    enabled: jogWidget.enabled
                    RadioButton {
                        id: radioButton
                        text: jogWidget.jogResolution_1
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            resolutionWrapper.resolution = jogWidget.jogResolution_1
                        }


                    }

                    RadioButton {
                        id: radioButton1
                        text: jogWidget.jogResolution_2
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            resolutionWrapper.resolution = jogWidget.jogResolution_2
                        }

                    }

                    RadioButton {
                        id: radioButton2
                        text: jogWidget.jogResolution_3
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            resolutionWrapper.resolution = jogWidget.jogResolution_3
                        }

                    }

                    RadioButton {
                        id: radioButton3
                        text: jogWidget.jogResolution_4
                        anchors.verticalCenter: parent.verticalCenter
                        checked: true
                        onClicked: {
                            resolutionWrapper.resolution=jogWidget.jogResolution_4
                        }

                    }

                    RadioButton {
                        id: radioButton4
                        text: jogWidget.jogResolution_5
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            resolutionWrapper.resolution = jogWidget.jogResolution_5
                        }
                    }

                }
            }
        }
    }

}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:500;width:800}D{i:4}D{i:5}D{i:6}D{i:7}
D{i:8}D{i:9}D{i:3}D{i:2}D{i:12}D{i:13}D{i:14}D{i:15}D{i:16}D{i:17}D{i:18}D{i:19}D{i:11}
D{i:10}D{i:20}D{i:1}D{i:24}D{i:25}D{i:26}D{i:23}D{i:22}D{i:29}D{i:31}D{i:32}D{i:33}
D{i:34}D{i:35}D{i:30}D{i:28}D{i:27}D{i:21}
}
##^##*/
