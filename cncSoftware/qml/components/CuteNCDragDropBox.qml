import QtQuick 2.0

Item {
    id:root
    Rectangle{
        id:rect
        anchors.fill: parent
        color:"grey"

        DropArea {
            id: dragTarget
            property alias dropProxy: dragTarget
            anchors.fill: parent


            keys: [ colorKey ]

            Rectangle {
                id: dropRectangle
                anchors.fill: parent
                color: bgColor

                states: [
                    State {
                        when: dragTarget.containsDrag
                        PropertyChanges {
                            target: dropRectangle
                            color: "grey"
                        }
                    }
                ]
            }
        }

    }
}
