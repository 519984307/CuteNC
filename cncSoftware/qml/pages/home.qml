import QtQuick 2.0
import QtQuick.Controls 2.15

import"../../qml/JogWidget"
import"../../qml/SerialConsoleWidget"
import"../../qml/ConnectionWidget"

Item {
    id: homePage
    width: 800
    height: 600

    Rectangle{
        id:background
        color: "#ffffff"
        anchors.fill:parent

        JogWidget{ id: jogWidget; width: 419; height: 300; anchors.left: connectionWidget.right; anchors.top: parent.top; anchors.leftMargin: 5; anchors.topMargin: 5 }
        SerialConsole{ id:serialConsole ;anchors.left: background.left; anchors.right: background.right; anchors.top: jogWidget.bottom; anchors.bottom: background.bottom; anchors.topMargin: 0; anchors.bottomMargin: 0; anchors.rightMargin: 0; anchors.leftMargin: 0}
        ConnectionWidget{ id:connectionWidget ; anchors.left: background.left; anchors.top: background.top; anchors.leftMargin: 5;anchors.topMargin: 5}
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9;height:718;width:1108}
}
##^##*/
