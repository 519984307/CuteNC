import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.3
import QtPositioning 5.12
import "../components"
Item {
    id: editorPage
    width: 800
    height: 600

    property var selected: null
    property int createdWidgets
    property var createdWidgetsArr: []

    //properties
    property int setWidth
    property int setHeight
    property int minimumWidth
    property int minimumHeight
    property int maximumWidth
    property int maximumHeight
    property bool setMaximumSize
    property bool setMinimumSize
    property color textColorLight
    property color textColorDark
    property color defaultColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor: "white"
    property color borderColor

    property bool borderVisible
    property int borderWidth
    property int borderRadius

    property int fontPointSize
    property string fontFamily

    property string fontAwesomeIcon
    property string text
    property string name
    property string value


    function jsonSettings(){
        var JsonString = backend.getJSONFile("../json/","TemplateFile.json");
        var JsonObject = JSON.parse(JsonString);

        var JsonStringTheme = backend.getJSONFile("../json/themes/",backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        backgroundColor = JsonObjectTheme.backgroundColor;

        //retrieve values from JSON
        name = JsonObject.name;
        value = JsonObject.value;

        borderVisible = JsonObject.borderVisible;
        borderWidth = JsonObject.borderWidth;
        borderRadius = JsonObject.borderRadius;

        textColorLight = JsonObject.colors.textColorLight;
        textColorDark = JsonObject.colors.textColorDark;
        defaultColor = JsonObject.colors.defaultColor;
        onHoverColor = JsonObject.colors.onHoverColor;
        onPressedColor = JsonObject.colors.onPressedColor

        borderColor = JsonObject.colors.borderColor;

        setWidth = JsonObject.width;
        setHeight = JsonObject.height;
        minimumWidth = JsonObject.minimumWidth;
        minimumHeight = JsonObject.minimumHeight;
        maximumWidth = JsonObject.maximumWidth;
        maximumHeight = JsonObject.maximumHeight;
        setMaximumSize = JsonObject.setMaximumSize;
        setMinimumSize = JsonObject.setMinimumSize;
        fontAwesomeIcon = JsonObject.fontAwesomeIcon;
        text = JsonObject.text;

    }
    QtObject{
        id:internal
        function currentlyOcuppiedCells(){
            var a = gridA.ocuppiedCells.length;
            return a;
        }
    }

    Rectangle{
        id:background
        color: backgroundColor
        anchors.fill:parent

        Component.onCompleted: {
            jsonSettings()
        }

        //EDITOR MENU

        Rectangle{
            id: editorMenu
            width: 250
            color: "#e9f3e9"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            z: 1
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0


            ScrollView{
                id: editorMenuScrollView
                anchors.fill: parent
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                //Add new element (widget)
                Button {
                    id: button
                    text: qsTr("Add")
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.leftMargin: 20
                    onClicked:
                    {
                        var component;
                        var sprite;

                        component = Qt.createComponent("../EditorWidgetComponent.qml");
                        console.log("created editortemplatewidget")
                        if( component.status !== Component.Ready )
                        {
                            if( component.status === Component.Error )
                                console.debug("Error:"+ component.errorString() );
                            return; // or maybe throw
                        }
                        sprite = component.createObject(grid, {"x": 100, "y": 100});
                        sprite.widgetIndex = createdWidgets++;
                        createdWidgetsArr.push(sprite)
                        sprite.loaded()

                    }
                }

                Label{
                    id:selectedName
                    text: {
                        if(selected.name != null){
                            return selected.name
                        }else{
                            return "xd"
                        }
                        }

                    anchors.left: parent.left
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                    anchors.topMargin: 100
                }

                Text {
                    id: occupiedText
                    x: 20
                    y: 192
                    width: 194
                    height: 324
                    text: internal.currentlyOcuppiedCells()
                    font.pixelSize: 12
                }


                //                            Rectangle{
                //                                id: selectedEditColors
                //                                width: 100
                //                                height: 100
                //                                anchors.left: parent.left
                //                                anchors.right: parent.right
                //                                anchors.top: selectedName.bottom
                //                                z: 0
                //                                anchors.rightMargin: 0
                //                                anchors.leftMargin: 0
                //                                anchors.topMargin: 10

                //                                ColorDialog {
                //                                    id: colorDialog
                //                                    title: "Please choose a color"
                //                                    onAccepted: {
                //                                        console.log("You chose: " + colorDialog.color)
                //                                        Qt.quit()
                //                                    }
                //                                    onRejected: {
                //                                        console.log("Canceled")
                //                                        Qt.quit()
                //                                    }
                //                                    Component.onCompleted: visible = true
                //                                }
                //                            }
            }



        }


        // END OF EDITOR MENU

        Rectangle{
            id: grid
            color: "#222222"
            width: parent.width
            height: parent.height
            anchors.left: editorMenu.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0

            CuteNCDragDropBox{
                id:box1
                anchors.fill:parent
            }

//            Grid{
//                id:gridA
//                anchors.fill:parent
//                columnSpacing: 0
//                rowSpacing: 0
//                columns:10
//                rows: 10


//                //spacing:1

//                property var previousArray: []
//                property var ocuppiedCells: []

////                function updateOcuppiedCells(){
////                    for(var i = 0; i <= gridA.ocuppiedCells.length; i++){
////                        cells.itemAt(gridA.ocuppiedCells[i]).bgColor = "grey"
////                    }
////                }

//                function getHowManyCellsWidgetOccupies(v_index, v_widgetIndex){


//                    var covXBegin = cells.itemAt(v_index).x;
//                    var covYBegin = cells.itemAt(v_index).y;

//                    var widgetSizeX = getWidget(v_widgetIndex).width;
//                    var widgetSizeY = getWidget(v_widgetIndex).height;

//                    var hmcX = Math.ceil(widgetSizeX/cells.itemAt(v_index).width)
//                    var hmcY = Math.ceil(widgetSizeY/cells.itemAt(v_index).height)

//                    console.log(hmcX +"  "+hmcY + " = "+(hmcX*hmcY))
//                    getWhichCellsWidgetOccupies(v_index, v_widgetIndex, hmcX, hmcY)
//                    return hmcX*hmcY

//                }

//                function getWhichCellsWidgetOccupies(v_firstCell, v_widgetIndex, hmcX, hmcY){

//                    for(var i = 0 ; i < hmcX; i++){
//                        for(var j = 0 ; j < hmcY; j++){
//                            var selectedCell = ((v_firstCell+(gridA.columns*i))+j);

//                            console.log("cell: "+selectedCell)
//                            modifyCell(selectedCell)

//                        }

//                    }
//                    console.log("\n")

//                }

//                function getWidget(v_index){
//                    for(var i = 0; i <= createdWidgetsArr.length; i++){
//                        if(i === v_index){
//                            return createdWidgetsArr[i]
//                        }
//                    }
//                }

//                function modifyCell(v_cellIndex){
//                    for(var i = 0; i <= (gridA.rows*gridA.columns); i++){
//                        if(i === v_cellIndex){
//                            cells.itemAt(i).bgColor = "grey"
//                        }
//                    }
//                }

//                function updateCells(){
//                    for(var i = 0; i <= (gridA.rows*gridA.columns); i++){
//                       //cells.itemAt(i).textColor = "black"
//                    }
//                }

//                function doStateStuff(v_index){

//                    console.log(v_index)
//                    var covXBegin = cells.itemAt(v_index).x;
//                    var covYBegin = cells.itemAt(v_index).y;

//                    var widgetSizeX = selected.width;
//                    var widgetSizeY = selected.height;

//                    var hmcX = Math.ceil(widgetSizeX/cells.itemAt(v_index).width)
//                    var hmcY = Math.ceil(widgetSizeY/cells.itemAt(v_index).height)

//                    var selectedArray = []

//                    for(var i = 0 ; i < hmcX; i++){
//                        for(var j = 0 ; j < hmcY; j++){
//                            var selectedCell = ((v_index+(gridA.columns*i))+j);
//                            selectedArray.push(selectedCell)
//                            //cells.itemAt(selectedCell).textColor = "black"
//                        }
//                    }

//                    gridA.previousArray = selectedArray
//                    gridA.ocuppiedCells = selectedArray

//                    for(var cell = 0; cell <= selectedArray.length; cell++){
//                        cells.itemAt(selectedArray[cell]).bgColor = "white"
//                    }

//                    updateCells()

//                    gridA.getWhichCellsWidgetOccupies()

//                    for(var z = 0; z <= createdWidgetsArr.length; z++){
//                        gridA.getHowManyCellsWidgetOccupies(v_index,z)
//                    }


//                }



//                Repeater{
//                    id: cells
//                    model: gridA.columns*gridA.rows

//                    Rectangle{
//                        id:cell
//                        width: 30
//                        height: 30
//                        Layout.columnSpan: 1
//                        Layout.rowSpan: 1

//                        property color textColor: "red"
//                        property color bgColor: "white"
//                        Text{
//                            id:cellLbl
//                            anchors.fill:parent
//                            text: index
//                            color: textColor
//                            z:10

//                        }

//                        DropArea {
//                            id: dragTarget
//                            property alias dropProxy: dragTarget
//                            anchors.fill: parent


//                            keys: [ colorKey ]

//                            Rectangle {
//                                id: dropRectangle
//                                anchors.fill: parent
//                                color: bgColor

//                                states: [
//                                    State {
//                                        when: dragTarget.containsDrag
//                                        PropertyChanges {
//                                            target: dropRectangle
//                                            color: "grey"
//                                        }
//                                        StateChangeScript {
//                                            name: "myScript"
//                                            script: gridA.doStateStuff(index);
//                                        }
//                                    }
//                                ]
//                            }
//                        }
//                    }

//                }
//            }


        }




        //DOTTED GRID
        //        Rectangle{
        //            id: grid
        //            color: "#fdfdfd"
        //            width: parent.width
        //            height: parent.height
        //            anchors.left: editorMenu.right
        //            anchors.right: parent.right
        //            anchors.top: parent.top
        //            anchors.bottom: parent.bottom
        //            z: 1
        //            anchors.leftMargin: 0
        //            property int howMany: 10
        //            property int spacing: 10

        //            Row{
        //                spacing: grid.spacing
        //                Repeater{
        //                    id:repeaterVer
        //                    model:  Math.floor(grid.width/grid.howMany)
        //                    delegate: Column{
        //                        spacing: grid.spacing
        //                        Repeater{
        //                            id:repeaterHor
        //                            model:  Math.floor(grid.height/grid.howMany)
        //                            Rectangle{
        //                                height: 2
        //                                width: 2
        //                                color:"#222222"
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //END OF DOTTED GRID
    }

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }
    Component.onCompleted: {
        jsonSettings()
    }

}




/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
