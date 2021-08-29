import QtQuick 2.15
import QtQuick.Window 2.15

import QtQuick.Extras 1.4

import QtQuick.Controls 2.15
import QtQuick3D 1.15
import QtQuick3D.Materials 1.15
import QtQuick3D.Effects 1.15
import QtQuick3D.Helpers 1.15

Rectangle{
    id: viewer
    width: 800
    height: 600

    QtObject{
        id: internal
        property int temp: 0
        property int tempX: 0
        property int previousMouseX: 0
        property int previousMouseY: 0
        property int tempY: 0
        property int currentZ: camera.position.z

        property bool isMovingVer: false
        property bool isMovingHor: false


        function mapValue(x, in_min, in_max, out_min, out_max){
              return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
        }


        function zoomInOut(mouseWheelPos){

            if(mouseWheelPos > temp){
                temp = mouseWheelPos
                console.log("oddalanie")
                console.log(mouseWheelPos)
                camera.position.z += 10

            }
            else if(mouseWheelPos < temp){
                temp = mouseWheelPos
                console.log("przyblizanie")
                console.log(mouseWheelPos)
                camera.position.z -= 10
            }
            else {
                temp = mouseWheelPos
            }


        }


        function cameraOrbitHor(mouseX){
            isMovingHor = true
            var isMovingLeft = false
            var treshold = 10

            console.log(mouseX)


            if(mouseX !== previousMouseX){

                if(mouseX > previousMouseX){
                    previousMouseX = mouseX
                    //idzie w prawo
                    console.log("prawo")
                    isMovingLeft = false
                }else if (mouseX < previousMouseX){
                    previousMouseX = mouseX
                    //idzie w lewo
                    console.log("lewo")
                    isMovingLeft = true

                }
                if(isMovingHor == true){

                    if(isMovingLeft == true){
                        camera.position.x += internal.mapValue(mouseX,0,viewer.width,0,10)
                    }else{
                        camera.position.x -= internal.mapValue(mouseX,0,viewer.width,0,10)
                    }
                    isMovingHor = false
                }
                 camera.lookAt(Qt.vector3d(0, 0, 0))
            }


        }

        function cameraOrbitVer(mouseY){
            isMovingVer = true
            var isMovingUp = false
            if(mouseY !== previousMouseY){
                if(mouseY > previousMouseY){
                    previousMouseY = mouseY
                    isMovingUp = true

                }else if (mouseY < previousMouseY){
                    previousMouseY = mouseY
                    isMovingUp = false

                }
                if(isMovingVer == true){
                    if(isMovingUp == true){
                        camera.position.y += internal.mapValue(mouseY,0,viewer.height,0,10)
                    }else{
                        camera.position.y -= internal.mapValue(mouseY,0,viewer.height,0,10)
                    }
                    isMovingVer = false
                }
            }

            camera.lookAt(Qt.vector3d(0, 0, 0))

        }


    }

    View3D {
        id: view3D
        anchors.fill: parent
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            backgroundMode: SceneEnvironment.Color
            depthPrePassEnabled: false
            clearColor: "#eaeaea"
            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.High
        }

        AxisHelper {
        }

        Node {
            id: scene
            DirectionalLight {
                id: directionalLight
                color: "#ffffff"
                castsShadow: false
            }


            PerspectiveCamera{
                id: camera
                x: 100
                y: 300
                fieldOfView: 60
                eulerRotation.x: -90
                eulerRotation.y: -90
                z: 100
            }



            Model {
                id: cubeModel
                source: "#Cube"
                DefaultMaterial {
                    id: cubeMaterial
                    diffuseColor: "#4aee45"
                }
                eulerRotation.x: 30
                materials: cubeMaterial
                eulerRotation.y: 45
            }

        }

    }
    WasdController {
        controlledObject: camera
        MouseArea{
            anchors.fill: parent
        }
    }

}
