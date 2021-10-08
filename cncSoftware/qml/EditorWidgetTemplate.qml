import QtQuick 2.0
import QtQuick.Controls 2.15

Rectangle{
    id: mainRect
    width: setWidth
    height: setHeight
    color: "#6cc1e8"
    border.width: 0
    border.color: "#C32C30"

    property string sourceWidgetString: "TemplateWidget.qml"
    property string name
    //default
    property int setWidth
    property int setHeight

    property int minimumWidth
    property int minimumHeight
    property int maximumWidth
    property int maximumHeight

    //index ++ za kazdy dodany nowy element
    property var widgetIndex


    Loader{
        id: stackView
        anchors.fill: parent
        source: Qt.resolvedUrl(sourceWidgetString)
        clip: true
        //enable to be able to click on elements inside
        enabled: false
        asynchronous: true;
        onVisibleChanged:      { loadIfNotLoaded(); }
        Component.onCompleted: { loadIfNotLoaded(); }
        onStatusChanged: {
            if (status == Loader.Ready) {
                //loaded()

            }
        }

        function loadIfNotLoaded () {
            // to load the file at first show
            if (visible && !active) {
                active = true;
            }
        }
    }

    function setProperties(v_name, v_width, v_height, v_minwidth, v_minheight, v_maxwidth, v_maxheight){

        mainRect.name = v_name

        mainRect.minimumWidth = v_minwidth
        mainRect.maximumWidth = v_maxwidth

        mainRect.minimumHeight = v_minheight
        mainRect.maximumHeight = v_maxheight

        mainRect.setHeight = v_height
        mainRect.setWidth = v_width

        setWidgetSize()
    }

    QtObject{
        id:internal

        property bool isSelected: false
        function on_thisSelected(){
            mainRect.border.width = 2
            mainRect.border.width = 0
        }
    }

    function setWidgetSize(){
        if(minimumHeight > maximumHeight || minimumWidth > maximumWidth){
            minimumHeight = maximumHeight;
            minimumWidth = maximumWidth;
        }
        if(this.width < minimumWidth){
            this.width = minimumWidth
        }
        if(this.height < minimumHeight){
            this.height = minimumHeight
        }
        if(this.width > maximumWidth){
            this.width = maximumWidth
        }
        if(this.height > maximumHeight){
            this.height = maximumHeight
        }

    }

    onWidthChanged: {setWidgetSize()}
    onHeightChanged: {setWidgetSize()}

    MouseArea {
        id: resizeRectBL
        x: 864
        y: 1
        width: 10
        height: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeFDiagCursor
        onPressed: {
            previousY = mouseY
            previousX = mouseX;
        }
        onMouseXChanged: {
            if(mainRect.width >= minimumWidth){
                var dx = mouseX - previousX
                mainRect.width = mainRect.width+dx
            }
        }
        onMouseYChanged: {
            if(mainRect.height >= minimumHeight){
                var dy = mouseY - previousY
                mainRect.height = mainRect.height + dy
            }
        }
        Rectangle{
            color: "#095476"
            anchors.fill: parent
        }


    }


    property int previousY
    property int previousX

    MouseArea {
        id: resizeRectR
        x: 869
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: resizeRectBL.top
        anchors.topMargin: 0
        cursorShape: Qt.SizeHorCursor

        onPressed: {
            previousX = mouseX
        }
        onMouseXChanged: {
            if(mainRect.width >= minimumWidth){
                var dx = mouseX - previousX
                mainRect.width = mainRect.width+dx
            }
        }

        Rectangle {
            color: "#14de80"
            anchors.fill: parent
        }
    }

    MouseArea {
        id: resizeRectB
        height: 10
        anchors.left: parent.left
        anchors.right: resizeRectBL.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        cursorShape: Qt.SizeVerCursor
        onPressed: {
            previousY = mouseY

        }

        onMouseYChanged: {
            if(mainRect.height >= minimumHeight){
                var dy = mouseY - previousY
                mainRect.height = mainRect.height + dy
            }
        }
        Rectangle {
            color: "#b638d4"
            anchors.fill: parent
        }
    }

    MouseArea {
        id: dragArea
        anchors.left: parent.left
        anchors.right: resizeRectR.left
        anchors.top: parent.top
        anchors.bottom: resizeRectB.top
        anchors.bottomMargin: 0
        anchors.rightMargin: 0

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        drag.target: mainRect
        drag.axis: Drag.XAxis | Drag.YAxis
        drag.minimumX: 0
        drag.minimumY: 0
        drag.maximumX: mainRect.parent.width
        drag.maximumY: mainRect.parent.height

        Drag.hotSpot.x: mainRect.width/2
        Drag.hotSpot.y: mainRect.height/2


        cursorShape: drag.active ? Qt.ClosedHandCursor : Qt.OpenHandCursor

        onPressed:{
            editorPage.selected = mainRect
            cells.draggedWidgetIndex = mainRect.widgetIndex
        }
        onClicked: {
            if (mouse.button === Qt.RightButton)
                contextMenu.popup()
        }
        onPressAndHold: {
            if (mouse.source === Qt.MouseEventNotSynthesized)
                contextMenu.popup()
        }

        onReleased: {
            console.log("dragged: "+mainRect.widgetIndex)
            console.log("dropped at: ")



            mainRect.x = cells.itemAt(mainRect.widgetIndex).x
            mainRect.y = cells.itemAt(mainRect.widgetIndex).y

//            mainRect.width = cells.itemAt(mainRect.draggedIndex).width
//            mainRect.height = cells.itemAt(mainRect.draggedIndex).height
        }

        Menu {
            id: contextMenu
            MenuItem { text: "Delete"; onClicked: mainRect.destroy()}
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3;height:50;width:100}
}
##^##*/
