import QtQuick 2.0

import "../components"
import QtQuick.Controls 2.15

Rectangle {
    id: nodeRoot
    width: 100
    height: 100
    radius: 10
    border.width: 0
    color: "#FFFFFF"

    Label {
        id: label
        text: qsTr("Label")
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    Label {
        id: label1
        text: qsTr("Label")
        anchors.left: parent.left
        anchors.top: label.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 5
    }


}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}D{i:2}
}
##^##*/
