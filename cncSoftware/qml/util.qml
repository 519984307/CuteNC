pragma Singleton
import QtQuick 2.0

Item{
    function getJsonSettings(filename){
        var JsonString = backend.getJSONFile("../json/",filename);
        var JsonObject = JSON.parse(JsonString);
        var JsonStringTheme = backend.getJSONFile("../json/themes/",backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);


        //Theme
        backgroundColor = JsonObjectTheme.backgroundColor;
        textColorLight = JsonObjectTheme.textColorLight;
        textColorDark = JsonObjectTheme.textColorDark;
        defaultColor = JsonObjectTheme.defaultColor;
        onHoverColor = JsonObjectTheme.onHoverColor;
        onPressedColor = JsonObjectTheme.onPressedColor
        borderColor = JsonObjectTheme.borderColor;


        //Specified variables from JSON
        //retrieve values from JSON
        name = JsonObject.name;
        value = JsonObject.value;

        borderVisible = JsonObject.borderVisible;
        borderWidth = JsonObject.borderWidth;
        borderRadius = JsonObject.borderRadius;

        setWidth = JsonObject.width;
        setHeight = JsonObject.height;
        minimumWidth = JsonObject.minimumWidth;
        minimumHeight = JsonObject.minimumHeight;
        maximumWidth = JsonObject.maximumWidth;
        maximumHeight = JsonObject.maximumHeight;

        setMaximumSize = JsonObject.setMaximumSize;
        setMinumumSize = JsonObject.setMinumumSize;


        fontAwesomeIcon = JsonObject.fontAwesomeIcon;
        text = JsonObject.text;

    }

    function backendFunction(fname,objname,objvalue){
        if(fname == "debug"){
            consoleLog.log("info",objname,objvalue)
        }
    }
}
