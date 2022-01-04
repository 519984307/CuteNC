import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {
    id:cuteNCAxisReadoutRoot

    property int positionFontPointSize
    property font positionFontFamily

    property int fontPointSize
    property font fontFamily

    property color backgroundColor
    property color axisColor
    property string axisLabel


    property bool isMetric
    property color axisBackgroundColor

    property double axisPosition

    property int resolution

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        cuteNCAxisReadoutRoot.isMetric = JsonObjectTheme.unitsInMetric;

        cuteNCAxisReadoutRoot.fontPointSize = JsonObjectTheme.droWidget.fontPointSize;
        cuteNCAxisReadoutRoot.fontFamily = JsonObjectTheme.droWidget.fontFamily;

        cuteNCAxisReadoutRoot.backgroundColor = JsonObjectTheme.droWidget.backgroundColor;
        cuteNCAxisReadoutRoot.axisBackgroundColor = JsonObjectTheme.droWidget.axisBackgroundColor;

        cuteNCAxisReadoutRoot.positionFontPointSize = JsonObjectTheme.droWidget.positionFontPointSize;
        cuteNCAxisReadoutRoot.positionFontFamily = JsonObjectTheme.droWidget.positionFontFamily;

        cuteNCAxisReadoutRoot.resolution = JsonObjectTheme.droWidget.resolution;
    }

    Component.onCompleted: {
        jsonSettings();
    }

    QtObject{
        id:internal
        function getUnits(){
            if(cuteNCAxisReadoutRoot.isMetric){
                return "mm/min";
            }else{
                return "inch/min";
            }
        }

    }

    Rectangle{
        id:backgroundRectangle
        border.width: 0
        anchors.fill: parent
        Rectangle{
            id:axisLabelBg
            width: 50
            color: cuteNCAxisReadoutRoot.axisColor
            border.width: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Label{
                id:axisLbl
                color: backend.determineFontColor(cuteNCAxisReadoutRoot.axisColor) ? "#ffffff" : "#000000";
                text:cuteNCAxisReadoutRoot.axisLabel
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: cuteNCAxisReadoutRoot.fontPointSize
                font.family: cuteNCAxisReadoutRoot.fontFamily
            }

        }

        Rectangle{
            id:axisLabelPosition
            color: cuteNCAxisReadoutRoot.axisBackgroundColor
            border.width: 0
            anchors.left: axisLabelBg.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            Label{
                id:axisLblPos
                color: backend.determineFontColor(cuteNCAxisReadoutRoot.axisBackgroundColor) ? "#ffffff" : "#000000";
                text: cuteNCAxisReadoutRoot.axisPosition.toFixed(cuteNCAxisReadoutRoot.resolution)
                anchors.fill: parent
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                leftPadding: 15
                font.pointSize: cuteNCAxisReadoutRoot.positionFontPointSize
                font.family: cuteNCAxisReadoutRoot.positionFontFamily
            }

        }

    }

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }

}

/*##^##
Designer {
    D{i:0;height:50;width:400}D{i:1}D{i:4}D{i:3}D{i:6}D{i:5}D{i:2}D{i:7}
}
##^##*/
