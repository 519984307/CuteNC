import QtQuick.Window 2.12
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import "../components"

Rectangle{
    id:gCodeMacrosRoot
    width: 600
    height: 600

   CuteNCButton{
       id:openPopupMacrosWindow
       width: 100
       height: 50
       onClicked: {
           var component = Qt.createComponent("GCodeMacrosPopupWindow.qml")
           var window    = component.createObject(gCodeMacrosRoot)
           window.show()
       }
   }

}


