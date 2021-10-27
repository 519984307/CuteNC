import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12


Rectangle {
    id: gCodeTextEditorRoot
    Rectangle {
        id: lineColumn
        property int rowHeight: textarea.font.pixelSize + 3
        color: "#f2f2f2"
        width: 50
        height: parent.height
        Rectangle {
            height: parent.height
            anchors.right: parent.right
            width: 1
            color: "#ddd"
        }
        Column {

            width: parent.width
            Repeater {
                model: Math.max(textarea.lineCount + 2, (lineColumn.height/lineColumn.rowHeight) )
                delegate: Text {
                    id: textk
                    color: "#666"
                    font: textarea.font
                    width: lineColumn.width
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    height: lineColumn.rowHeight
                    renderType: Text.NativeRendering
                    text: index
                }
            }
        }
    }
    TextArea {
        id: textarea
        textFormat: TextEdit.RichText
        anchors.left: lineColumn.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        wrapMode: TextEdit.NoWrap
        font.family: "RobotoMono"
        text:"GCode"
    }
}
