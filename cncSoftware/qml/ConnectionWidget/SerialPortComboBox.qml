import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml.Models 2.15
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.15



Rectangle {
    id: serialPortComboBox
    width: 128
    height: 32


    property string selectedPort

    function getComPorts() {
        model.clear()
        for(var i = 0; i < comport.numberOfAvailablePorts();i++){
            console.log(comport.getPortName(i));
            model.append({text: comport.getPortName(i)})
        }
    }

    ComboBox {
        id: comboBox
        anchors.fill:parent
        model: ListModel {
            id: model
        }

        onPressedChanged: {
            if(comboBox.pressed){
                getComPorts();
            }
        }

        onCurrentValueChanged: {
            selectedPort = currentText;
        }

    }

    Connections{
        target: comport
        function onSignal_GetPorts(){
            getComPorts()
        }
    }

}


