import QtQuick 2.0
import QtQuick.Controls 2.15


Item {
    id: root

    property var sourceWidgetString: "EditorWidgetEmpty.qml"
    property string colorKey
    property var widgetIndex

    width: 64; height: 64
    x:100
    y:100
    z:1
    function moveToCursor(){
        console.log("moving to cursor")
        tile.x = mouseArea.mouseX*2;
        tile.y = mouseArea.mouseY*2;
    }



    MouseArea {
        id: mouseArea

        width: parent.width; height: parent.height
        anchors.centerIn: parent

        drag.target: tile

        onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : root
        cursorShape: drag.active ? Qt.ClosedHandCursor : Qt.OpenHandCursor
        onClicked: {
            if (mouse.button === Qt.RightButton){

            }

        }



        Rectangle {

            id: tile

            width: root.width
            height: root.height
            anchors.left: parent.left; anchors.top: parent.top;
            x: parent.x*2
            y: parent.y*2

            color: "red"
            z:10
            Drag.keys: [ colorKey ]
            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: 0
            Drag.hotSpot.y: 0


            Loader{
                id: stackView
                anchors.fill: parent
                source: Qt.resolvedUrl(sourceWidgetString)
                clip: true
                //enable to be able to click on elements inside
                enabled: false
                asynchronous: true;
                onVisibleChanged:      { loadIfNotLoaded(); }
                Component.onCompleted: { loadIfNotLoaded(); }
                onStatusChanged: {
                    if (status == Loader.Ready) {
                        //loaded()

                    }
                }

                function loadIfNotLoaded () {
                    // to load the file at first show
                    if (visible && !active) {
                        active = true;
                    }
                }
            }

            states: State {
                when: mouseArea.drag.active
                ParentChange { target: tile; parent: root }
                AnchorChanges { target: tile; anchors.left: undefined; anchors.top: undefined; }
                StateChangeScript {
                    name: "moveToCursor"
                    script: root.moveToCursor();
                }
                PropertyChanges {
                    target: editorPage
                    selected: root
                }
            }


        }



    }
}

/*##^##
Designer {
    D{i:0;height:200;width:200}D{i:2}D{i:1}
}
##^##*/
