import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import StephenQuan 1.0
import CleanEditor 1.0

Item {
    id: gCodeTextEditorRoot
    clip:true

    property int neededMinimiumWidth: textEditor.width+50;

    property color textColor
    property color currentTextColor
    property color backgroundColor
    property color selectedBackgroundColor
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

    function getText(){
        return textArea.text;
    }



    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        gCodeTextEditorRoot.textColor = JsonObjectTheme.gcodeEditor.textColor
        gCodeTextEditorRoot.backgroundColor = JsonObjectTheme.gcodeEditor.backgroundColor
        gCodeTextEditorRoot.selectedBackgroundColor = JsonObjectTheme.gcodeEditor.selectedBackgroundColor
        gCodeTextEditorRoot.currentTextColor = JsonObjectTheme.gcodeEditor.currentTextColor

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
        id: lineNumberPanel
        width: 50
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }

        color: gCodeTextEditorRoot.lineNumberColor

        LineNumbers {
            id: lineNumbersItem
            anchors.fill: parent
            anchors.topMargin: textArea.topa


            selectedBackgroundColor: gCodeTextEditorRoot.currentRowColor
            currentBackgroundColor: gCodeTextEditorRoot.backgroundColor
            selectedTextColor: gCodeTextEditorRoot.selectedBackgroundColor
            currentTextColor: gCodeTextEditorRoot.currentTextColor
            textColor: gCodeTextEditorRoot.textColor

            fontPointSize: gCodeTextEditorRoot.fontPointSize

            font: gCodeTextEditorRoot.fontFamily

            document: textArea.textDocument
            cursorPosition: textArea.cursorPosition
            selectionStart: textArea.selectionStart
            selectionEnd: textArea.selectionEnd
            offsetY: textEditor.contentY
        }
    }

    Flickable {
        id: textEditor
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: lineNumberPanel.right
            leftMargin: 4
        }
        clip: true
        contentWidth: textArea.width
        contentHeight: textArea.height
        onContentYChanged: lineNumbersItem.update()
        boundsBehavior: Flickable.StopAtBounds

        TextArea.flickable: TextArea {
            id: textArea
            textFormat: Qt.PlainText
            background: null
            font: gCodeTextEditorRoot.fontFamily
            selectByMouse: true
            padding: 0
            onLinkActivated: Qt.openUrlExternally(link)
            selectionColor: gCodeTextEditorRoot.selectedBackgroundColor

            Component.onCompleted: {

                textArea.font.pointSize = lineNumbersItem.fontPointSize
                //editorModel.document = textArea.textDocument
            }
        }

        ScrollBar.vertical: ScrollBar {}
        ScrollBar.horizontal: ScrollBar {}
    }



    SyntaxHighlighter {
        id: syntaxHighlighter
        textDocument: textArea.textDocument
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
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:1}D{i:3}D{i:2}D{i:4}
D{i:8}D{i:9}D{i:10}D{i:11}D{i:12}D{i:13}D{i:14}
}
##^##*/
