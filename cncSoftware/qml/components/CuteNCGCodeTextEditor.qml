import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import StephenQuan 1.0


Item {
    id: gCodeTextEditorRoot
    clip:true

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent


            Rectangle {
                id: lineColumn
                property int rowHeight: textEdit.font.pixelSize + 3
                width: 50
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                color: "#e6e6e6"

                ScrollView{
                    id:scrollView
                    width: 50
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    enabled: false
                    ScrollBar.vertical: ScrollBar{
                        id:scrollViewsb
                        anchors.fill: parent
                        visible:false
                        policy: ScrollBar.AlwaysOff

                    }
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                Column {
                    width: parent.width

                    Repeater {
                        model: Math.max(textEdit.lineCount)
                        delegate:  Label {
                            color: "#222222"
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
        }



        ScrollView{
            id: frame
            anchors.left: lineColumn.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            clip:true
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            //other properties

            ScrollBar.vertical: ScrollBar{
                id:framesb
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.topMargin: 0
                anchors.rightMargin: 0
                policy: ScrollBar.AlwaysOff

                onPositionChanged: {
                     scrollViewsb.setPosition(framesb.position)
                }
            }
            ScrollBar.horizontal: ScrollBar{
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 10
                anchors.bottomMargin: 0
                policy: ScrollBar.AlwaysOff
            }

            Flickable{
                id: flickable
                anchors.fill: parent
                contentHeight: Math.max(textEdit.contentHeight, textEdit.lineCount)
                contentWidth: Math.max(textEdit.contentWidth, 500)

                function ensureVisible(r)
                {
                    if (contentX >= r.x)
                        contentX = r.x;
                    else if (contentX+width <= r.x+r.width)
                        contentX = r.x+r.width-width;
                    if (contentY >= r.y)
                        contentY = r.y;
                    else if (contentY+height <= r.y+r.height)
                        contentY = r.y+r.height-height;
                }

                Rectangle {
                     id: rowHighlight
                     color: "#E6E6E6"
                     height: textEdit.cursorRectangle.height
                     width: parent.width
                     visible: textEdit.activeFocus
                     y: textEdit.cursorRectangle.y
                 }

                TextEdit {
                    id: textEdit
                    leftPadding: 6
                    rightPadding: 6
                    font.pointSize: 12
                    textFormat: TextEdit.RichText
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    wrapMode: TextEdit.NoWrap
                    anchors.leftMargin: 0
                    font.family: "Consolas"
                    selectByMouse: true
                    onCursorRectangleChanged: flickable.ensureVisible(cursorRectangle)


                }
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
                //Comment (cokolwiek)   (.+)

                //Comment ;
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
                if (m[0].match(/^[Mm]\d+/)) {
                    setFormat(m.index, m[0].length, mcodeFormat);
                    continue;
                }

                //Oo program number ^[Oo]\d{8}
                //Nn number ^[Nn]\d+
                //T & D tool diameter ^[Tt]\d+   i   [Dd]\d+
            }
        }

    }

    TextCharFormat { id: axesFormat; foreground: "#D35152"}
    TextCharFormat { id: commentFormat; foreground: "#65B762" }
    TextCharFormat { id: gcodeFormat; foreground: "#2E6DA4" }
    TextCharFormat { id: mcodeFormat; foreground: "#ECAB57" }


}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:1}
}
##^##*/
