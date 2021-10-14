import QtQuick 2.0

Item{
    id: root
    height: 50
    width:100
    property color textColorLight
    property color textColorDark

    property bool borderVisible
    property int borderWidth
    property int borderRadius

    property int fontPointSize:12
    property font fontFamily


    property int boxRadius
    //Theme
    property string backgroundColor
    //Component theme
    property string colorDefault
    property color colorMouseOver
    property color colorPressed
    property color colorTextLight
    property color colorTextDark
    property color onPressedColor
    property color onPressedBorderColor
    property color onHoverBorderColor
    property color borderColor

    property bool shadowEnabled

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJSONFile("../json/themes/",backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        colorDefault = JsonObjectTheme.textInput.defaultColor;
        colorMouseOver = JsonObjectTheme.textInput.onHoverColor;
        colorPressed = JsonObjectTheme.textInput.onPressedColor
        colorTextLight = JsonObjectTheme.textInput.textColorLight;
        colorTextDark = JsonObjectTheme.textInput.textColorDark;

        onPressedColor = JsonObjectTheme.textInput.onPressedColor;
        onPressedBorderColor = JsonObjectTheme.textInput.onPressedBorderColor;
        onHoverBorderColor = JsonObjectTheme.textInput.onHoverBorderColor;
        borderColor = JsonObjectTheme.textInput.borderColor;

        boxRadius = JsonObjectTheme.textInput.boxRadius;
        shadowEnabled = JsonObjectTheme.textInput.shadowEnabled;

        fontPointSize = JsonObjectTheme.textInput.fontPointSize;

        //Specified variables from JSON
        //retrieve values from JSON
    }
    QtObject{
        id: internal

        property var dynamicColor: if(inputBox.down){
                                       inputBox.down ? colorPressed : colorDefault
                                   }else{
                                       inputBox.hovered ? colorMouseOver : colorDefault
                                   }
        property var dynamicTextColor:if(backend.determineFontColor(colorDefault)){
                                          inputBox.color = colorTextLight
                                      }else{
                                          inputBox.color = colorTextDark
                                      }


    }
    Rectangle{
        id:bgRectangle
        color:colorDefault
        radius:boxRadius
        anchors.fill:parent
        TextInput{
            id:inputBox
            anchors.fill:parent
            font.pointSize: root.fontPointSize
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter

        }
    }

    Component.onCompleted: {
        jsonSettings()
    }

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }
}

