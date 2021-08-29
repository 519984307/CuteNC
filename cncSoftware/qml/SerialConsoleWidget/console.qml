import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle{
    id:consoleBg
    width: 800
    height: 300

    property string cssStyle:{"
        <style type='text/css'>
        p{background-color:white}
        p:hover{background-color:red}
        </style>
    "}

    property string consoleLineTime: "00:00:00"
    property string consoleLineSource: "System"
    property string consoleLineTemplate: "<p>asd</p>"

    QtObject{
        id: internal
        function setColor(source){
            if(source === "System"){
                console.log("blue");
            }
            if(source === "Error"){
                console.log("red");
            }
            if(source === "Warning"){
                console.log("yellow");
            }
            if(source === "G-Code"){
                console.log("green");
            }
        }


        function textToDisp(){
            var text = cssStyle + consoleLineTemplate;
            return text
        }

    }



    ListView {
        id: listView
        anchors.fill: parent
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                spacing: 10
            }
        }
        model: ListModel {
            ListElement {
                name: "Grey"
                colorCode: "grey"
            }

            ListElement {
                name: "Red"
                colorCode: "red"
            }

            ListElement {
                name: "Blue"
                colorCode: "blue"
            }

            ListElement {
                name: "Green"
                colorCode: "green"
            }
        }
    }


}
