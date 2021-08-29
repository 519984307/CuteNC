import QtQuick 2.0
import QtQuick.Controls 2.15
Item {
    id: settingsPage
    width: 800
    height: 600

    property string selectedTheme
    function getThemeNames() {
        model.clear()
        for(var i = 0; i < backend.numberOfThemes();i++){
            model.append({text: backend.getThemeName(i).replace(".json","")})
        }
    }
    Rectangle{
        id:background
        color: "#ffffff"
        anchors.fill:parent



        ComboBox {
            id: comboBox
            x: 8
            y: 8
            model: ListModel {
                id: model
            }

            onCurrentValueChanged: {
                selectedTheme = currentText;
            }

        }
        //Add new element (widget)
        Button {
            id: button
            x: 166
            y: 8
            text: qsTr("Set Selected")

            anchors.topMargin: 20
            anchors.leftMargin: 20
            onClicked:{            
                backend.setTheme(selectedTheme+".json")
                backend.refreshWidgetsInvoker();
            }
        }

    }

    Connections{
        target: backend
        function onGetThemes(){
            console.log("getting themes")
            getThemeNames()
        }
    }
    Component.onCompleted: {
        getThemeNames()
    }
}


