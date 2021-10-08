import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnLeftMenu

    //Custom properties
    property string btnIcon: "\uE80F"
    property color colorDefault: "#1f1f1f"
    property color colorMouseOver: "#313131"
    property color colorPressed: "#00a1f1"
    property color colorText: "#ffffff"
    property color highlightedColorLeft: "#f77f00"
    property string highlightedColorRight: "#313131"
    property bool isActive: false

    property string textBtn: ""
    property int iconSize: 16
    property int textSize: 12
    property int flagSize: 5
    property int cornerRadius: 0
    property bool shadowEnabled: true
    property bool leftFlagVisible: true
    property int stickingOutAmount: 30
    property color pageColor
    property bool rightFlagColorSameAsPageColor


    function jsonSettings(){

        //Get Theme JSON
        var JsonStringTheme = backend.getJSONFile("../json/Themes/",backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        //Component theme - theme
        colorDefault = JsonObjectTheme.menuButton.defaultColor;
        colorMouseOver = JsonObjectTheme.menuButton.onHoverColor;
        colorPressed = JsonObjectTheme.menuButton.onPressedColor
        colorText = JsonObjectTheme.menuButton.textColorDefault;
        highlightedColorLeft = JsonObjectTheme.menuButton.highlightedColorLeft;
        highlightedColorRight = JsonObjectTheme.menuButton.highlightedColorRight
        iconSize = JsonObjectTheme.menuButton.iconSize;
        flagSize = JsonObjectTheme.menuButton.flagSize;
        cornerRadius = JsonObjectTheme.menuButton.cornerRadius;
        shadowEnabled = JsonObjectTheme.menuButton.shadowEnabled;
        stickingOutAmount = JsonObjectTheme.menuButton.stickingOutAmount;
        textSize = JsonObjectTheme.menuButton.textSize;
        leftFlagVisible = JsonObjectTheme.menuButton.leftFlagVisible;
        rightFlagColorSameAsPageColor = JsonObjectTheme.menuButton.rightFlagColorSameAsPageColor
    }

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }

    Component.onCompleted: {
        jsonSettings()
    }

    QtObject{
        id:internal
        property bool containsMouse: false
        property var dynamicColor: if(btnLeftMenu.down){
                                       btnLeftMenu.down ? colorPressed : colorDefault
                                   }else{
                                       btnLeftMenu.hovered ? colorMouseOver : colorDefault

                                   }
        property var dynamicWidth:{
            if(isActive){
                extend.running = true
            }else{
                descend.running = true
            }
        }

        property bool isShadowVisible: {
            if(shadowEnabled){
                shadow.visible = true;
            }else{
                shadow.visible = false;
            }
        }
        property bool isLeftFlagVisible: {
            if(leftFlagVisible){
                flagLeft.width = flagSize
            }else{
                flagLeft.visible = 0
            }
        }
        property var isRightFlagColorSameAsPageColor:{
            if(rightFlagColorSameAsPageColor){
                //flagLeft.color = pageColor
            }else{
               // flagRight.color = highlightedColorRight
            }
        }
    }

    onHoveredChanged: if(btnLeftMenu.hovered){
                          waitBeforeDescendAnimationLeftMenu.stop()
                          extendLeftMenu.running = true
                      }else{
                          waitBeforeDescendAnimationLeftMenu.start()
                      }




    PropertyAnimation{
        id: extend
        target: flagRight
        property: "width"
        to: stickingOutAmount
        duration: 50
        easing.type: Easing.Linear
    }
    PropertyAnimation{
        id: descend
        target: flagRight
        property: "width"
        to: 0
        duration: 50
        easing.type: Easing.Linear
    }




    width: 70
    height: 60

    background: Rectangle{

        id:bgBtnColor
        color:internal.dynamicColor


        Rectangle{
            id: flagLeft
            anchors{
                top:parent.top
                bottom: parent.bottom
                left: parent.left
            }
            color: highlightedColorLeft
            width: flagSize
            visible: isActive
        }


        Rectangle{
            id:flagRight
            x: btnLeftMenu.width
            y: 17
            width: flagSize
            height: btnLeftMenu.height
            radius: cornerRadius
            color: rightFlagColorSameAsPageColor ? pageColor : highlightedColorRight
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: -flagRight.width/2


        }
        InnerShadow {
              id:shadow
              anchors.fill: flagRight
              radius: 4.0
              samples: 16
              horizontalOffset:2
              verticalOffset: 0
              color: "#b0000000"
              source: flagRight
          }
    }
    contentItem: Item{
        anchors.fill: parent
        id:content
        Label {
            id: btnImage

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: (mainWindow.leftMenuExtendedWidth/2) - btnImage.width/2

            antialiasing: true
            color: colorText

            font.pointSize: iconSize
            font.family: "fontello"

            text: btnIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        Label {
            id: label
            text: textBtn
            font.pointSize: textSize
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: mainWindow.leftMenuExtendedWidth
            color: colorText
        }
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:3;width:75}D{i:7}
}
##^##*/
