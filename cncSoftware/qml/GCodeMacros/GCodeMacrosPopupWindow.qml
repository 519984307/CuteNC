import QtQuick.Window 2.12
import QtQuick 2.0
import QtQuick.Controls 2.12
import "../components"
import CleanEditor 1.0
import StephenQuan 1.0
Window{
    id:gCodeMacrosPopupWindowRoot
    width: 800
    height: 600

    title:"CuteNC - Macro"
    property string macroName
    property string macroShortcut
    property string macroIcon
    property string macroLines
    property string macroFileName
    property string fileContent


    property color textColor
    property color currentTextColor
    property color backgroundColor
    property color selectedBackgroundColor
    property color selectedRowNumberColor
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

    property string contentText
    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        gCodeMacrosPopupWindowRoot.textColor = JsonObjectTheme.gcodeEditor.textColor
        gCodeMacrosPopupWindowRoot.backgroundColor = JsonObjectTheme.gcodeEditor.backgroundColor
        gCodeMacrosPopupWindowRoot.selectedBackgroundColor = JsonObjectTheme.gcodeEditor.selectedBackgroundColor
        gCodeMacrosPopupWindowRoot.currentTextColor = JsonObjectTheme.gcodeEditor.currentTextColor
        gCodeMacrosPopupWindowRoot.selectedRowNumberColor = JsonObjectTheme.gcodeEditor.selectedRowNumberColor

        gCodeMacrosPopupWindowRoot.lineNumberBackgroundColor = JsonObjectTheme.gcodeEditor.lineNumberBackgroundColor
        gCodeMacrosPopupWindowRoot.lineNumberColor = JsonObjectTheme.gcodeEditor.lineNumberColor
        gCodeMacrosPopupWindowRoot.fontPointSize = JsonObjectTheme.gcodeEditor.fontPointSize
        gCodeMacrosPopupWindowRoot.fontFamily = JsonObjectTheme.gcodeEditor.fontFamily
        gCodeMacrosPopupWindowRoot.mCodes = JsonObjectTheme.gcodeEditor.mCodes
        gCodeMacrosPopupWindowRoot.gCodes = JsonObjectTheme.gcodeEditor.gCodes
        gCodeMacrosPopupWindowRoot.axes = JsonObjectTheme.gcodeEditor.axes
        gCodeMacrosPopupWindowRoot.comments = JsonObjectTheme.gcodeEditor.comments
        gCodeMacrosPopupWindowRoot.currentRowColor = JsonObjectTheme.gcodeEditor.currentRowColor
        gCodeMacrosPopupWindowRoot.special = JsonObjectTheme.gcodeEditor.special
        gCodeMacrosPopupWindowRoot.nLine = JsonObjectTheme.gcodeEditor.nLine
    }
    Component.onCompleted: {
        jsonSettings();
    }

    function setValues(){
        textArea.append(macroLines);
        textInput_MacroName.setText(macroName);
    }

    Rectangle{
        id: rectangle
        anchors.fill: parent



        SyntaxHighlighter {
            id: syntaxHighlighter
            textDocument: textArea.textDocument
            onHighlightBlock: {
                let rx = /\(.*\)|\;.*|[Gg]\d+|([XxYyZzAaBbCcEeIiJj]) *(-?\d+\.?\d*)|[Mm]\d+|^[Oo]\d+|^[Nn]\d+/g
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
                    //XYZIJ 0-9
                    if (m[0].match(/([XxYyZzAaBbCcEeIiJj]) *(-?\d+\.?\d*)/)) {
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

        TextCharFormat { id: axesFormat; foreground: gCodeMacrosPopupWindowRoot.axes}
        Rectangle {
            id: rectangle1
            width: 200
            height: 200
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topRect.bottom
            anchors.bottom: buttonsBar.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: lineNumberPanel
                x: 0
                y: 80
                width: 50
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                }

                color: gCodeMacrosPopupWindowRoot.lineNumberColor
                anchors.topMargin: 0

                LineNumbers {
                    id: lineNumbersItem
                    anchors.fill: parent
                    anchors.topMargin: textArea.topa


                    selectedBackgroundColor: gCodeMacrosPopupWindowRoot.currentRowColor
                    currentBackgroundColor: gCodeMacrosPopupWindowRoot.backgroundColor
                    selectedTextColor: gCodeMacrosPopupWindowRoot.selectedRowNumberColor
                    currentTextColor: gCodeMacrosPopupWindowRoot.currentTextColor
                    textColor: gCodeMacrosPopupWindowRoot.textColor

                    fontPointSize: gCodeMacrosPopupWindowRoot.fontPointSize

                    font: gCodeMacrosPopupWindowRoot.fontFamily

                    highlightedRow: 5

                    document: textArea.textDocument
                    cursorPosition: textArea.cursorPosition
                    selectionStart: textArea.selectionStart
                    selectionEnd: textArea.selectionEnd
                    offsetY: textEditor.contentY

                }
            }

            Flickable {
                id: textEditor
                x: 54
                y: 80
                anchors.topMargin: 0
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                    left: lineNumberPanel.right
                    leftMargin: 4
                }
                clip: true
                contentWidth: textArea.width
                contentHeight: textArea.height+20
                onContentYChanged: lineNumbersItem.update()
                boundsBehavior: Flickable.StopAtBounds

                TextArea.flickable: TextArea {
                    id: textArea
                    textFormat: Qt.PlainText
                    background: null
                    font: gCodeMacrosPopupWindowRoot.fontFamily
                    selectByMouse: true
                    padding: 0
                    onLinkActivated: Qt.openUrlExternally(link)
                    selectionColor: gCodeMacrosPopupWindowRoot.selectedBackgroundColor
                    Component.onCompleted: {
                        textArea.font.pointSize = lineNumbersItem.fontPointSize
                        //editorModel.document = textArea.textDocument
                    }
                }

                ScrollBar.vertical: ScrollBar {}
                ScrollBar.horizontal: ScrollBar {}
            }
        }

        TextCharFormat { id: commentFormat; foreground: gCodeMacrosPopupWindowRoot.comments }
        TextCharFormat { id: gcodeFormat; foreground: gCodeMacrosPopupWindowRoot.gCodes }
        TextCharFormat { id: mcodeFormat; foreground: gCodeMacrosPopupWindowRoot.mCodes }
        TextCharFormat { id: nLine; foreground: gCodeMacrosPopupWindowRoot.nLine }
        TextCharFormat { id: special; foreground: gCodeMacrosPopupWindowRoot.special }



        Rectangle {
            id: topRect
            height: 55
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            CuteNCTextInput{
                id:textInput_MacroName
                width: 200
                height: 35
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 10
                anchors.topMargin: 10
                Component.onCompleted: {
                    textInput_MacroName.setPlaceholder("Macro name");
                }
            }

        }

        Rectangle{
            id:buttonsBar
            height: 50
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            CuteNCButton {
                id: btnSave
                x: 532
                y: 5
                width: 100
                height: 40
                thisText: qsTr("Save")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 8
                onClicked:
                {
                    var text = textArea.text;
                    var matches = [];

                    matches = text.match(/.+?(?=\n|$)|\n.*/mg);
                    var matchesFormatted = [];

                    if(matches == null){
                        backend.showNotification("warn","Insert g-code commands before saving");
                    }

                    var newMacroName = textInput_MacroName.getText();

                    if(newMacroName.length < 3){
                        backend.showNotification("warn","Macro name should have atleast 3 characters");
                    }else{
                        matches.forEach(function(doc){
                            console.log(doc);
                            matchesFormatted.push(doc.trim("\n"));
                        });

                        backend.createMacro(textInput_MacroName.getText(),matchesFormatted)


                        gCodeMacrosPopupWindowRoot.destroy();
                        gCodeMacrosPopupWindowRoot.close();
                    }
                }
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:2}D{i:3}D{i:6}D{i:5}D{i:7}D{i:4}D{i:11}D{i:12}D{i:13}
D{i:14}D{i:15}D{i:17}D{i:16}D{i:19}D{i:18}D{i:1}
}
##^##*/
