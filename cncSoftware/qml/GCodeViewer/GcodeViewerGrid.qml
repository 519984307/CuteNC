import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: axisGrid_obj

    property alias gridColor: gridMaterial.diffuseColor
    property alias gridOpacity: gridMaterial.opacity
    property alias enableXZGrid: gridXZ.visible
    property bool enableAxisLines: true

    // Axis Lines
    Model {
        id: xAxis
        source: "#Cube"
        position: Qt.vector3d(5000, 0, 0)
        scale: Qt.vector3d(100, .05, .05)
        visible: enableAxisLines

        materials: DefaultMaterial {
            lighting: DefaultMaterial.NoLighting
            diffuseColor: "red"
        }
    }

    Model {
        id: zAxis
        source: "#Cube"
        position: Qt.vector3d(0, 5000, 0)
        scale: Qt.vector3d(0.05, 100, 0.05)
        visible: enableAxisLines
        materials: DefaultMaterial {
            lighting: DefaultMaterial.NoLighting
            diffuseColor: "blue"
        }
    }

    Model {
        id: yAxis
        source: "#Cube"
        position: Qt.vector3d(0, 0, 5000)
        scale: Qt.vector3d(0.05, 0.05, 100)
        visible: enableAxisLines
        materials: DefaultMaterial {
            lighting: DefaultMaterial.NoLighting
            diffuseColor: "green"
        }
    }

    // Grid Lines
    DefaultMaterial {
        id: gridMaterial
        lighting: DefaultMaterial.NoLighting
        opacity: 0.5
        diffuseColor: Qt.rgba(0.8, 0.8, 0.8, 1)
    }

    Model {
        id: gridXZ
        source: "meshes/axisGrid.mesh"
        scale: Qt.vector3d(100, 100, 100)
        materials: [
            gridMaterial
        ]
    }

}
