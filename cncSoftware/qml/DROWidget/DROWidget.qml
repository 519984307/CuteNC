import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../components"
import QtQuick.Layouts 1.11
Item {
    id:droWidgetRoot

    property string xAxisLabel
    property string yAxisLabel
    property string zAxisLabel
    property string aAxisLabel
    property string bAxisLabel
    property string cAxisLabel


    property color xAxisColor
    property color yAxisColor
    property color zAxisColor
    property color aAxisColor
    property color bAxisColor
    property color cAxisColor

    property bool xAxisBool
    property bool yAxisBool
    property bool zAxisBool
    property bool aAxisBool
    property bool bAxisBool
    property bool cAxisBool

    property color backgroundColor
    property int resolution

    Component.onCompleted: {
        jsonSettings()
    }

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        droWidgetRoot.resolution = JsonObjectTheme.droWidget.resolution;

        droWidgetRoot.xAxisColor = JsonObjectTheme.droWidget.axes.xAxis.color;
        droWidgetRoot.yAxisColor = JsonObjectTheme.droWidget.axes.yAxis.color;
        droWidgetRoot.zAxisColor = JsonObjectTheme.droWidget.axes.zAxis.color;
        droWidgetRoot.aAxisColor = JsonObjectTheme.droWidget.axes.aAxis.color;
        droWidgetRoot.bAxisColor = JsonObjectTheme.droWidget.axes.bAxis.color;
        droWidgetRoot.cAxisColor = JsonObjectTheme.droWidget.axes.cAxis.color;

        droWidgetRoot.xAxisLabel = JsonObjectTheme.droWidget.axes.xAxis.label;
        droWidgetRoot.yAxisLabel = JsonObjectTheme.droWidget.axes.yAxis.label;
        droWidgetRoot.zAxisLabel = JsonObjectTheme.droWidget.axes.zAxis.label;
        droWidgetRoot.aAxisLabel = JsonObjectTheme.droWidget.axes.aAxis.label;
        droWidgetRoot.bAxisLabel = JsonObjectTheme.droWidget.axes.bAxis.label;
        droWidgetRoot.cAxisLabel = JsonObjectTheme.droWidget.axes.cAxis.label;

        droWidgetRoot.xAxisBool = JsonObjectTheme.droWidget.axes.xAxis.enabled;
        droWidgetRoot.yAxisBool = JsonObjectTheme.droWidget.axes.yAxis.enabled;
        droWidgetRoot.zAxisBool = JsonObjectTheme.droWidget.axes.zAxis.enabled;
        droWidgetRoot.aAxisBool = JsonObjectTheme.droWidget.axes.aAxis.enabled;
        droWidgetRoot.bAxisBool = JsonObjectTheme.droWidget.axes.bAxis.enabled;
        droWidgetRoot.cAxisBool = JsonObjectTheme.droWidget.axes.cAxis.enabled;
        droWidgetRoot.backgroundColor = JsonObjectTheme.droWidget.backgroundColor;
    }

    QtObject{
        id:internal
        function calculateNeededHeight(){
            let axesCount = 0;
            if(droWidgetRoot.xAxisBool){ axesCount++}
            if(droWidgetRoot.yAxisBool){ axesCount++}
            if(droWidgetRoot.zAxisBool){ axesCount++}
            if(droWidgetRoot.aAxisBool){ axesCount++}
            if(droWidgetRoot.bAxisBool){ axesCount++}
            if(droWidgetRoot.cAxisBool){ axesCount++}
            console.log("needed axes:");
            console.log(axesCount)
            return axesCount;
        }
        function resizeGrid(){
            grid.rows = calculateNeededHeight();
            //^ not working :(
        }

        function returnDoubleWithResolution(){

        }
    }

    Rectangle{
        id:droBackgroundRectangle
        color: droWidgetRoot.backgroundColor
        anchors.fill: parent

        GridLayout{
            id:grid
            columns: 1
            columnSpacing: 0;
            rows: internal.calculateNeededHeight();
            rowSpacing: 0
            CuteNCAxisReadout{
                id:xAxisReadout
                height: droBackgroundRectangle.height/(internal.calculateNeededHeight())
                width: droBackgroundRectangle.width
                axisColor: droWidgetRoot.xAxisColor
                axisLabel: droWidgetRoot.xAxisLabel
                visible: droWidget.xAxisBool
                axisPosition: axisController.getXPosition()
            }

            CuteNCAxisReadout{
                id:yAxisReadout
                height: droBackgroundRectangle.height/(internal.calculateNeededHeight())
                width: droBackgroundRectangle.width
                axisColor: droWidgetRoot.yAxisColor
                axisLabel: droWidgetRoot.yAxisLabel
                visible: droWidget.yAxisBool
                axisPosition: axisController.getYPosition()
            }

            CuteNCAxisReadout{
                id:zAxisReadout
                height: droBackgroundRectangle.height/(internal.calculateNeededHeight())
                width: droBackgroundRectangle.width
                axisColor: droWidgetRoot.zAxisColor
                axisLabel: droWidgetRoot.zAxisLabel
                visible: droWidget.zAxisBool
                axisPosition: axisController.getZPosition()
            }

            CuteNCAxisReadout{
                id:aAxisReadout
                height: droBackgroundRectangle.height/(internal.calculateNeededHeight())
                width: droBackgroundRectangle.width
                axisColor: droWidgetRoot.aAxisColor
                axisLabel: droWidgetRoot.aAxisLabel
                visible: droWidget.aAxisBool
                axisPosition: axisController.getAPosition()
            }

            CuteNCAxisReadout{
                id:bAxisReadout
                height: droBackgroundRectangle.height/(internal.calculateNeededHeight())
                width: droBackgroundRectangle.width
                axisColor: droWidgetRoot.bAxisColor
                axisLabel: droWidgetRoot.bAxisLabel
                visible: droWidget.bAxisBool
                axisPosition: axisController.getBPosition()
            }

            CuteNCAxisReadout{
                id:cAxisReadout
                height: droBackgroundRectangle.height/(internal.calculateNeededHeight())
                width: droBackgroundRectangle.width
                axisColor: droWidgetRoot.cAxisColor
                axisLabel: droWidgetRoot.cAxisLabel
                visible: droWidget.cAxisBool
                axisPosition: axisController.getCPosition()
            }
        }
    }


    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
            internal.resizeGrid()
        }
    }
    Connections{
        target: axisController
    }

}

/*##^##
Designer {
    D{i:0;height:50;width:50}D{i:1}D{i:4}D{i:5}D{i:6}D{i:7}D{i:8}D{i:9}D{i:3}D{i:2}D{i:10}
D{i:11}
}
##^##*/
