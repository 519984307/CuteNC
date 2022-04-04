import QtQuick.Window 2.12
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import Qt.labs.folderlistmodel 2.1
import "../components"

Rectangle{
    id:gCodeMacrosRoot
    width: 600
    height: 600

    Rectangle{
        id: buttonsRect
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        CuteNCButton{
            id:openPopupMacrosWindow
            width: 100
            height: 50
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.leftMargin: 0
            thisText: qsTr("Add new macro")
            onClicked: {
                var component = Qt.createComponent("GCodeMacrosPopupWindow.qml")
                var window    = component.createObject(gCodeMacrosRoot)
                window.show()
            }
        }
    }

    function reloadMacros(){


        for(var i = header_focused_container.children.length; i > 0 ; i--) {
             header_focused_container.children[i-1].destroy()
        }

        var macros = backend.getMacros();
        for(var j = 0; j < macros.length;j++){
            var JsonString = backend.getJsonFile(macros[j]);
            var JsonObject = JSON.parse(JsonString);


            console.log(JsonObject.macro);

            var component;
            var sprite;

            component = Qt.createComponent("GCodeMacroNode.qml");
            if( component.status !== Component.Ready )
            {
                if( component.status === Component.Error )
                    console.debug("Error:"+ component.errorString() );
                return; // or maybe throw
            }
            sprite = component.createObject(header_focused_container);
            sprite.macroName = JsonObject.macro
            sprite.macroIcon = JsonObject.icon
            sprite.macroLines = JsonObject.lines
            sprite.macroShortcut = JsonObject.shortcut
            sprite.macroFileName = macros[j];

        }


    }

    Connections{
        target:json
        function onSignal_ReloadMacros(){
            gCodeMacrosRoot.reloadMacros();
        }
    }

    Rectangle{
        id: definedMacrosRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: buttonsRect.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Component.onCompleted: {
            gCodeMacrosRoot.reloadMacros();
        }

        Flow {
               id: header_focused_container
               anchors.fill: parent
               anchors.rightMargin: 15
               anchors.leftMargin: 15
               anchors.bottomMargin: 15
               anchors.topMargin: 15
               spacing: 15

           }
    }
}


