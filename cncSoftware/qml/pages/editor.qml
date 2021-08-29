import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
Item {
    id: editorPage
    width: 800
    height: 600

    property var selected: null
    QtObject{
        id:internal
    }

    Rectangle{
        id:background
        color: "#ffffff"
        anchors.fill:parent


        //EDITOR MENU

        Rectangle{
            id: editorMenu
            width: 250
            color: "#e9f3e9"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            z: 1
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0


            ScrollView{
                id: editorMenuScrollView
                anchors.fill: parent
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                //Add new element (widget)
                Button {
                    id: button
                    text: qsTr("Add")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.leftMargin: 20
                    onClicked:
                    {
                        var component;
                        var sprite;

                        component = Qt.createComponent("../EditorWidgetTemplate.qml");
                        if( component.status !== Component.Ready )
                        {
                            if( component.status === Component.Error )
                                console.debug("Error:"+ component.errorString() );
                            return; // or maybe throw
                        }
                        sprite = component.createObject(grid, {"x": 100, "y": 100});
                    }
                }

                Label{
                    id:selectedName
                    text: selected.name
                    anchors.left: parent.left
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                    anchors.topMargin: 100
                }


                //            Rectangle{
                //                id: selectedEditColors
                //                width: 100
                //                height: 100
                //                anchors.left: parent.left
                //                anchors.right: parent.right
                //                anchors.top: selectedName.bottom
                //                z: 0
                //                anchors.rightMargin: 0
                //                anchors.leftMargin: 0
                //                anchors.topMargin: 10

                //                ColorDialog {
                //                    id: colorDialog
                //                    title: "Please choose a color"
                //                    onAccepted: {
                //                        console.log("You chose: " + colorDialog.color)
                //                        Qt.quit()
                //                    }
                //                    onRejected: {
                //                        console.log("Canceled")
                //                        Qt.quit()
                //                    }
                //                    Component.onCompleted: visible = true
                //                }
                //            }
            }



        }


        // END OF EDITOR MENU

        Rectangle{
            id: grid
            color: "#fdfdfd"
            anchors.left: editorMenu.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            z: 1
            anchors.leftMargin: 0
            property int howMany: 10
            property int spacing: 10

            Row{
                spacing: grid.spacing
                Repeater{
                    id:repeaterVer
                    model:  Math.floor(grid.width/grid.howMany)
                    delegate: Column{
                        spacing: grid.spacing
                        Repeater{
                            id:repeaterHor
                            model:  Math.floor(grid.height/grid.howMany)
                            Rectangle{
                                height: 2
                                width: 2
                                color:"#222222"
                            }
                        }
                    }
                }
            }
        }
    }


}




/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
