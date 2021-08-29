import QtQuick 2.0

Rectangle {
    id: templateWidget

    width: setWidth
    height: setHeight

    border.color: borderColor
    border.width: borderVisible ? borderWidth:0
    radius: borderRadius

    property int setWidth
    property int setHeight
    property int minimumWidth
    property int minimumHeight
    property int maximumWidth
    property int maximumHeight
    property bool setMaximumHeight

    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor
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
        var JsonString = backend.getJSONFile("../json/","TemplateFile.json");
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

        setWidth = JsonObject.width;
        setHeight = JsonObject.height;
        minimumWidth = JsonObject.minimumWidth;
        minimumHeight = JsonObject.minimumHeight;
        maximumWidth = JsonObject.maximumWidth;
        maximumHeight = JsonObject.maximumHeight;
        setMaximumHeight = JsonObject.setMaximumHeight;

        fontAwesomeIcon = JsonObject.fontAwesomeIcon;
        text = JsonObject.text;

    }

    Component.onCompleted: {
        jsonSettings()
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

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }

}
