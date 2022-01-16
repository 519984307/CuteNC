import QtQuick 2.0

Item {
    id:visualizer2DRoot


    Canvas {
        id:canvas
        anchors.fill: parent
        onPaint: {
            var ctx = canvas.getContext('2d');
        }


        function drawLine(from_x, from_y, to_x, to_y){
           var ctx = document.getElementById('canvas').getContext('2d');

           ctx.strokeStyle = "red"


           ctx.beginPath()
           ctx.moveTo(from_x,from_y)
           ctx.lineTo(to_x,to_y)


           ctx.stroke()
        }




        Connections{
            target:axisController
            function onSingal_DrawLine(from_x, from_y, to_x, to_y){
                canvas.drawLine(from_x, from_y, to_x, to_y);

            }
        }

    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/
