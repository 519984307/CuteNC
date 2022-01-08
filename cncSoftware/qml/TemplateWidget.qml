import QtQuick 2.0

Rectangle {
    id: templateWidget

    width: setWidth
    height: setHeight

    border.color: borderColor
    border.width: borderVisible ? borderWidth:0
    radius: borderRadius

    color: backgroundColor

    //default
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
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor
    property color borderColor

    property bool borderVisible
    property int borderWidth
    property int borderRadius

    property int fontPointSize
    property font fontFamily

    property string fontAwesomeIcon
    property string text
    property string name
    property string value

    property string backendFunction


    //if button
//    onPressed: {
//        Util.backendFunction(main.backendFunction,main.name,main.value)
//    }



    function setParentDimensions(){
        templateWidget.parent.parent.info()
    }

    function jsonSettings(){
        //Get Button JSON
        var JsonString = backend.getJSONFile("../json/widgets/","ExampleWidget.json");
        var JsonObject = JSON.parse(JsonString);


        //Get Theme JSON
        var JsonStringTheme = backend.getJSONFile("../json/themes/",backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);


        //Theme
        backgroundColor = JsonObjectTheme.backgroundColor;

        //Component theme
        //Overwrite Theme with Widget settings
        if(JsonObject.hasOwnProperty("buttons")){
            console.log("OVERWRITING buttons")

            //Component theme - widget

            for(var i = 0 ; i < JsonObject.buttons.length; i++){
                console.log("Overwriting button: "+i+" objectName: "+JsonObject.buttons[i].objectName)
                //create button for every Buttons[i]
                var component;
                var button;

                component = Qt.createComponent("../qml/components/CuteNCButton.qml");
                 console.log("created CuteNCButton")
                if( component.status !== Component.Ready )
                {
                    if( component.status === Component.Error )
                        console.debug("Error:"+ component.errorString() );
                    return; // or maybe throw
                }
                //create at y=0 x=0, proper placing happens next
                button = component.createObject(this, {"x": 0, "y": 0});

                //Overwrite values from widget json
                //#1 check if variables exist if they dont use default ones from eg. Button.json

                if(JsonObject.buttons[i].hasOwnProperty("objectName")) {button.objectName = JsonObject.buttons[i].objectName}
                if(JsonObject.buttons[i].hasOwnProperty("text")) {button.thistext = JsonObject.buttons[i].text}

                //positioning
                if(JsonObject.buttons[i].hasOwnProperty("anchorsFill")) {button.anchors.fill = JsonObject.buttons[i].anchorsFill}

                if(JsonObject.buttons[i].hasOwnProperty("anchorsLeft")) {button.anchors.left = JsonObject.buttons[i].anchorsLeft}
                if(JsonObject.buttons[i].hasOwnProperty("anchorsRight")) {button.anchor.right = JsonObject.buttons[i].anchorsRight}
                if(JsonObject.buttons[i].hasOwnProperty("anchorsTop")) {button.anchor.top = JsonObject.buttons[i].anchorsTop}
                if(JsonObject.buttons[i].hasOwnProperty("anchorsBottom")) {button.anchor.bottom = JsonObject.buttons[i].anchorsBottom}

                if(JsonObject.buttons[i].hasOwnProperty("anchorsLeftMargin")) {button.anchors.leftMargin = JsonObject.buttons[i].anchorsLeftMargin}
                if(JsonObject.buttons[i].hasOwnProperty("anchorsRightMargin")) {button.anchor.rightMargin = JsonObject.buttons[i].anchorsRightMargin}
                if(JsonObject.buttons[i].hasOwnProperty("anchorsTopMargin")) {button.anchor.topMargin = JsonObject.buttons[i].anchorsTopMargin}
                if(JsonObject.buttons[i].hasOwnProperty("anchorsBottomMargin")) {button.anchor.bottomMargin = JsonObject.buttons[i].anchorsBottomMargin}

                if(JsonObject.buttons[i].hasOwnProperty("parent")) {button.parent = JsonObject.buttons[i].parent}
                if(JsonObject.buttons[i].hasOwnProperty("x")) {button.x = JsonObject.buttons[i].x}
                if(JsonObject.buttons[i].hasOwnProperty("y")) {button.y = JsonObject.buttons[i].y}

                //sizes
                if(JsonObject.buttons[i].hasOwnProperty("width")) {button.width = JsonObject.buttons[i].width}
                if(JsonObject.buttons[i].hasOwnProperty("height")) {button.height = JsonObject.buttons[i].height}

                //colors
                if(JsonObject.buttons[i].hasOwnProperty("defaultColor")) {button.defaultColor = JsonObject.buttons[i].defaultColor}
                if(JsonObject.buttons[i].hasOwnProperty("onHoverColor")) {button.onHoverColor = JsonObject.buttons[i].onHoverColor}
                if(JsonObject.buttons[i].hasOwnProperty("onPressedColor")) {button.onPressedColor = JsonObject.buttons[i].onPressedColor}
                if(JsonObject.buttons[i].hasOwnProperty("textColorDefault")) {button.textColorDefault = JsonObject.buttons[i].textColorDefault}
                if(JsonObject.buttons[i].hasOwnProperty("textColorHover")) {button.textColorHover = JsonObject.buttons[i].textColorHover}
                if(JsonObject.buttons[i].hasOwnProperty("borderColor")) {button.borderColor = JsonObject.buttons[i].borderColor}
                if(JsonObject.buttons[i].hasOwnProperty("onHoverBorderColor")) {button.onHoverBorderColor = JsonObject.buttons[i].onHoverBorderColor}
                if(JsonObject.buttons[i].hasOwnProperty("onPressedBorderColor")) {button.onPressedBorderColor = JsonObject.buttons[i].onPressedBorderColor}


//                textColorHover = JsonObject.buttons[i].textColorHover;
//                textColorPressed = JsonObject.buttons[i].textColorPressed;
//                textColorDefault = JsonObject.buttons[i].textColorDefault;
//                defaultColor = JsonObject.buttons[i].defaultColor;
//                onHoverColor = JsonObject.buttons[i].onHoverColor;
//                onPressedColor = JsonObject.buttons[i].onPressedColor
//                borderColor = JsonObject.buttons[i].borderColor;
//                onPressedBorderColor = JsonObject.buttons[i].onPressedBorderColor;
//                onHoverBorderColor = JsonObject.buttons[i].onHoverBorderColor;
            }
        }else{
            //Use theme settings
            console.log("JsonObject doesnt have button arg: NOT OVERWRITING")
            //Component theme - theme
            textColorHover = JsonObjectTheme.button.textColorHover;
            textColorPressed = JsonObjectTheme.button.textColorPressed;
            textColorDefault = JsonObjectTheme.button.textColorDefault;
            defaultColor = JsonObjectTheme.button.defaultColor;
            onHoverColor = JsonObjectTheme.button.onHoverColor;
            onPressedColor = JsonObjectTheme.button.onPressedColor
            borderColor = JsonObjectTheme.button.borderColor;
            onPressedBorderColor = JsonObjectTheme.button.onPressedBorderColor;
            onHoverBorderColor = JsonObjectTheme.button.onHoverBorderColor;
        }

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


        fontPointSize = JsonObject.fontPointSize;
        fontFamily = JsonObject.fontFamily;

        fontAwesomeIcon = JsonObject.fontAwesomeIcon;
        text = JsonObject.text;

        //not required for widget
        //backendFunction = JsonObject.backendFunction;
        //value = JsonObject.value;

    }

    Component.onCompleted: {
        jsonSettings()
        if(minimumHeight > maximumHeight || minimumWidth > maximumWidth){
            minimumHeight = maximumHeight;
            minimumWidth = maximumWidth;
        }

        templateWidget.parent.parent.setProperties(name,setWidth,setHeight,minimumWidth,minimumHeight,maximumWidth,maximumHeight)
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
