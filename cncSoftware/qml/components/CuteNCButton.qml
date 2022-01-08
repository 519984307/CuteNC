import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15



Button {
    id:cuteNCButtonRoot
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

    property string thisText
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

    Component.onCompleted: {
        jsonSettings();
    }

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
    }

    onPressed: {
        //Util.backendFunction(cuteNCButtonRoot.backendFunction,cuteNCButtonRoot.name,cuteNCButtonRoot.value)
    }

    QtObject{
        id: internal

        property var dynamicBackgroundColor: if(cuteNCButtonRoot.down){
                                       cuteNCButtonRoot.down ? cuteNCButtonRoot.onPressedColor : cuteNCButtonRoot.defaultColor
                                   }else{
                                       cuteNCButtonRoot.hovered ? cuteNCButtonRoot.onHoverColor : cuteNCButtonRoot.defaultColor
                                   }
        property var dynamicBorderColor: if(cuteNCButtonRoot.down){
                                       cuteNCButtonRoot.down ? cuteNCButtonRoot.onPressedBorderColor : cuteNCButtonRoot.borderColor
                                   }else{
                                       cuteNCButtonRoot.hovered ? cuteNCButtonRoot.onHoverBorderColor : cuteNCButtonRoot.borderColor
                                   }
        property var dynamicTextColor: if(cuteNCButtonRoot.down){
                                       cuteNCButtonRoot.down ? cuteNCButtonRoot.textColorPressed : cuteNCButtonRoot.textColorDefault
                                   }else{
                                       cuteNCButtonRoot.hovered ? cuteNCButtonRoot.textColorHover : cuteNCButtonRoot.textColorDefault
                                   }
    }

    contentItem: Item{
        Text {
            text: cuteNCButtonRoot.thisText
            font: cuteNCButtonRoot.fontFamily
            color: internal.dynamicTextColor
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    background: Rectangle{
        color: internal.dynamicBackgroundColor
        radius: cuteNCButtonRoot.buttonRadius
        border.width: cuteNCButtonRoot.borderVisible ? cuteNCButtonRoot.borderWidth:0
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
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
    }

}

/*##^##
Designer {
    D{i:0;height:50;width:50}
}
##^##*/
