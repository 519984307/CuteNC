import QtQuick 2.15
import QtQuick.Window 2.15

import QtQuick.Extras 1.4

import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15

//3D
import QtQuick3D 1.15
import QtQuick.Shapes 1.15

import "qml/buttons"
Window {
    id: mainWindow
    width: 1200
    height: 800
    visible: true
    title: qsTr("CNC Controller - Szymon lach @ feew.dev")

    minimumWidth: 800
    minimumHeight: 500

    property int windowStatus: 0
    property int windowMargin: 10


    Rectangle {
        id: background
        color: "#00000000"
        border.color: "#000000"
        anchors.fill: parent
        visible: true
        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent

            Rectangle {
                id: content
                color: "#00000000"
                anchors.top: topBar.bottom
                anchors.fill: parent

                Rectangle {
                    id: contentPages
                    color: "#313131"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: topMenu.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    clip: true
                    z: 0

                    property variant pagesList: [
                        "home",
                        "editor",
                        "settings"
                    ];

                    // Set this property to another file name to change page
                    property string  currentPage : "home";
                    property bool didOnce: false
                    Repeater{
                        id:pagesLoader
                        model: contentPages.pagesList;
                        delegate: Loader {
                            active: false;
                            asynchronous: true;
                            anchors.fill: parent;
                            visible: (contentPages.currentPage === modelData);
                            source: "qml/pages/%1.qml".arg(modelData)
                            onVisibleChanged:      { loadIfNotLoaded(); }
                            Component.onCompleted: { loadIfNotLoaded(); }
                            onStatusChanged: {
                                    if (status == Loader.Ready) {
                                        if(contentPages.didOnce == false){
                                             contentPages.didOnce=true
                                            console.log("ready for backend - main.qml 85") //add splashscreen
                                            backend.startUp();
                                    }
                                }
                            }

                            function loadIfNotLoaded () {
                                // to load the file at first show
                                if (visible && !active) {
                                    active = true;
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: topMenu
                    x: -6
                    y: -63
                    height: 50
                    color: "#1f1f1f"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    z: 0
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    Column {
                        id: columnMenus1
                        width: 150
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                    }
                }

                Rectangle {
                    id: leftMenu
                    x: 0
                    y: -60
                    width: 70
                    color: "#1f1f1f"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    z: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0



                    Column {
                        id: columnMenus
                        width: 150
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 50

                        LeftMenuButton {
                            id: btnHome
                            width: leftMenu.width
                            height: 60
                            highlightedColorLeft: "#2f495f"
                            btnIcon: "res/images/home-solid.svg"
                            isActive: true
                            clip: true
                            textBtn: "Ekran powitalny"

                            onClicked: {
                                btnHome.isActive = true;
                                btnEditor.isActive = false;
                                btnSettings.isActive = false;
                                contentPages.currentPage = "home";
                            }


                        }

                        LeftMenuButton {
                            id: btnEditor
                            width: leftMenu.width
                            highlightedColorLeft: "#eb686d"
                            btnIcon: "res/images/edit-solid.svg"
                            textBtn: "Moje hasła"
                            clip: true
                            isActive: false
                            onClicked: {
                                btnHome.isActive = false;
                                btnEditor.isActive = true;
                                btnSettings.isActive = false;
                                contentPages.currentPage = "editor";
                            }

                        }

                    }

                    LeftMenuButton {
                        id: btnSettings
                        x: 0
                        y: 393
                        width: leftMenu.width
                        anchors.bottom: parent.bottom
                        highlightedColorLeft: "#ffffff"
                        clip: true
                        textBtn: "Ustawienia"
                        isActive: false
                        btnIcon: "res/images/cog-solid.svg"
                        anchors.bottomMargin: 25
                        onClicked: {
                            btnHome.isActive = false;
                            btnEditor.isActive = false;
                            btnSettings.isActive = true;
                            contentPages.currentPage = "settings";
                        }
                    }
                }

            }
        }

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.01;height:1200;width:1200}
}
##^##*/
