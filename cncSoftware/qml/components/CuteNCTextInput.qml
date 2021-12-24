import QtQuick 2.0
import QtQuick.Controls 2.15

Item{
    id: textInputRoot
    height: 50
    width:100

    property string placeholder: "Type here..."
    property color placeholderColor:"#404040"

    property bool borderVisible: true
    property int borderWidth: 1
    property int borderRadius

    property int fontPointSize:12
    property font fontFamily


    property int radius: 15
    //Theme
    property string backgroundColor: "#E6E6E6"
    //Component theme
    property string colorDefault: "#E6E6E6"
    property color colorMouseOver: "#E6E6E6"
    property color colorPressed: "#E6E6E6"
    property color textColor: "#222222"

    property color textColorLight: "#FFFFFF"
    property color textColorDark: "#222222"



    property color onPressedColor:"#E6E6E6"
    property color onPressedBorderColor:"#C32C30"
    property color onHoverBorderColor:"#404040"
    property color borderColor:"#404040"

    property var onTextChanged

    function getText() {return inputBox.text;}

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        placeholder = JsonObjectTheme.textInput.placeholder;
        placeholderColor = JsonObjectTheme.textInput.placeholderColor;

        colorMouseOver = JsonObjectTheme.textInput.onHoverColor;
        colorPressed = JsonObjectTheme.textInput.onPressedColor
        textColorLight = JsonObjectTheme.textInput.textColorLight;
        textColorDark = JsonObjectTheme.textInput.textColorDark;

        colorDefault = JsonObjectTheme.textInput.defaultColor;
        onPressedColor = JsonObjectTheme.textInput.onPressedColor;
        onPressedBorderColor = JsonObjectTheme.textInput.onPressedBorderColor;
        onHoverBorderColor = JsonObjectTheme.textInput.onHoverBorderColor;
        borderColor = JsonObjectTheme.textInput.borderColor;
        borderVisible = JsonObjectTheme.textInput.borderVisible;
        borderWidth = JsonObjectTheme.textInput.borderWidth;
        radius = JsonObjectTheme.textInput.radius;
        fontPointSize = JsonObjectTheme.textInput.fontPointSize;
        fontFamily = JsonObjectTheme.textInput.fontFamily;

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
        property var dynamicTextColor:if(backend.determineFontColor(backgroundColor)){
                                          inputBox.color = textColorLight
                                      }else{
                                          inputBox.color = textColorDark
                                      }
        property var dynamicText: if(inputBox.text == ""){
                                      placeholderLbl.visible = true
                                  }else{
                                      placeholderLbl.visible = false
                                  }


    }

    Rectangle{
        id:bgRectangle
        color:backgroundColor
        radius:textInputRoot.radius
        anchors.fill:parent

            TextInput{
                id:inputBox
                anchors.fill:parent
                anchors.margins: 8
                font.pointSize: textInputRoot.fontPointSize
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                font.family: textInputRoot.fontFamily
                selectByMouse: true
                layer.enabled: true
                wrapMode: TextInput.NoWrap
                onTextChanged: textInputRoot.onTextChanged
                Label{
                    id:placeholderLbl
                    font.family: parent.font.family
                    font.pointSize: parent.font.pointSize
                    font.italic: false
                    text:placeholder
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    leftInset: 2
                    leftPadding: 2
                    color:placeholderColor
                }
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


/*##^##
Designer {
    D{i:0;height:50;width:200}D{i:1}D{i:4}D{i:3}D{i:2}D{i:5}
}
##^##*/
