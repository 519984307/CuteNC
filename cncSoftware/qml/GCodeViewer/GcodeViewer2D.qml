import QtQuick 2.0
import QtQuick.Controls 2.15
Rectangle{
    id:viewer2Droot
    Button{
        id:leftb
        width:80
        height:50
        text: "Left"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 0
        onClicked:{
            canvas.makeLine(0);
        }
        z: canvas.z+1
    }
    Button{
        id:rightb
        width:80
        height:50
        text: "Right"
        anchors.left: leftb.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 0
        onClicked:{
            canvas.makeLine(1);
        }
           z: canvas.z+1
    }
    Button{
        id:upb
        width:80
        height:50
        text: "Up"
        anchors.left: rightb.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 0
        onClicked:{
            canvas.makeLine(2);
        }
           z: canvas.z+1
    }
    Button{
        id:downb
        width:80
        height:50
        text: "Down"
        anchors.left: upb.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 0
        onClicked:{
            canvas.makeLine(3);
        }
           z: canvas.z+1
    }


    Canvas {
        id:canvas
        anchors.fill:parent
        property int lastX: 0
        property int lastY: 0

        //property var viewScale: 1

        property int nextX: 0
        property int nextY: 0

        property variant colorX: "#C32C30"
        property variant colorY: "#4E9C4A"
        property variant colorZ: "#2F618E"
        property variant normal: "#000000"

        property real viewScale: 1
        property real zoomScale: 1.0

        scale: 1.0 / canvas.zoomScale

        height: parent.height * canvas.zoomScale
        width: parent.width * canvas.zoomScale

        antialiasing: true
        transformOrigin: Item.TopLeft

        function clear(){
            var ctx = getContext('2d');
            ctx.reset();
            canvas.requestPaint();
        }
        property int lastLineX: 0
        property int lastLineY: 0
        property int newLineX: 0
        property int newLineY: 0
        property int lineSize: 20
        function makeLine(type){
            console.log("makingLine");
            switch(type){
            case 0:
                newLineX-=lineSize
                canvas.requestPaint();
                break;
            case 1:
                newLineX+=lineSize
                canvas.requestPaint();
                break;
            case 2:
                newLineY-=lineSize
                canvas.requestPaint();
                break;
            case 3:
                newLineY+=lineSize
                canvas.requestPaint();
                break;
            }
            console.log(newLineX)
              console.log(lastLineX)
            console.log(newLineY)
              console.log(lastLineY)
        }

        MouseArea{
            id:area
            anchors.fill:parent
            onWheel:{
                if (wheel.modifiers & Qt.ControlModifier) {
                    if(wheel.angleDelta.y > 0){
                        canvas.zoomScale = canvas.zoomScale + 0.1
                    }else{
                        if(canvas.zoomScale <=0.1){
                            canvas.zoomScale = 0.1;
                        }else{
                            canvas.zoomScale = canvas.zoomScale - 0.1
                        }
                    }
                    console.log(canvas.zoomScale);
                 }
            }

            onClicked: {
                canvas.lastX = mouseX;
                canvas.lastY = mouseY;
            }
            onPositionChanged: {
                canvas.nextX = mouseX;
                canvas.nextY = mouseY;
                canvas.requestPaint();
            }
        }

        onPaint:{
            var ctx = getContext('2d');
            ctx.save();


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


            //code

            ctx.restore();
        }
    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:4}D{i:6}D{i:5}
}
##^##*/
