import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15



Item {
    id:cuteNCAxisReadoutRoot

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

    property bool borderVisible
    property int borderWidth
    property int borderRadius

    property int fontPointSize
    property font fontFamily

    property string thisText
    property string name
    property string value

    property int buttonRadius

    property color backgroundColor

    property color textColorDefault
    property color textColorHover
    property color textColorPressed
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color onPressedBorderColor
    property color onHoverBorderColor
    property color borderColor

    property string backendFunction


    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);


        //Theme
        backgroundColor = JsonObjectTheme.backgroundColor;

        //Component theme
        textColorHover = JsonObjectTheme.button.textColorHover;
        textColorPressed = JsonObjectTheme.button.textColorPressed;
        textColorDefault = JsonObjectTheme.button.textColorDefault;
        defaultColor = JsonObjectTheme.button.defaultColor;
        onHoverColor = JsonObjectTheme.button.onHoverColor;
        onPressedColor = JsonObjectTheme.button.onPressedColor
        borderColor = JsonObjectTheme.button.borderColor;
        onPressedBorderColor = JsonObjectTheme.button.onPressedBorderColor;
        onHoverBorderColor = JsonObjectTheme.button.onHoverBorderColor;
        buttonRadius = JsonObjectTheme.button.radius;


        //Specified variables from JSON
        //retrieve values from JSON
        name = JsonObject.name;
        value = JsonObject.value;

        setWidth = JsonObject.width;
        setHeight = JsonObject.height;

        minimumWidth = JsonObject.minimumWidth;
        minimumHeight = JsonObject.minimumHeight;
        maximumWidth = JsonObject.maximumWidth;
        maximumHeight = JsonObject.maximumHeight;

        setMaximumSize = JsonObject.setMaximumSize;
        setMinimumSize = JsonObject.setMinimumSize;

        borderVisible = JsonObject.borderVisible;
        borderWidth = JsonObject.borderWidth;
        borderRadius = JsonObject.borderRadius;
       // buttonRadius = JsonObject.buttonRadius;

        fontPointSize = JsonObject.fontPointSize;
        fontFamily = JsonObject.fontFamily;

        backendFunction = JsonObject.backendFunction;
        value = JsonObject.value;

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
    D{i:0;height:50;width:50}
}
##^##*/
