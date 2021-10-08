import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15



Button {
    id:main
    width: setWidth
    height: setHeight

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

    property string fontAwesomeIcon
    property string thistext
    property string name
    property string value

    property int buttonRadius
    //Theme
    property color backgroundColor
    //Component theme
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
        //Get Button JSON
        var JsonString = backend.getJSONFile("../json/Components/","Button.json");
        var JsonObject = JSON.parse(JsonString);


        //Get Theme JSON
        var JsonStringTheme = backend.getJSONFile("../json/themes/",backend.getSelectedTheme());
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
        buttonRadius = JsonObject.buttonRadius;

        fontPointSize = JsonObject.fontPointSize;
        fontFamily = JsonObject.fontFamily;

        fontAwesomeIcon = JsonObject.fontAwesomeIcon;
        thistext = JsonObject.text;

        backendFunction = JsonObject.backendFunction;
        value = JsonObject.value;

    }

    onPressed: {
        //Util.backendFunction(main.backendFunction,main.name,main.value)
    }

    QtObject{
        id: internal

        property var dynamicBackgroundColor: if(main.down){
                                       main.down ? main.onPressedColor : main.defaultColor
                                   }else{
                                       main.hovered ? main.onHoverColor : main.defaultColor
                                   }
        property var dynamicBorderColor: if(main.down){
                                       main.down ? main.onPressedBorderColor : main.borderColor
                                   }else{
                                       main.hovered ? main.onHoverBorderColor : main.borderColor
                                   }
        property var dynamicTextColor: if(main.down){
                                       main.down ? main.textColorPressed : main.textColorDefault
                                   }else{
                                       main.hovered ? main.textColorHover : main.textColorDefault
                                   }
    }

    contentItem: Item{
        Text {
            text: qsTr(main.thistext)
            font: main.fontFamily
            color: internal.dynamicTextColor
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Component.onCompleted: {
            jsonSettings()
        }
    }

    background: Rectangle{
        color: internal.dynamicBackgroundColor
        radius: main.buttonRadius
        border.width: main.borderVisible ? main.borderWidth:0
        border.color: internal.dynamicBorderColor
    }




    function setWidgetSize(){
        if(setMinimumSize == true){
            if(this.width < minimumWidth){
                this.width = minimumWidth
            }
            if(this.height < minimumHeight){
                this.height = minimumHeight
            }
        }
        if(setMaximumSize == true){
            if(this.width > maximumWidth){
                this.width = maximumWidth
            }
            if(this.height > maximumHeight){
                this.height = maximumHeight
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

/*##^##
Designer {
    D{i:0;height:50;width:50}
}
##^##*/