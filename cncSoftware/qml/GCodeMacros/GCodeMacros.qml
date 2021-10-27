import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import "../components"

Rectangle{
    id:gCodeMacrosRoot

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

        Button {
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

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:9}D{i:8}
}
##^##*/
