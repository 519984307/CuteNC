import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import "../components"

Rectangle{
    id:gCodeMacrosRoot
    width: 600
    height: 600

    Keys.onPressed: {
           console.log("key has been pressed");
        console.log(Keys.pressed());

       }


   CuteNCButton{
       id:openPopupMacrosWindow
       width: 100
       height: 50
       onClicked: popup.open();
   }

   Popup {
       id: popup
       x: 100
       y: 100
       modal: true
       focus: true

       anchors.centerIn: Overlay.overlay

       property int vmargins: 25
       property int vinsets: -6
       topMargin: vmargins
       leftMargin: vmargins
       rightMargin: vmargins
       bottomMargin: vmargins

       topInset: vinsets
       leftInset: vinsets
       rightInset: vinsets
       bottomInset: vinsets

       width:600
       height:600


       closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
       padding: 10

       background:Rectangle{
           color:'red'
           radius:10
       }

       contentItem: Rectangle{


       CuteNCGCodeTextEditor{
           id:gCodeEditor

       }

       Rectangle {
           id: topRect
           height: 50
           color: "#ffffff"
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.top: parent.top
           anchors.topMargin: 0
           anchors.rightMargin: 0
           anchors.leftMargin: 0

           CuteNCTextInput{
               id:textInput
               width: 200
               anchors.left: parent.left
               anchors.top: parent.top
               anchors.bottom: parent.bottom
               anchors.leftMargin: 10
               anchors.bottomMargin: 5
               anchors.topMargin: 5
           }

           CuteNCButton {
               id: button
               x: 532
               y: 5
               text: qsTr("Add")
               anchors.verticalCenter: parent.verticalCenter
               anchors.right: parent.right
               anchors.rightMargin: 8
               onClicked:
               {
                   var component;
                   var sprite;

                   component = Qt.createComponent("../EditorWidgetComponent.qml");
                   console.log("created editortemplatewidget")
                   if( component.status !== Component.Ready )
                   {
                       if( component.status === Component.Error )
                           console.debug("Error:"+ component.errorString() );
                       return; // or maybe throw
                   }
                   sprite = component.createObject(grid, {"x": 100, "y": 100});
                   sprite.widgetIndex = createdWidgets++;
                   createdWidgetsArr.push(sprite)
                   sprite.loaded()

               }
           }
       }

       Rectangle {
           id: bottomRect
           color: "#ffffff"
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.top: topRect.bottom
           anchors.bottom: buttonsBar.top
           anchors.topMargin: 0
           anchors.rightMargin: 0
           anchors.leftMargin: 0
           anchors.bottomMargin: 0

           CuteNCGCodeTextEditor{
               id:textEditor
               anchors.fill: parent
           }
       }

       Rectangle{
           id:buttonsBar
           height: 50
           anchors.left: parent.left
           anchors.right: parent.right
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 0
           anchors.rightMargin: 0
           anchors.leftMargin: 0

           CuteNCButton {
               id: btnSave
               x: 532
               y: 5
               width: 100
               height: 40
               text: qsTr("Add")
               anchors.verticalCenter: parent.verticalCenter
               anchors.right: parent.right
               anchors.rightMargin: 8
               onClicked:
               {

                   //save macro, add macronode, closepopup
                   var component;
                   var sprite;

                   component = Qt.createComponent("../MacroNode.qml");
                   console.log("created macro node")
                   if( component.status !== Component.Ready )
                   {
                       if( component.status === Component.Error )
                           console.debug("Error:"+ component.errorString() );
                       return; // or maybe throw
                   }
                   sprite.loaded()




                   //Close popup
                   popup.close();

               }
           }
       }
   }
   }

}


