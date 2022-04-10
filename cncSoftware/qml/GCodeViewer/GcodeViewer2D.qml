import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components"
Rectangle{
    id:viewer2Droot
    clip:true
    color:"#21323a"
    z:parent.z+1

    property string resetViewBtnIcon
    property string resetViewFontFamily
    property string resetViewLabel
    property int resetViewFontPointSize

    property string plotBtnIcon
    property string plotBtnFontFamily
    property string plotBtnLabel
    property int plotBtnFontPointSize

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        viewer2Droot.resetViewBtnIcon = JsonObjectTheme.viewerWidget.resetViewButton.btnIcon;
        viewer2Droot.resetViewFontFamily = JsonObjectTheme.viewerWidget.resetViewButton.fontFamily;
        viewer2Droot.resetViewFontPointSize = JsonObjectTheme.viewerWidget.resetViewButton.fontPointSize;
        viewer2Droot.resetViewLabel = JsonObjectTheme.viewerWidget.resetViewButton.label;

        viewer2Droot.plotBtnIcon = JsonObjectTheme.viewerWidget.plotButton.btnIcon;
        viewer2Droot.plotBtnFontFamily = JsonObjectTheme.viewerWidget.plotButton.fontFamily;
        viewer2Droot.plotBtnFontPointSize = JsonObjectTheme.viewerWidget.plotButton.fontPointSize;
        viewer2Droot.plotBtnLabel = JsonObjectTheme.viewerWidget.resetViewButton.label;
    }

    Component.onCompleted: {
        jsonSettings();
        canvas.clear();
    }


    Connections{
        target: backend
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
    }

    property var array: []
    QtObject{
        id:internal
        function putIntoArray(type,value){
            var item =[type,value];
            viewer2Droot.array.push(item);
        }
    }


    Connections{
        target:axisController


        function onSignal_Drawing(cmds,type){
            console.log("signal_drawing " + cmds + " " + type);
            let command = [];

            for(var i = 0 ; i < cmds.length; i++){
                let temp;
                let item;
                switch (cmds[i][0]){
                case 'X':
                    temp = cmds[i].substring(1);
                    item = ['X',parseFloat(temp)];
                    command.push(item);
                    break;
                case 'Y':
                    temp = cmds[i].substring(1);
                    item = ['Y',parseFloat(temp)];
                    command.push(item);
                    break;
                case 'Z':
                    temp = cmds[i].substring(1);
                    item = ['Z',parseFloat(temp)];
                    command.push(item);
                    break;
                case 'I':
                    temp = cmds[i].substring(1);
                    item = ['I',parseFloat(temp)];
                    command.push(item);
                    break;
                case 'J':
                    temp = cmds[i].substring(1);
                    item = ['J',parseFloat(temp)];
                    command.push(item);
                    break;
                case 'R':
                    temp = cmds[i].substring(1);
                    item = ['R',parseFloat(temp)];
                    command.push(item);
                    break;
                }
            }
            internal.putIntoArray(command,type)
        }
    }

    Connections{
        target:backend
        function onSignal_DrawFromFile(fileContent){
            consoleLog.drawFromFile(fileContent);
            viewer2Droot.array = [];
            canvas.clear();
            canvasBg.resetView();
        }
        function onSignal_RefreshWidgets(){
            canvasBg.resetView();
        }
    }

    Rectangle {
        id:canvasBg
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        color: parent.color
        border.color: "black"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        clip:true


        function resetView(){
            wrapperCanvas.x = canvasBg.width/2 - wrapperCanvas.width/2
            wrapperCanvas.y = canvasBg.height/2 - wrapperCanvas.height/2
            transform.xScale = 1;
            transform.yScale = 1;
            area.zoomValue = 0;
            zoomLbl.text = "Zoom: "+area.zoomValue.toString();
            canvas.requestPaint();
        }

        Rectangle{
            id:wrapperCanvas
            border.color: "black"
            border.width: 2

            width: canvas.width+rlMargins
            height: canvas.height+rlMargins
            x: canvas.width/2
            y: canvas.height/2

            property int rlMargins: 0
            MouseArea{
                id:area
                anchors.fill:parent
                propagateComposedEvents: true
                property double factor: 2.0
                //-1 to 4
                property int minZoomValue: -2
                property int maxZoomValue: 3
                property int zoomValue: 0
                onWheel:{
                    if(wheel.angleDelta.y > 0){
                        area.zoomValue++;
                        if(area.zoomValue <= maxZoomValue){
                            let zoomFactor = factor;
                            let realX = (wheel.x * transform.xScale).toFixed(0)
                            let realY = (wheel.y * transform.yScale).toFixed(0)
                            wrapperCanvas.x += (1 - zoomFactor) * realX
                            wrapperCanvas.y += (1 - zoomFactor) * realY
                            transform.xScale *= zoomFactor
                            transform.yScale *= zoomFactor
                        }else{
                            area.zoomValue = maxZoomValue;
                        }
                    }else{
                        area.zoomValue--;
                        if(area.zoomValue >= minZoomValue){
                            let zoomFactor = 1/factor;
                            let realX = (wheel.x * transform.xScale).toFixed(0)
                            let realY = (wheel.y * transform.yScale).toFixed(0)
                            wrapperCanvas.x += (1 - zoomFactor) * realX
                            wrapperCanvas.y += (1 - zoomFactor) * realY
                            transform.xScale *= zoomFactor
                            transform.yScale *= zoomFactor
                        }else{
                            area.zoomValue = minZoomValue;
                        }
                    }
                    zoomLbl.text = "Zoom: "+area.zoomValue.toString();
                }
            }
            transform: Scale {
                id: transform
            }

            Canvas {
                id:canvas
                z:parent.z+1
                height: 8000
                width: 8000
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: parent.rlMargins/2
                anchors.leftMargin: parent.rlMargins/2

                property int scaleEverything: 10;
                property int drawLineWidth: 5;


                property bool requestInitial: true;
                property bool requestSetScale: false;

                property bool requestLine: false;
                property bool requestBlank: false;
                property bool requestBlankMove: false;
                property bool requestArc: false;

                property bool requestFile: false;

                property variant colorX: "#C32C30"
                property variant colorY: "#4E9C4A"
                property variant pathColor: "#2F618E"
                property variant normal: "#000000"
                property variant axesColor: "#404040"
                property variant gridColor: "#9F9F9F"

                property variant aerialMove: "#E74C3C"

                property real zoomScale: 1.0

                property int mouseX
                property int mouseY

                antialiasing: true
                smooth:false



                property bool isArc: false
                property bool isLine:false
                property bool arcClockwise:true;

                property double arcRadius:0
                property double arcStartAngle:0
                property double arcEndAngle:0
                property double arcStartX:0
                property double arcStartY:0

                property double arcCenterX:0
                property double arcCenterY:0

                property double lastLineX:0
                property double lastLineY:0
                property double newLineX: 0
                property double newLineY: 0

                property double i: 0
                property double j: 0

                function clear(){
                    canvas.lastLineX = 0;
                    canvas.lastLineY = 0;
                    canvas.newLineX = 0;
                    canvas.newLineY = 0;
                    var ctx = getContext('2d');
                    ctx.reset();
                    canvas.requestInitial = true;
                    canvas.requestPaint();
                }

                function makeLine(type,lineLength){

                    switch(type){
                    case 0:

                        newLineX=lineLength;
                        canvas.requestLine = true;
                        canvas.requestPaint();
                        break;
                    case 1:

                        newLineY=-lineLength;
                        canvas.requestLine = true;
                        canvas.requestPaint();
                        break;
                    }
                }


                function endPoint(context,color){
                    context.save();
                    //code

                    context.lineWidth = canvas.drawLineWidth;
                    context.beginPath();
                    context.arc(canvas.lastLineX, canvas.lastLineY, (canvas.drawLineWidth)/2, 0, 360)
                    context.fillStyle = color;
                    //context.arc(lastLineX,lastLineY,30,0,Math.PI*2);
                    context.fill();
                    context.restore();
                }



            function draw(context){
                if(canvas.isArc){



                        let dxStart = canvas.lastLineX - canvas.arcStartX;
                        let dyStart = canvas.lastLineY - canvas.arcStartY;

                        //10 - 10
                        //10 - 10
                        let dxEnd = canvas.newLineX - canvas.arcStartX;
                        let dyEnd = canvas.newLineY - canvas.arcStartY;


                        let radius = Math.sqrt((dxStart*dxStart)+(dyStart*dyStart));

                        let firstAngle = Math.atan2(dyStart, dxStart);
                        let secondAngle = Math.atan2(dyEnd, dxEnd);

                        //Pełny okrąg
                        if(firstAngle == secondAngle){
                            firstAngle = 0;
                            secondAngle = Math.PI*2;
                        }


                        canvas.lastLineX = canvas.arcStartX + Math.cos(secondAngle * Math.PI / 180) * radius;
                        canvas.lastLineY = canvas.arcStartY + Math.sin(secondAngle * Math.PI / 180) * radius;

                        //draw arc
                        endPoint(context,canvas.pathColor);
                        context.save();

                        context.lineWidth = canvas.drawLineWidth;
                        context.beginPath();

                        context.arc(canvas.arcStartX, canvas.arcStartY, radius, firstAngle, secondAngle, canvas.arcClockwise)

                        context.strokeStyle = canvas.pathColor;

                        context.stroke();
                        context.restore();
                        endPoint(context,canvas.pathColor);
                    }
                    if(canvas.isLine){
                        console.log('drawing line');
                        if(axisController.getZPosition() > 0){

                            //Punkt końcowy
                            endPoint(context,canvas.aerialMove);

                            context.save();

                            context.lineWidth = canvas.drawLineWidth;
                            context.beginPath();

                            context.moveTo(canvas.lastLineX,canvas.lastLineY);
                            canvas.lastLineX = canvas.newLineX;
                            canvas.lastLineY = canvas.newLineY;

                            context.lineTo(canvas.lastLineX,canvas.lastLineY);

                            context.strokeStyle = canvas.aerialMove;
                            context.stroke();

                            context.restore();

                            //Punkt końcowy
                            endPoint(context,canvas.aerialMove);
                        }else{
                            //Punkt końcowy
                            endPoint(context,canvas.pathColor);
                            context.save();
                            context.lineWidth = canvas.drawLineWidth;
                            context.beginPath();

                            //Położenie kursora
                            context.moveTo(canvas.lastLineX,canvas.lastLineY);

                            canvas.lastLineX = canvas.newLineX;
                            canvas.lastLineY = canvas.newLineY;

                            //Linia
                            context.lineTo(canvas.lastLineX,canvas.lastLineY);

                            context.strokeStyle = canvas.pathColor;
                            context.stroke();
                            context.restore();
                            //Punkt końcowy
                            endPoint(context,canvas.pathColor);
                        }
                    }
                }


                function initCanvas(context){
                    canvas.lastLineX = 0;
                    canvas.lastLineY = 0;
                    context.save();
                    context.moveTo(0,0);
                    context.beginPath();

                    context.lineWidth = 1;

                    var wgrid = 20;
                    var nrows = canvas.width/wgrid;
                    var ncols = canvas.height/wgrid;
                    console.log("nrows " + nrows);
                    console.log("ncols " + ncols);

                    for(var i=0; i < nrows; i++){
                        context.moveTo(0, wgrid*i);
                        context.lineTo(canvas.width, wgrid*i);
                    }

                    for(var j = 0; j < ncols; j++){
                        context.moveTo(wgrid*j, 0);
                        context.lineTo(wgrid*j, canvas.height);
                    }

                    context.strokeStyle = gridColor;
                    context.stroke();


                    context.moveTo(0,0);
                    context.beginPath();

                    for(var i=0; i < nrows; i+=10){
                        context.moveTo(0, (wgrid*i)+wgrid*0); //0 , 20 , 40
                        context.lineTo(canvas.width, (wgrid*i)+wgrid*0);
                    }

                    for(var j = 0; j < ncols; j+=10){
                        context.moveTo((wgrid*j)+wgrid*0, 0);
                        context.lineTo((wgrid*j)+wgrid*0, canvas.height);
                    }
                    context.strokeStyle = axesColor;
                    context.stroke();


                    //X & Y axis
                    context.lineWidth = canvas.drawLineWidth;
                    //vertical
                    context.beginPath();
                    context.moveTo(canvas.width/2,0);
                    context.lineTo(canvas.width/2,canvas.height);
                    //horizontal
                    context.moveTo(0,canvas.height/2);
                    context.lineTo(canvas.width,canvas.height/2);

                    context.strokeStyle = axesColor;
                    context.stroke();
                    context.restore();

                }


                onPaint:{
                    var ctx = getContext('2d');

                    if(canvas.requestInitial){
                        canvas.initCanvas(ctx);
                        canvas.requestInitial = false;
                        ctx.translate(canvas.width/2,canvas.height/2)
                    }

                    if(canvas.requestLine){

                        canvas.draw(ctx);
                        canvas.requestLine = false;
                    }

                    if(canvas.requestBlankMove){
                        ctx.moveTo(posX,posY);
                        canvas.requestBlankMove = false;
                    }

                    if(!canvas.requestFile){
                        for(var i in viewer2Droot.array){
                            let line = viewer2Droot.array[i];
                            let singleCommand = line[0];
                            let movementType = line[1];
                            if(movementType === 'G0' || movementType === 'G1' || movementType === 'G01' || movementType === 'G00'){
                                canvas.isLine = true;
                                canvas.isArc = false;
                            }else if(movementType === 'G2' || movementType == 'G3' || movementType === 'G02' || movementType == 'G03'){
                                if(movementType === 'G2' || movementType === 'G02'){
                                    canvas.isArc = true;
                                    canvas.arcClockwise = false;
                                }
                                if(movementType === 'G3' || movementType === 'G03'){
                                    canvas.isArc = true;
                                    canvas.arcClockwise = true;
                                }

                                canvas.isLine = false;
                            }

                            for(var j = 0; j < singleCommand.length; j++){

                                let axis = singleCommand[j];

                                switch(axis[0]){
                                case 'X':
                                    canvas.newLineX=axis[1]*scaleEverything;
                                    break;
                                case 'Y':
                                    canvas.newLineY=-axis[1]*scaleEverything;
                                    break;
                                case 'Z':
                                    //nothing
                                    break;
                                case 'I':
                                    canvas.i = axis[1]*scaleEverything;
                                    canvas.arcStartX = canvas.lastLineX + canvas.i;
                                    break;
                                case 'J':
                                    canvas.j = -axis[1]*scaleEverything;
                                    canvas.arcStartY = canvas.lastLineY + canvas.j;
                                    break;
                                }
                            }

                            canvas.draw(ctx);

                        }
                        canvas.requestFile = false;
                    }
                }
            }

            MouseArea {
                drag.target: wrapperCanvas
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                propagateComposedEvents: true
            }
        }


        Button {
            id: plotButton
            x: 483
            y: 363
            width: 50
            height: 50
            text: viewer2Droot.plotBtnIcon
            font.pointSize: viewer2Droot.plotBtnFontPointSize
            font.family: viewer2Droot.plotBtnFontFamily
            anchors.right: parent.right
            anchors.bottom: resetViewButton.top

            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            onClicked:{
                viewer2Droot.array = [];
                console.log(backend.getGcodeFile());
                consoleLog.drawFromFile(backend.getGcodeFile());
                canvas.clear();
                //canvasBg.resetView();
            }
        }

        Button{
            id:resetViewButton
            x: 80
            y: -25
            width: 50
            height: 50
            text: viewer2Droot.resetViewBtnIcon
            font.pointSize: viewer2Droot.resetViewFontPointSize
            font.family: viewer2Droot.resetViewFontFamily
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            onClicked:{
                canvasBg.resetView();
            }
            z: canvas.z+1
        }

        Label {
            id: zoomLbl
            width: 50
            height: 50
            color: "#000000"
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 10
            font.pointSize: 12
            font.family: "Consolas"
            anchors.rightMargin: 10
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:4}D{i:7}D{i:9}D{i:10}
D{i:6}D{i:11}D{i:12}D{i:13}D{i:5}
}
##^##*/
