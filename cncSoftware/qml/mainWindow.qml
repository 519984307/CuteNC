import QtQuick 2.4
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

import QtQuick.Controls.Styles 1.3
import QtQuick.Window 2.2
import "../qml/buttons"
import "../qml/components"


Window {
    id: mainWindow
    visible: true
    title: qsTr("CNC Controller - Szymon lach @ feew.dev")

    minimumWidth: 800
    minimumHeight: 500

    Component.onCompleted: {
        getSettingsFile()
        mainWindow.visible = false;
    }


    property int windowStatus: 0
    property int windowMargin: 10
    property bool menuVisible: true
    property bool mouseInsideMenuBtn: false

    property var notificationsPool: []


    //Theme colors
    property color defaultColor
    property color grey
    property color darkColor
    property color accentColor
    property color onHoverColor
    property color onPressedColor
    property color backgroundColor
    property color borderColor
    property color textColorLight
    property color textColorDark

    property color onPressedBorderColor
    property color onHoverBorderColor

    //Notification popup
    property string notificationsPosition
    property color notificationBoxInfoColor
    property color notificationBoxWarnColor
    property color notificationBoxErrorColor
    property color notificationBoxDefaultColor
    property color notificationBoxTextColor
    property color notificationBoxConfirmColor
    property int notificationBoxRadius
    property string iconInfo
    property string iconConfirm
    property string iconWarn
    property string iconError
    property string iconDefault

    //Font
    property int fontPointSize
    property font fontFamily

    property int notificationsSpacing
    property int notificationsOffsetX
    property int notificationsOffsetY
    property bool showNotifications


    //Left side nav
    property color leftSideNavBackgroundColor
    property color leftSideNavAccentColor
    property int leftMenuMinimumWidth: 5
    property int leftMenuExtendedWidth: 75
    property int leftMenuExtendedFullyWidth: 190
    property int spacingBetweenBtns


    //Pages
    property color homePageBgColor
    property color editPageBgColor
    property color settingsPageBgColor
    property color aboutPageBgColor





    QtObject{
        id:internal
        property bool containsMouse: false
        property var showMenu:{
            if(btnCollapseLeftMenuMouseArea.pressed && leftMenu.width == leftMenuExtendedWidth){
                if(menuVisible === true){
                    menuVisible = false
                    leftMenuMouseArea.anchors.rightMargin = -5
                    descendMenu.running = true
                    rotateClose.running = true
                }else{
                    extendMenu.running = true
                    leftMenuMouseArea.anchors.rightMargin = 0
                    menuVisible = true

                    rotateOpen.running = true
                }
            }else if(btnCollapseLeftMenuMouseArea.pressed && leftMenu.width == leftMenuExtendedFullyWidth){
                waitBeforeDescendAnimationLeftMenu.stop()
                if(menuVisible === true){
                    menuVisible = false
                    leftMenuMouseArea.anchors.rightMargin = -5
                    descendMenu.running = true
                    rotateClose.running = true
                }else{
                    extendMenu.running = true
                    leftMenuMouseArea.anchors.rightMargin = 0
                    menuVisible = true

                    rotateOpen.running = true
                }
            }else if(btnCollapseLeftMenuMouseArea.pressed && leftMenu.width == leftMenuMinimumWidth){
                if(menuVisible === true){
                    menuVisible = false
                    leftMenuMouseArea.anchors.rightMargin = -5
                    descendMenu.running = true
                    rotateClose.running = true
                }else{
                    extendMenu.running = true
                    leftMenuMouseArea.anchors.rightMargin = 0
                    menuVisible = true

                    rotateOpen.running = true
                }
            }

        }
    }
    function getSettingsFile(){
        //Get Theme JSON

        var JsonStringTheme = backend.getJsonFile("settings.json");
        var JsonObjectTheme = JSON.parse(JsonStringTheme);

        mainWindow.width = JsonObjectTheme.width;
        mainWindow.height = JsonObjectTheme.height;

        //        "appName": "CuteNC",
        //        "defaultTheme": "LightTheme",
        //        "height": 1000,
        //        "title": "",
        //        "version": "v0.1.0",
        //        "website": "feew.dev",
        //        "width": 1200
    }

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile(backend.getSelectedTheme());
        var JsonObjectTheme = JSON.parse(JsonStringTheme);


        //Component theme - theme
        defaultColor = JsonObjectTheme.defaultColor;
        grey = JsonObjectTheme.grey;
        darkColor = JsonObjectTheme.darkColor
        accentColor = JsonObjectTheme.accentColor;
        onHoverColor = JsonObjectTheme.onHoverColor;
        onPressedColor = JsonObjectTheme.onPressedColor
        borderColor = JsonObjectTheme.borderColor;
        textColorLight = JsonObjectTheme.textColorLight
        textColorDark = JsonObjectTheme.textColorDark


        //Left side nav
        leftSideNavBackgroundColor = JsonObjectTheme.leftSideNav.backgroundColor
        leftSideNavAccentColor = JsonObjectTheme.leftSideNav.accentColor
        spacingBetweenBtns = JsonObjectTheme.menuButton.spacingBetweenBtns

        //Notifications
        showNotifications = JsonObjectTheme.notifications.enabled
        notificationsPosition = JsonObjectTheme.notifications.position
        notificationsSpacing = JsonObjectTheme.notifications.spacingBetween
        notificationsOffsetX = JsonObjectTheme.notifications.offsetX
        notificationsOffsetY = JsonObjectTheme.notifications.offsetY

        //Specified variables from JSON
        //retrieve values from JSON
        fontPointSize = JsonObjectTheme.fontPointSize;
        fontFamily = JsonObjectTheme.fontFamily;


        //pages
        homePageBgColor = JsonObjectTheme.pages.homePageBackgroundColor
        editPageBgColor = JsonObjectTheme.pages.editPageBackgroundColor
        settingsPageBgColor = JsonObjectTheme.pages.settingsPageBackgroundColor
        aboutPageBgColor = JsonObjectTheme.pages.aboutPageBackgroundColor

        backend.isQmlReady = true;
        mainWindow.visible = true;
    }

    property int newY

    function moveNotificationsDown(){
        if(notificationsPool[0].y !== undefined){
        notificationsPool[0].y = (notificationsOffsetY)
        }

        for(var i = 1; i <= notificationsPool.length-1; i++){
            notificationsPool[i].y = (notificationsPool[i-1].y + notificationsPool[i-1].height + notificationsSpacing)
        }
    }

    function removeElementFromNotificationsPool(v_element){
        for(var i = 0; i <= notificationsPool.length-1; i++){
            if(notificationsPool[i] === v_element){
                for(var j = i ; j <= notificationsPool.length-1;j++){
                  notificationsPool[j].position = notificationsPool[j].position-1
                }
                notificationsPool.splice(i,1)
                noNotifications--;
            }
        }

    }

    function newNotificationCreated(v_sprite){
        var previous = notificationsPool.length-1;
        if(notificationsPool.length != 0){
            v_sprite.y = notificationsPool[previous].y + notificationsPool[previous].height + notificationsSpacing
        }
        notificationsPool.push(v_sprite)
    }

    property int noNotifications: 0
    Connections{
        target:backend
        function onShowNotification(v_type, v_message){
            if(showNotifications){
                var component;
                var sprite;

                //moveNotificationsDown();

                component = Qt.createComponent("../qml/components/CuteNCNotification.qml");
                if( component.status !== Component.Ready )
                {
                    if( component.status === Component.Error )
                        console.debug("Error:"+ component.errorString() );
                    return; // or maybe throw
                }
                sprite = component.createObject(notificationArea);



                sprite.notifyType = v_type
                sprite.notifyMessage = v_message
                sprite.x = -(sprite.width*2)
                sprite.y = notificationsOffsetY

                sprite.position = noNotifications++
                sprite.loaded()

                newNotificationCreated(sprite)

            }
        }
        function onSignal_RefreshWidgets(){
            jsonSettings()
        }
    }

    PropertyAnimation{
        id: extendMenu
        target: leftMenu
        property: "width"
        to: mainWindow.leftMenuExtendedWidth
        duration: 200
        easing.type: Easing.InOutExpo
        alwaysRunToEnd: true

        onStarted: {
            coverRectangle.visible = false
            btnCollapseLeftMenuMouseArea.enabled = false
        }
        onStopped: {
            btnCollapseLeftMenuMouseArea.enabled = true
            waitBeforeDescendAnimation.start()
        }
    }

    Timer {
        id:waitBeforeDescendAnimationLeftMenu
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            descendLeftMenu.running = true
        }
    }

    Timer {
        id:waitBeforeDescendAnimation
        interval: 1500
        running: false
        repeat: false
        onTriggered: {
            descendMenuBtn.running = true
        }
    }

    PropertyAnimation{
        id: extendLeftMenu
        target: leftMenu
        property: "width"
        to: mainWindow.leftMenuExtendedFullyWidth
        duration: 200
        easing.type: Easing.InOutExpo
    }
    PropertyAnimation{
        id: descendLeftMenu
        target: leftMenu
        property: "width"
        to: mainWindow.leftMenuExtendedWidth
        duration: 200
        easing.type: Easing.InOutExpo
    }

    PropertyAnimation{
        id: descendMenu
        target: leftMenu
        property: "width"
        to: mainWindow.leftMenuMinimumWidth
        duration: 200
        easing.type: Easing.InOutExpo
        alwaysRunToEnd: true
        onStarted: {
            btnCollapseLeftMenuMouseArea.enabled = false
        }
        onStopped: {

            coverRectangle.visible = true
            btnCollapseLeftMenuMouseArea.enabled = true
            waitBeforeDescendAnimation.start()
        }

    }
    PropertyAnimation{
        id: extendMenuBtn
        target: btnCollapseLeftMenu
        property: "anchors.rightMargin"
        to: -(btnCollapseLeftMenu.width/2)+5
        duration: 300
        alwaysRunToEnd: true
        easing.type: Easing.OutExpo
    }
    PropertyAnimation{
        id: descendMenuBtn
        target: btnCollapseLeftMenu
        property: "anchors.rightMargin"
        to: btnCollapseLeftMenu.width
        duration: 300
        alwaysRunToEnd: true
        easing.type: Easing.InExpo
    }


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
                anchors.fill: parent

                Rectangle {
                    id: contentPages
                    color: defaultColor
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: topMenu.bottom
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    clip: true
                    z: 0

                    property variant pagesList: [
                        "home",
                        "editor",
                        "settings",
                        "about"
                    ];

                    //Set this property to another file name to change page
                    property string  currentPage : "home";
                    property bool didOnce: false
                    Repeater{
                        id:pagesLoader
                        anchors.fill: parent
                        model: contentPages.pagesList;
                        delegate: Loader {
                            id:loaderObj
                            active: false;
                            asynchronous: true;
                            anchors.fill: parent;
                            visible: (contentPages.currentPage === modelData);
                            source: "pages/%1.qml".arg(modelData)
                            onVisibleChanged:      { loadIfNotLoaded(); }
                            Component.onCompleted: { loadIfNotLoaded(); }
                            onStatusChanged: {
                                if (status == Loader.Ready) {
                                    if(contentPages.didOnce == false){
                                        contentPages.didOnce=true
                                        console.log("ready for backend") //add splashscreen
                                        backend.isQmlReady = true;
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

                Rectangle{
                    id:topMenu
                    height: 35
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    color: defaultColor
                    TopMenu {
                        id: topMenu1
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }
                }


                Rectangle {
                    id: leftMenu
                    x: 0
                    y: -60
                    width: mainWindow.leftMenuExtendedWidth
                    color: leftSideNavBackgroundColor
                    anchors.left: parent.left
                    anchors.top: topMenu.bottom
                    anchors.bottom: parent.bottom
                    z: 1
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0

                    Rectangle{
                        id: coverRectangle
                        anchors.fill: parent
                        color:parent.color
                        visible: false
                        z:1
                    }




                    MouseArea{
                        id:leftMenuMouseArea
                        anchors.fill: parent
                        anchors.rightMargin: 0
                        hoverEnabled: true
                        onContainsMouseChanged: {
                            if(leftMenuMouseArea.containsMouse){
                                extendMenuBtn.running = true

                            }else{
                                waitBeforeDescendAnimation.start()
                            }
                        }
                    }



                    Rectangle{
                        id: btnCollapseLeftMenu
                        color: grey
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: this.width
                        width: 50
                        height: this.width+20
                        radius: this.width
                        border.width: 0
                        z:-1

                        Label {
                            id: labelIcon
                            color: textColorDark
                            text: "\uE85A"
                            anchors.fill: parent

                            font.pointSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.leftMargin: btnCollapseLeftMenu.width/2+5

                            font.family: "fontello"
                            RotationAnimation {
                                id: rotateClose
                                target: labelIcon;
                                from: 0;
                                to: 180;
                                duration: 200
                                running: false
                            }
                            RotationAnimation {
                                id: rotateOpen
                                target: labelIcon;
                                from: 180;
                                to: 0;
                                duration: 200
                                running: false
                            }
                        }


                        property int previousY
                        property int previousX
                        property int maximumLeftMenuWidth: 200
                        MouseArea{
                            id:btnCollapseLeftMenuMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            states: State {
                                when: btnCollapseLeftMenuMouseArea.containsMouse
                                PropertyChanges {
                                    target: btnCollapseLeftMenu
                                    anchors.horizontalCenterOffset: parent.width/2
                                }
                            }
                        }
                    }

                    Column {
                        id: columnMenus
                        width: 150
                        spacing: spacingBetweenBtns
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 25

                        LeftMenuButton {
                            id: btnHome

                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            btnIcon: "\uE81F"
                            isActive: true
                            clip: true
                            textBtn: "Home"
                            pageColor: mainWindow.homePageBgColor

                            onClicked: {
                                btnHome.isActive = true;
                                btnEditor.isActive = false;
                                btnSettings.isActive = false;
                                btnAbout.isActive = false;
                                contentPages.currentPage = "home";
                            }
                        }

                        LeftMenuButton {
                            id: btnEditor
                            width: leftMenu.width
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: btnHome.bottom
                            anchors.topMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            btnIcon: "\uf044"
                            textBtn: "Layout Editor"
                            clip: true
                            isActive: false
                            pageColor: mainWindow.editPageBgColor
                            onClicked: {
                                btnHome.isActive = false;
                                btnEditor.isActive = true;
                                btnSettings.isActive = false;
                                btnAbout.isActive = false;
                                contentPages.currentPage = "editor";
                            }

                        }

                    }

                    LeftMenuButton {
                        id: btnSettings
                        x: 0
                        y: 393
                        width: leftMenu.width
                        anchors.bottom: btnAbout.top
                        anchors.bottomMargin: 0
                        clip: true
                        textBtn: "Settings"
                        isActive: false
                        btnIcon: "\uE841"
                        pageColor: mainWindow.settingsPageBgColor
                        onClicked: {
                            btnHome.isActive = false;
                            btnEditor.isActive = false;
                            btnSettings.isActive = true;
                            btnAbout.isActive = false;
                            contentPages.currentPage = "settings";
                        }
                    }

                    LeftMenuButton {
                        id: btnAbout
                        x: 0
                        y: 608
                        width: leftMenu.width
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        clip: true
                        textBtn: "About"
                        isActive: false
                        btnIcon: "\uE81D"
                        pageColor: mainWindow.aboutPageBgColor

                        onClicked: {
                            btnHome.isActive = false;
                            btnEditor.isActive = false;
                            btnSettings.isActive = false;
                            btnAbout.isActive = true;
                            contentPages.currentPage = "about";
                        }
                    }
                }




                Rectangle {
                    id: notificationArea
                    height: 0
                    visible: true
                    color: "transparent"
                    clip: false
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: topMenu.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                }

            }
        }

    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.66;height:800;width:1200}D{i:1}D{i:2}D{i:3}D{i:4}D{i:5}D{i:6}
D{i:7}D{i:8}D{i:9}D{i:10}D{i:15}D{i:14}D{i:18}D{i:17}D{i:20}D{i:21}D{i:24}D{i:25}
D{i:23}D{i:26}D{i:22}D{i:30}D{i:31}D{i:29}D{i:32}D{i:33}D{i:19}D{i:34}D{i:13}D{i:12}
D{i:11}
}
##^##*/
