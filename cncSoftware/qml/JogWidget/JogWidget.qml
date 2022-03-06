import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

Rectangle {
    id: jogWidget
    color: backgroundColor

    property color backgroundColor

    Component.onCompleted: {
        var JsonString = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObject = JSON.parse(JsonString);

        jogWidget.backgroundColor = JsonObject.jogWidget.backgroundColor;

    }

    Rectangle{
        id: jogBtns
        anchors.fill:parent;
        color: "white"
        Label{
            text:"Test"
            anchors.centerIn: parent
        }

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:300;width:320}
}
##^##*/
