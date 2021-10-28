import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import StephenQuan 1.0


Item {
    id: gCodeTextEditorRoot
    clip:true

    Rectangle{
        id:colRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        color: "#ddd"
        anchors.left: parent.left
        width: lineColumn.width
    }

    ScrollView{
        id: frame
        clip:true
        anchors.fill: parent
        //other properties
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOn

        Flickable{
            contentHeight: Math.max(textEdit.contentHeight,textEdit.lineCount)
            contentWidth: Math.max(textEdit.contentWidth,500)
            height: parent.height
            width: parent.width

            Rectangle {
                id: lineColumn
                property int rowHeight: textEdit.font.pixelSize + 3
                width: 50
                color: "#e6e6e6"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                Rectangle {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    color: "#ddd"
                    anchors.left: parent.left
                }
                Column {
                    width: parent.width
                    Repeater {
                        model: Math.max(textEdit.lineCount, (lineColumn.height/lineColumn.rowHeight) )
                        delegate:  Label {
                            color: "#666"
                            font: textEdit.font
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            renderType: Text.NativeRendering
                            text: index+1
                        }
                    }
                }

            }


            TextEdit {
                leftPadding: 6
                rightPadding: 6
                id: textEdit
                x: -hbar.position * width
                y: -vbar.position * height
                font.pointSize: 12
                textFormat: TextEdit.RichText
                anchors.left: lineColumn.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                wrapMode: TextEdit.NoWrap
                anchors.leftMargin: 0
                font.family: "Consolas"
                Layout.fillWidth: true
                selectByMouse: true


            }
        }
    }
    SyntaxHighlighter {
        id: syntaxHighlighter
        textDocument: textEdit.textDocument
        onHighlightBlock: {
            let rx = /;.*|[A-Za-z.]+(\s*:)?|\d+(.\d*)?|'[^']*?'|"[^"]*?"/g
            let rx2 = /;.*|g.*|G.*|m.*|M.*"/g
            let rx3 = /;.*|^[Gg]0?[01]|([XxYyZz]) *(-?\d+\.?\d*)|^[Mm]?\d+|([Gg]0?[01]) *(([XxYyZz]) *(-?\d+.?\d*)) *(([XxYyZz]) *(-?\d+.?\d*))? *(([XxYyZz]) *(-?\d+.?\d*))?/g
            let m
            while ( ( m = rx3.exec(text) ) !== null ) {
                //Comment
                if (m[0].match(/^\;.*/)) {
                    setFormat(m.index, m[0].length, commentFormat);
                    continue;
                }
                //G00 G01
                if (m[0].match(/^[Gg]0?[01]/)) {
                    setFormat(m.index, m[0].length, gcodeFormat);
                    continue;
                }

                //XYZ 0-9
                if (m[0].match(/([XxYyZz]) *(-?\d+\.?\d*)/)) {
                    setFormat(m.index, m[0].length, axesFormat);
                    continue;
                }
                //Mxxx
                if (m[0].match(/^[Mm]?\d+/)) {
                    setFormat(m.index, m[0].length, mcodeFormat);
                    continue;
                }
            }
        }

    }

    TextCharFormat { id: keywordFormat; foreground: "#808000" }
    TextCharFormat { id: componentFormat; foreground: "#aa00aa"}
    TextCharFormat { id: numberFormat; foreground: "#0055af" }
    TextCharFormat { id: propertyFormat; foreground: "#800000" }
    TextCharFormat { id: stringFormat; foreground: "green" }


    TextCharFormat { id: axesFormat; foreground: "#D35152"}
    TextCharFormat { id: commentFormat; foreground: "#65B762" }
    TextCharFormat { id: gcodeFormat; foreground: "#2E6DA4" }
    TextCharFormat { id: mcodeFormat; foreground: "#ECAB57" }


}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
