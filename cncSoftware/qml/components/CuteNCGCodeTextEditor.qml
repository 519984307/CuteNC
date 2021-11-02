import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import StephenQuan 1.0


Item {
    id: gCodeTextEditorRoot
    clip:true


    property color backgroundColor
    property color lineNumberBackgroundColor
    property color lineNumberColor
    property color currentRowColor

    property int fontPointSize
    property font fontFamily

    property color mCodes
    property color gCodes
    property color axes
    property color comments
    property color special
    property color nLine




    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJSONFile("../json/themes/",backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        gCodeTextEditorRoot.backgroundColor = JsonObjectTheme.gcodeEditor.backgroundColor
        gCodeTextEditorRoot.lineNumberBackgroundColor = JsonObjectTheme.gcodeEditor.lineNumberBackgroundColor
        gCodeTextEditorRoot.lineNumberColor = JsonObjectTheme.gcodeEditor.lineNumberColor
        gCodeTextEditorRoot.fontPointSize = JsonObjectTheme.gcodeEditor.fontPointSize
        gCodeTextEditorRoot.fontFamily = JsonObjectTheme.gcodeEditor.fontFamily
        gCodeTextEditorRoot.mCodes = JsonObjectTheme.gcodeEditor.mCodes
        gCodeTextEditorRoot.gCodes = JsonObjectTheme.gcodeEditor.gCodes
        gCodeTextEditorRoot.axes = JsonObjectTheme.gcodeEditor.axes
        gCodeTextEditorRoot.comments = JsonObjectTheme.gcodeEditor.comments
        gCodeTextEditorRoot.currentRowColor = JsonObjectTheme.gcodeEditor.currentRowColor
        gCodeTextEditorRoot.special = JsonObjectTheme.gcodeEditor.special
        gCodeTextEditorRoot.nLine = JsonObjectTheme.gcodeEditor.nLine


    }

    Component.onCompleted: {
        jsonSettings()
    }

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }

    Rectangle {
        id: rectangle
        color: gCodeTextEditorRoot.backgroundColor
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
            color: gCodeTextEditorRoot.lineNumberBackgroundColor

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
                    id:sb
                    position: fsb.position
                }

                Column {
                    width: parent.width
                    Repeater {
                        model: Math.max(textEdit.lineCount)
                        delegate:  Label {
                            color: gCodeTextEditorRoot.lineNumberColor
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

            Flickable{
                id: flickable
                property var dynamicWidth:{ if(textEdit.implicitWidth >= textEdit.width-60){
                        fsb2.position = 1.0
                        flickable.contentWidth  += 60+ textEdit.font.pixelSize + 3
                        textEdit.width += 60
                    }
                }


                anchors.left: parent.left
                anchors.right: gCodeTextEditorRoot.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: fsb.width

                contentHeight: Math.max(textEdit.contentHeight, textEdit.lineCount)
                contentWidth: Math.max(380)

                ScrollBar.vertical: ScrollBar{
                    Rectangle{
                        anchors.fill:parent
                        color:backgroundColor
                        clip:true
                    }

                    id:fsb
                    pressed: false
                    size: 1.1
                    policy: "AlwaysOn"

                }
                ScrollBar.horizontal: ScrollBar{
                    Rectangle{
                        anchors.fill:parent
                        color:backgroundColor
                        clip:true
                    }
                    id:fsb2
                    policy: "AlwaysOn"
                }

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
                    color: gCodeTextEditorRoot.currentRowColor
                    height: textEdit.cursorRectangle.height
                    width: textEdit.width
                    visible: textEdit.activeFocus
                    y: textEdit.cursorRectangle.y
                }

                TextEdit {
                    id: textEdit
                    leftPadding: 6
                    rightPadding: 6
                    font.pointSize: gCodeTextEditorRoot.fontPointSize
                    textFormat: TextEdit.RichText
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    wrapMode: TextEdit.NoWrap
                    font.family: gCodeTextEditorRoot.fontFamily
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
            let rx = /\(.*\)|\;.*|[Gg]\d+|([XxYyZzAaBbCcEe]) *(-?\d+\.?\d*)|[Mm]\d+|^[Oo]\d+|^[Nn]\d+/g
            let m
            while ( ( m = rx.exec(text) ) !== null ) {
                //Comment (cokolwiek)   (.+)
                if (m[0].match(/\(.*\)/)) {
                    setFormat(m.index, m[0].length, commentFormat);
                    continue;
                }
                //Comment ;
                if (m[0].match(/\;.*/)) {
                    setFormat(m.index, m[0].length, commentFormat);
                    continue;
                }
                //G00 G01
                if (m[0].match(/[Gg]\d+/)) {
                    setFormat(m.index, m[0].length, gcodeFormat);
                    continue;
                }
                //XYZ 0-9
                if (m[0].match(/([XxYyZzAaBbCcEe]) *(-?\d+\.?\d*)/)) {
                    setFormat(m.index, m[0].length, axesFormat);
                    continue;
                }
                //Mxxx
                if (m[0].match(/[Mm]\d+/)) {
                    setFormat(m.index, m[0].length, mcodeFormat);
                    continue;
                }
                //Oo program number ^[Oo]\d{8}
                if (m[0].match(/^[Oo]\d+/)) {
                    setFormat(m.index, m[0].length, special);
                    continue;
                }
                //Nn number ^[Nn]\d+
                if (m[0].match(/^[Nn]\d+/)) {
                    setFormat(m.index, m[0].length, nLine);
                    continue;
                }
                //T & D tool diameter ^[Tt]\d+   i   [Dd]\d+
            }
        }

    }

    TextCharFormat { id: axesFormat; foreground: gCodeTextEditorRoot.axes}
    TextCharFormat { id: commentFormat; foreground: gCodeTextEditorRoot.comments }
    TextCharFormat { id: gcodeFormat; foreground: gCodeTextEditorRoot.gCodes }
    TextCharFormat { id: mcodeFormat; foreground: gCodeTextEditorRoot.mCodes }
    TextCharFormat { id: nLine; foreground: gCodeTextEditorRoot.nLine }
    TextCharFormat { id: special; foreground: gCodeTextEditorRoot.special }


}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
