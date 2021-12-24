import QtQuick 2.0
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import CleanEditor 1.0
import StephenQuan 1.0
import "../components"
Item {
    id:consoleWidgetRoot
    property color defaultTextColor
    property color currentTextColor
    property color backgroundColor
    property color selectedBackgroundColor
    property color lineNumberBackgroundColor
    property color lineNumberColor
    property color currentRowColor

    property int fontPointSize
    property font fontFamily

    property color warnColor
    property color infoColor
    property color logColor
    property color errorColor

    property color greyedOutText
    property color greenedOutText
    property color rededOutText

    property string prefix
    property string suffix

    //Text input
    property string placeholder: "Type here..."
    property color placeholderColor:"#404040"

    property bool borderVisible: true
    property int borderWidth: 1
    property int borderRadius

    property int inputFontPointSize
    property font inputFontFamily


    property int radius: 15
    property int inputMargins
    //Theme
    property string inputBackgroundColor: "#E6E6E6"
    //Component theme
    property string colorDefault: "#E6E6E6"
    property color colorMouseOver: "#E6E6E6"
    property color colorPressed: "#E6E6E6"
    property color textColor: "#222222"

    property color textColorLight: "#FFFFFF"
    property color textColorDark: "#222222"



    property color onPressedColor:"#E6E6E6"
    property color onPressedBorderColor:"#C32C30"
    property color onHoverBorderColor:"#404040"
    property color borderColor:"#404040"


    function getText(){
        return textArea.text;
    }

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        consoleWidgetRoot.defaultTextColor = JsonObjectTheme.consoleWidget.defaultTextColor
        consoleWidgetRoot.backgroundColor = JsonObjectTheme.consoleWidget.backgroundColor
        consoleWidgetRoot.selectedBackgroundColor = JsonObjectTheme.consoleWidget.selectedBackgroundColor
        consoleWidgetRoot.currentTextColor = JsonObjectTheme.consoleWidget.currentTextColor
        consoleWidgetRoot.currentRowColor = JsonObjectTheme.consoleWidget.currentRowColor


        consoleWidgetRoot.lineNumberBackgroundColor = JsonObjectTheme.consoleWidget.lineNumberBackgroundColor
        consoleWidgetRoot.lineNumberColor = JsonObjectTheme.consoleWidget.lineNumberColor
        consoleWidgetRoot.fontPointSize = JsonObjectTheme.consoleWidget.fontPointSize
        consoleWidgetRoot.fontFamily = JsonObjectTheme.consoleWidget.fontFamily

        consoleWidgetRoot.warnColor = JsonObjectTheme.consoleWidget.warnColor
        consoleWidgetRoot.infoColor = JsonObjectTheme.consoleWidget.infoColor
        consoleWidgetRoot.logColor = JsonObjectTheme.consoleWidget.logColor
        consoleWidgetRoot.errorColor = JsonObjectTheme.consoleWidget.errorColor
        consoleWidgetRoot.greyedOutText = JsonObjectTheme.consoleWidget.greyedOutText
        consoleWidgetRoot.greenedOutText = JsonObjectTheme.consoleWidget.greenedOutText
        consoleWidgetRoot.rededOutText = JsonObjectTheme.consoleWidget.rededOutText

        consoleWidgetRoot.prefix = JsonObjectTheme.consoleWidget.prefix
        consoleWidgetRoot.suffix = JsonObjectTheme.consoleWidget.suffix


        //text inputCommand
        consoleWidgetRoot.placeholder = JsonObjectTheme.consoleWidget.textInput.placeholder;
        consoleWidgetRoot.placeholderColor = JsonObjectTheme.consoleWidget.textInput.placeholderColor;

        consoleWidgetRoot.colorMouseOver = JsonObjectTheme.consoleWidget.textInput.onHoverColor;
        consoleWidgetRoot.colorPressed = JsonObjectTheme.consoleWidget.textInput.onPressedColor
        consoleWidgetRoot.textColorLight = JsonObjectTheme.consoleWidget.textInput.textColorLight;
        consoleWidgetRoot.textColorDark = JsonObjectTheme.consoleWidget.textInput.textColorDark;

        consoleWidgetRoot.colorDefault = JsonObjectTheme.consoleWidget.textInput.defaultColor;
        consoleWidgetRoot.onPressedColor = JsonObjectTheme.consoleWidget.textInput.onPressedColor;
        consoleWidgetRoot.onPressedBorderColor = JsonObjectTheme.consoleWidget.textInput.onPressedBorderColor;
        consoleWidgetRoot.onHoverBorderColor = JsonObjectTheme.consoleWidget.textInput.onHoverBorderColor;
        consoleWidgetRoot.borderColor = JsonObjectTheme.consoleWidget.textInput.borderColor;
        consoleWidgetRoot.borderVisible = JsonObjectTheme.consoleWidget.textInput.borderVisible;
        consoleWidgetRoot.borderWidth = JsonObjectTheme.consoleWidget.textInput.borderWidth;
        consoleWidgetRoot.radius = JsonObjectTheme.consoleWidget.textInput.radius;
        consoleWidgetRoot.inputFontPointSize = JsonObjectTheme.consoleWidget.textInput.fontPointSize;
        consoleWidgetRoot.inputFontFamily = JsonObjectTheme.consoleWidget.textInput.fontFamily;
        consoleWidgetRoot.inputMargins = JsonObjectTheme.consoleWidget.textInput.margins;
    }

    property string newLineTextColor
    property string newLineAboutToAdd
    property string formattedMessage
    property int messageStartIndex
    property int messageLength

    function addNewLine(time, type, source, message, msgColor){

        newLineTextColor = formattedMessage = null;

        let spacing = "  ";
        let timeStr = prefix +time+ suffix
        let typeStr = prefix +type+ suffix
        let sourceStr = prefix +source+ suffix

        if(msgColor === "greenedOut"){
            consoleWidgetRoot.newLineTextColor = consoleWidgetRoot.greenedOutText

        }
        else if(msgColor === "greyedOut"){
            consoleWidgetRoot.newLineTextColor = consoleWidgetRoot.greyedOutText

        }
        else if(msgColor === "rededOut"){
            consoleWidgetRoot.newLineTextColor = consoleWidgetRoot.rededOutText

        }
        else{
            consoleWidgetRoot.newLineTextColor = consoleWidgetRoot.defaultTextColor
        }

        consoleWidgetRoot.messageStartIndex = timeStr.length + spacing.length*3 + typeStr.length + sourceStr.length
        consoleWidgetRoot.messageLength = message.length
        syntaxHighlighter.setFormat(message.index,message.length,warnFormat)
        consoleWidgetRoot.newLineAboutToAdd = timeStr + spacing + typeStr + spacing + sourceStr + spacing + message;

        textArea.append(newLineAboutToAdd);


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
        id: panel
        x: 0
        y: 470
        height: 30
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0

        CuteNCButton{
            id: sendCommand;
            x: 514;
            y: 1
            width: 85;
            thisText: qsTr("Send")
            anchors.right: parent.right
            anchors.top: parent.top;
            anchors.bottom: parent.bottom;
            anchors.rightMargin: 0
            z: 1;
            anchors.bottomMargin: 0;
            anchors.topMargin: 0;
            function activate() {
                if(inputBox.text != ""){
                    backend.commandReceived(inputBox.text)
                    inputBox.text = ""
                }
            }
            onClicked: sendCommand.activate();
        }

        Rectangle{
            id:bgRectangle
            color:consoleWidgetRoot.inputBackgroundColor
            radius:consoleWidgetRoot.radius
            anchors.fill:parent

            TextInput{
                id:inputBox
                anchors.fill:parent
                anchors.margins: consoleWidgetRoot.inputMargins
                anchors.leftMargin: 8
                font.pointSize: consoleWidgetRoot.inputFontPointSize
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                font.family: consoleWidgetRoot.inputFontFamily
                selectByMouse: true
                layer.enabled: true
                wrapMode: TextInput.NoWrap
                onTextChanged: consoleWidgetRoot.onTextChanged
                focus: true
                Label{
                    id:placeholderLbl
                    font.family: parent.font.family
                    font.pointSize: parent.font.pointSize
                    font.italic: false
                    text:placeholder
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    leftInset: 2
                    leftPadding: 2
                    color:placeholderColor
                }

                Keys.onPressed: {
                    if(inputBox.focus == true && event.key === Qt.Key_Return){
                        sendCommand.activate()
                    }
                }
            }
        }



    }

    Rectangle {
        id: lineNumberPanel
        width: 50
        anchors {
            top: parent.top
            bottom: panel.top
            left: parent.left
        }

        color: consoleWidgetRoot.lineNumberColor
        anchors.bottomMargin: 0

        LineNumbers {
            id: lineNumbersItem
            anchors.fill: parent
            anchors.topMargin: textArea.topa


            selectedBackgroundColor: consoleWidgetRoot.currentRowColor
            currentBackgroundColor: consoleWidgetRoot.backgroundColor
            selectedTextColor: consoleWidgetRoot.selectedBackgroundColor
            currentTextColor: consoleWidgetRoot.currentTextColor
            textColor: consoleWidgetRoot.defaultTextColor

            fontPointSize: consoleWidgetRoot.fontPointSize

            font: consoleWidgetRoot.fontFamily

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
        y: 0
        anchors.bottomMargin: 0
        anchors {
            top: parent.top
            bottom: panel.top
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
            font: consoleWidgetRoot.fontFamily
            selectByMouse: true
            padding: 0
            onLinkActivated: Qt.openUrlExternally(link)
            selectionColor: consoleWidgetRoot.selectedBackgroundColor
            readOnly: true
            Component.onCompleted: {
                textArea.font.pointSize = lineNumbersItem.fontPointSize
                //editorModel.document = textArea.textDocument
            }
        }

        ScrollBar.vertical: ScrollBar {}
        ScrollBar.horizontal: ScrollBar {}
    }

    Connections{
        target: consoleLog
        function onSendToConsole(time, type, source, message, msgColor){
            consoleWidgetRoot.addNewLine(time, type, source, message, msgColor);
        }
    }

    QtObject{
        id: internal

        property var dynamicColor: if(inputBox.down){
                                       inputBox.down ? colorPressed : colorDefault
                                   }else{
                                       inputBox.hovered ? colorMouseOver : colorDefault
                                   }
        property var dynamicTextColor:if(backend.determineFontColor(backgroundColor)){
                                          inputBox.color = textColorLight
                                      }else{
                                          inputBox.color = textColorDark
                                      }
        property var dynamicText: if(inputBox.text == ""){
                                      placeholderLbl.visible = true
                                  }else{
                                      placeholderLbl.visible = false
                                  }

    }

    SyntaxHighlighter {
        id: syntaxHighlighter
        textDocument: textArea.textDocument
        onHighlightBlock: {
            let rx = /(error)|(warn)|(log)|(info)/gm
            let m

            while ( ( m = rx.exec(text) ) !== null ) {
                if (m[0].match(/error/)) {
                    setFormat(m.index, m[0].length, errorFormat);
                    continue;
                }

                if (m[0].match(/log/)) {
                    setFormat(m.index, m[0].length, logFormat);
                    continue;
                }

                if (m[0].match(/info/)) {
                    setFormat(m.index, m[0].length, infoFormat);
                    continue;
                }

                if (m[0].match(/warn/)) {
                    setFormat(m.index, m[0].length, warnFormat);
                    continue;
                }

            }


        }
    }

    TextCharFormat { id: errorFormat; foreground: consoleWidgetRoot.errorColor}
    TextCharFormat { id: logFormat; foreground: consoleWidgetRoot.logColor }
    TextCharFormat { id: warnFormat; foreground: consoleWidgetRoot.warnColor }
    TextCharFormat { id: infoFormat; foreground: consoleWidgetRoot.infoColor }





}

/*##^##
Designer {
    D{i:0;autoSize:true;height:500;width:640}D{i:1}D{i:3}D{i:6}D{i:5}D{i:4}D{i:2}D{i:8}
D{i:7}D{i:9}D{i:13}D{i:14}D{i:15}D{i:16}D{i:17}D{i:18}D{i:19}
}
##^##*/
