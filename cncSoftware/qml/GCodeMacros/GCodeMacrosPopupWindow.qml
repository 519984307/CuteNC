import QtQuick.Window 2.12
import QtQuick 2.0
import QtQuick.Controls 2.12
import "../components"
Window{
    id:gCodeMacrosPopupWindowRoot
    width: 800
    height: 600

    minimumWidth: gCodeEditor.neededMinimiumWidth

    Rectangle{
        id: rectangle
        anchors.fill: parent


        CuteNCGCodeTextEditor{
            id:gCodeEditor

        }

        Rectangle {
            id: topRect
            height: 80
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
                height: 50
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 10
                anchors.topMargin: 10

            }

            CuteNCTextInput{
                id:textInput_Key
                width: 200
                height: 50
                anchors.left: textInput_MacroName.right
                anchors.top: parent.top
                anchors.leftMargin: 10
                anchors.topMargin: 10
                placeholder: "Enter key..."
            }

        }

        Rectangle {
            id: bottomRect
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topRect.bottom
            anchors.bottom: buttonsBar.top
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0

            CuteNCGCodeTextEditor{
                id:textEditor
                anchors.fill: parent
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
                    var text = textEditor.getText();

                    console.log(textEditor.getText());

                    var matches = [];


                    matches = text.match(/.+?(?=\n)|\n.*/mg);
                    var matchesFormatted = [];

                    matches.forEach(function(doc){
                        console.log(doc);
                        matchesFormatted.push(doc.trim("\n"));
                    });


//                    var strip1 = /<p[^>]*>/;
//                    var strip2 = /<\/p>/;

//                    for(var i = 0 ; i <= matches.length(); i++){
//                        if(matches[i] !== undefined){
//                            var split = matches[i].toString().split('<br />');
//                            var temp;

//                            if(split.length > 1){

//                                for(var j = 0; j <= split.length; j++){
//                                    if(split[j] !== undefined){

//                                        temp = split[j].toString().replace(strip1,'').replace(strip2,'');
//                                        // console.log(temp);
//                                        rawMatchesText.push(temp);
//                                    }
//                                }

//                            }else{
//                                temp = matches[i].toString().replace(strip1,'').replace(strip2,'');
//                                rawMatchesText.push(temp);
//                            }
//                        }
//                    }

                    json.createMacro(textInput_MacroName.getText(),matchesFormatted)


                    gCodeMacrosPopupWindowRoot.destroy();
                    gCodeMacrosPopupWindowRoot.close();
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:2}D{i:4}D{i:5}D{i:6}D{i:3}D{i:8}D{i:7}D{i:10}D{i:9}D{i:1}
}
##^##*/
