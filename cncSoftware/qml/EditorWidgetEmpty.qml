import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle{
    id: mainRect
    color: "#6cc1e8"
    anchors.fill: parent

    Text{
        anchors.fill:parent
        text: root.widgetIndex
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3;height:50;width:100}
}
##^##*/
