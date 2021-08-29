import QtQuick 2.0

Rectangle {
    id: templateWidget

    border.color: borderColor
    border.width: borderVisible ? borderWidth:0
    radius: borderRadius

    property bool setMaximumHeight: false
    property bool borderVisible

    property int minimumWidth: 320
    property int minimumHeight: 300
    property int maximumWidth: 320
    property int maximumHeight: 300

    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor
    property color borderColor

    property int borderWidth
    property int borderRadius
    property int fontPointSize
    property string fontFamily

    property string name
    property string value

    Component.onCompleted: {
        var JsonString = backend.getJSONConfigFile("TemplateFile.json");
        var JsonObject = JSON.parse(JsonString);

        //retrieve values from JSON
        name = JsonObject.name;
        value = JsonObject.value;

        borderVisible = JsonObject.borderVisible;
        borderWidth = JsonObject.borderWidth;
        borderRadius = JsonObject.borderRadius;

        textColorLight = JsonObject.colors.textColorLight;
        textColorDark = JsonObject.colors.textColorDark;
        defaultColor = JsonObject.colors.defaultColor;
        onHoverColor = JsonObject.colors.onHoverColor;
        onPressedColor = JsonObject.colors.onPressedColor
        backgroundColor = JsonObject.colors.backgroundColor;
        borderColor = JsonObject.colors.borderColor;

    }


    function setWidgetSize(){
        if(templateWidget.width < minimumWidth){
            templateWidget.width = minimumWidth
        }
        if(templateWidget.height < minimumHeight){
            templateWidget.height = minimumHeight
        }

        if(setMaximumHeight == true){
            if(templateWidget.width > maximumWidth){
                templateWidget.width = maximumWidth
            }
            if(templateWidget.height > maximumHeight){
                templateWidget.height = maximumHeight
            }
        }
    }

    onWidthChanged: {setWidgetSize()}
    onHeightChanged: {setWidgetSize()}

}
