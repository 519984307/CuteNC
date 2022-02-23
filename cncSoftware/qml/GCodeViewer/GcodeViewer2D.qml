import QtQuick 2.0
import QtQuick.Controls 2.15
Rectangle{
    id:viewer2Droot
    clip:true
    color:"transparent"
    z:10000
    Button{
        id:leftb
        width:80
        height:50
        text: "Clear"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 0
        onClicked:{

            canvas.clear()
        }
        z: canvas.z+1
    }

    Connections{
        target:axisController
        function onSignal_MoveX(lineSize){
              canvas.makeLine(0,lineSize);
        }
        function onSignal_MoveY(lineSize){
              canvas.makeLine(1,lineSize);
        }
    }

    Rectangle {
        id:canvasBg
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        color: "transparent"
        border.color: "black"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: leftb.bottom
        radius: 0

        Canvas {
            id:canvas
            anchors.fill:parent
            z:parent.z+1
            property int oldW: canvas.width
            property int oldH: canvas.height

            onWidthChanged: {

                console.log(canvas.width +  " " + canvas.height)
                var ctx = getContext('2d');

                ctx.scale(2,0.5)
                canvas.requestPaint();
                canvas.oldW = canvas.width;
                canvas.oldH = canvas.height;
            }
            onHeightChanged: {
                var ctx = getContext('2d');
                ctx.scale(1,1)
                canvas.requestPaint();
                canvas.oldW = canvas.width;
                canvas.oldH = canvas.height;
            }

            property bool init: true;

            property bool lineMove: false;
            property bool arcMove: false;
            property bool airMove: false;

            property variant colorX: "#C32C30"
            property variant colorY: "#4E9C4A"
            property variant colorZ: "#2F618E"
            property variant normal: "#000000"
            property variant axesColor: "#404040"
            property variant gridColor: "#9F9F9F"

            Text {
                id:textAxis
                font.family: "Noto Sans"
                font.pointSize: 8
                color: "red"
            }

            property real viewScale: 1
            property real zoomScale: 1.0

            scale: Math.max(0.1, 1.0 / canvas.zoomScale)

            height: parent.height * canvas.zoomScale
            width: parent.width * canvas.zoomScale

            antialiasing: false
            smooth:false
            transformOrigin: Item.TopLeft

            Component.onCompleted: {
                canvas.clear();
            }

            function clear(){
                canvas.init = true;
                var ctx = getContext('2d');
                ctx.reset();
                canvas.requestPaint();
            }


            property int lastLineX
            property int lastLineY
            property int newLineX: 0
            property int newLineY: 0

            function makeLine(type,lineLength){
                console.log("makingLine");

                canvas.lineMove = true;
                canvas.arcMove = false;
                canvas.airMove = false;
                canvas.init = false;

                switch(type){
                case 0:
                    newLineX=lineLength
                    canvas.requestPaint();
                    break;
                case 1:
                    newLineY=-lineLength
                    canvas.requestPaint();
                    break;
                }
            }

            MouseArea{
                id:area
                anchors.fill:parent
                onWheel:{
                    if (wheel.modifiers & Qt.ControlModifier) {
                        if(wheel.angleDelta.y > 0){
                            canvas.zoomScale = (canvas.zoomScale + 0.1).toFixed(2);
                        }else{
                            if(canvas.zoomScale <=0.1){
                                canvas.zoomScale = 0.1;
                            }else{
                                canvas.zoomScale = (canvas.zoomScale - 0.1).toFixed(2);
                            }
                        }
                        console.log(canvas.zoomScale.toFixed(2));
                     }
                    zoomLbl.text = String(canvas.zoomScale.toFixed(2))
                }

            }

            property int wgrid: 20
            onPaint:{
                var ctx = getContext('2d');
                ctx.save();

                //ctx.translate(canvas.width/2,canvas.height/2)
                if(canvas.init){
                    //grid
                    ctx.lineWidth = 3;
                    //grid

                    //vertical
                    ctx.beginPath();
                    ctx.moveTo(canvas.width/2,0);
                    ctx.lineTo(canvas.width/2,canvas.height);
                    //horizontal
                    ctx.moveTo(0,canvas.height/2);
                    ctx.lineTo(canvas.width,canvas.height/2);

                    ctx.strokeStyle = axesColor;
                    ctx.stroke();
                    ctx.beginPath();

                    ctx.moveTo(0,0);

                    var nrows = canvas.width/wgrid;
                    console.log("NROWS: " + nrows)
                    for(var i=0; i < nrows+1; i++){
                      ctx.moveTo(0, wgrid*i);
                      ctx.lineTo(60, wgrid*i);
                    }

                    var ncols = canvas.height/wgrid;
                    for(var j=0; j < ncols+1; j++){
                      ctx.moveTo(wgrid*j, 0);
                      ctx.lineTo(wgrid*j, 60);
                    }

                     ctx.strokeStyle = gridColor;
                     ctx.stroke();
                    canvas.init = false;
                }else{
                    ctx.translate(canvas.width/2,canvas.height/2)
                }

                if(canvas.lineMove){
                    console.log("making a line")
                    //code

                    ctx.lineWidth = 8;
                    ctx.beginPath();
                    ctx.moveTo(lastLineX,lastLineY);
                    lastLineX = newLineX;
                    lastLineY = newLineY;
                    ctx.lineTo(lastLineX,lastLineY);
                    ctx.strokeStyle = colorZ;
                    //ctx.arc(lastLineX,lastLineY,30,0,Math.PI*2);
                    ctx.stroke();

                }
                if(canvas.arcMove){
                    //code
                    ctx.lineWidth = 2;
                    ctx.beginPath();
                    ctx.moveTo(lastLineX,lastLineY);
                    lastLineX = newLineX;
                    lastLineY = newLineY;
                    ctx.lineTo(lastLineX,lastLineY);
                    ctx.strokeStyle = colorZ;
                    //ctx.arc(lastLineX,lastLineY,30,0,Math.PI*2);
                    ctx.stroke();

                }
                if(canvas.airMove){
                    ctx.moveTo(posX,posY);
                }
                ctx.save();
                //code
                ctx.restore();
            }
        }
    }

    Label {
        id: zoomLbl
        text: qsTr("Label")
        anchors.left: testbtn.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: canvasBg.top
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 12
        font.family: "Noto Sans"
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:6}D{i:5}D{i:4}D{i:7}
}
##^##*/
