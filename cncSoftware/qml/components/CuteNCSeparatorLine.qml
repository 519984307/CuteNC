import QtQuick 2.0

Item {
    id:separatorLineRoot
    height: separatorLineThickness
    width: separatorLineThickness
    anchors.margins: 20

    property string separatorLineColor
    property int separatorLineRadius
    property int separatorLineThickness

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        separatorLineRoot.separatorLineColor = JsonObjectTheme.separatorLineColor;
        separatorLineRoot.separatorLineRadius = JsonObjectTheme.separatorLineRadius;
        separatorLineRoot.separatorLineThickness = JsonObjectTheme.separatorLineThickness;
    }

    Component.onCompleted: {
        jsonSettings()
    }

    Connections{
        target: backend
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
    }

    Rectangle{
        anchors.fill:parent;
        color: separatorLineRoot.separatorLineColor
        radius: separatorLineRoot.separatorLineRadius
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2}D{i:1}D{i:2}
}
##^##*/
