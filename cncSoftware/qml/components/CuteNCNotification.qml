import QtQuick 2.0
import "../buttons"
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
Item {
    id: notificationRoot
    height: notificationMessage.height+30
    width: internal.dynamicWidth

    Connections{
        target: backend
        function onRefreshWidgets(){
            jsonSettings()
        }
    }

    property string notifyMessage: "Empty"
    property string notifyType
    property var position


    property int textSize:20
    property int notifyDestroyAfter:2000
    property int notifyBoxRadius:5

    //Info
    property int notifyDestroyAfterInfo
    property string infoIcon
    property color infoTextColor
    property color infoColor
    property color infoIconColor
    //Confirm
    property int notifyDestroyAfterConfirm
    property string confirmIcon
    property color confirmTextColor
    property color confirmColor
    property color confirmIconColor
    //Warn
    property int notifyDestroyAfterWarn
    property string warnIcon
    property color warnTextColor
    property color warnColor
    property color warnIconColor
    //Error
    property int notifyDestroyAfterError
    property string errorIcon
    property color errorTextColor
    property color errorColor
    property color errorIconColor
    //Default
    property int notifyDestroyAfterDefault
    property string defaultIcon
    property color defaultTextColor
    property color defaultColor
    property color defaultIconColor

    function jsonSettings(){
        //Get Theme JSON
        var JsonStringTheme = backend.getJsonFile("NotificationsSettings.json");
        var JsonObjectTheme = JSON.parse(JsonStringTheme);


        textSize = JsonObjectTheme.fontPointSize
        notifyBoxRadius = JsonObjectTheme.boxRadius


        notifyDestroyAfterInfo = JsonObjectTheme.notificationInfo.destroyAfter
        infoIcon = JsonObjectTheme.notificationInfo.icon
        infoTextColor = JsonObjectTheme.notificationInfo.textColor
        infoColor = JsonObjectTheme.notificationInfo.color
        infoIconColor = JsonObjectTheme.notificationInfo.iconColor

        //Info
        notifyDestroyAfterConfirm = JsonObjectTheme.notificationConfirm.destroyAfter
        confirmIcon = JsonObjectTheme.notificationConfirm.icon
        confirmTextColor = JsonObjectTheme.notificationConfirm.textColor
        confirmColor = JsonObjectTheme.notificationConfirm.color
        confirmIconColor = JsonObjectTheme.notificationConfirm.iconColor

        //Warn
        notifyDestroyAfterWarn = JsonObjectTheme.notificationWarn.destroyAfter
        warnIcon = JsonObjectTheme.notificationWarn.icon
        warnTextColor = JsonObjectTheme.notificationWarn.textColor
        warnColor = JsonObjectTheme.notificationWarn.color
        warnIconColor = JsonObjectTheme.notificationWarn.iconColor

        //Error
        notifyDestroyAfterError = JsonObjectTheme.notificationError.destroyAfter
        errorIcon = JsonObjectTheme.notificationError.icon
        errorTextColor = JsonObjectTheme.notificationError.textColor
        errorColor = JsonObjectTheme.notificationError.color
        errorIconColor = JsonObjectTheme.notificationError.iconColor

        //Default
        notifyDestroyAfterDefault = JsonObjectTheme.notificationDefault.destroyAfter
        defaultIcon = JsonObjectTheme.notificationDefault.icon
        defaultTextColor = JsonObjectTheme.notificationDefault.textColor
        defaultColor = JsonObjectTheme.notificationDefault.color
        defaultIconColor = JsonObjectTheme.notificationDefault.iconColor

    }

    function loaded(){
        notificationRoot.x = -(notificationRoot.parent.x)-notificationRoot.width
        showNotification.running = true

        if(notifyType == "info"){
            notifyDestroyAfter = notifyDestroyAfterInfo
            notificationMessageTypeIcon.text = infoIcon
            notificationMessage.color = notificationRoot.infoTextColor
            notificationRectangle.color = notificationRoot.infoColor
            notificationMessageTypeIcon.color = notificationRoot.infoIconColor

        }else if(notifyType == "warn"){
            notifyDestroyAfter = notifyDestroyAfterWarn
            notificationMessageTypeIcon.text = warnIcon
            notificationMessage.color = notificationRoot.warnTextColor
            notificationRectangle.color = notificationRoot.warnColor
            notificationMessageTypeIcon.color = notificationRoot.warnIconColor

        }else if(notifyType == "error"){
            notifyDestroyAfter = notifyDestroyAfterError
            notificationMessageTypeIcon.text = errorIcon
            notificationMessage.color = notificationRoot.errorTextColor
            notificationRectangle.color = notificationRoot.errorColor
            notificationMessageTypeIcon.color = notificationRoot.errorIconColor

        }else if(notifyType == "confirm"){
            notifyDestroyAfter = notifyDestroyAfterConfirm
            notificationMessageTypeIcon.text = confirmIcon
            notificationMessage.color = notificationRoot.confirmTextColor
            notificationRectangle.color = notificationRoot.confirmColor
            notificationMessageTypeIcon.color = notificationRoot.confirmIconColor

        }else{
            notifyDestroyAfter = notifyDestroyAfterDefault
            notificationMessageTypeIcon.text = defaultIcon
            notificationMessage.color = notificationRoot.defaultTextColor
            notificationRectangle.color = notificationRoot.defaultColor
            notificationMessageTypeIcon.color = notificationRoot.defaultIconColor

        }

        if(notifyDestroyAfter > 0){
            timebomb.interval = notifyDestroyAfter
            timebomb.start() //to destroy notification after set time = notifyDestroyAfter
            progressBar.visible = true
            progressBarAnimation.running = true
        }else{
            rectangle.anchors.bottom = notificationRectangle.bottom
            progressBar.visible = false
        }

    }

    function moveNotificationToY(v_moveToY){
        moveToY = v_moveToY
        moveUpDownSmoothly.running = true
    }



    QtObject{
        id: internal
        property var dynamicWidth:{

            return notificationMessage.contentWidth+100

        }
    }


    Timer{
        id:timebomb
        running: false
        repeat: false
        onTriggered: {
            hideNotification.running = true

        }
    }


    property int moveToY

    PropertyAnimation{
        id: moveUpDownSmoothly
        target: notificationRoot
        property: "y"
        to: moveToY
        duration: 10
        easing.type: Easing.OutExpo

    }

    PropertyAnimation{
        id: showNotification
        target: notificationRoot
        property: "x"
        to: 10
        duration: 300
        easing.type: Easing.OutExpo

    }
    PropertyAnimation{
        id: hideNotification
        target: notificationRoot
        property: "x"
        to: -(notificationRoot.parent.x)-notificationRoot.width
        duration: 200
        easing.type: Easing.OutExpo
        onStopped: {
            mainWindow.moveNotificationsDown()
            notificationRoot.destroy()
        }
        onStarted: {
            mainWindow.removeElementFromNotificationsPool(notificationRoot)
        }



    }

    PropertyAnimation{
        id: descendMenuBtn
        target: btnCollapseLeftMenu
        property: "anchors.rightMargin"
        to: btnCollapseLeftMenu.width
        duration: 300
        easing.type: Easing.InExpo
    }

    Rectangle{
        id: notificationRectangle
        anchors.fill: parent
        radius: notifyBoxRadius

        clip:true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: notificationRectangle.width
                height: notificationRectangle.height
                Rectangle {
                    anchors.centerIn: parent
                    width: notificationRectangle.width
                    height: notificationRectangle.height
                    radius: notifyBoxRadius
                }
            }
        }

        ProgressBar {
            id: progressBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            from: 0
            to: 100
        }
        PropertyAnimation{
            id:progressBarAnimation
            target: progressBar
            property: "value"
            to: 100
            duration: notifyDestroyAfter-100
        }

        Rectangle {
            id: rectangle
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: progressBar.top
            anchors.bottomMargin: 0

            Label{
                id:notificationMessageTypeIcon
                x: 5
                y: 16
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                font.family: "fontello"
                font.pointSize: 16

            }

            Label{
                id:notificationMessage
                x: 10
                y: 17
                text: notifyMessage
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: notificationMessageTypeIcon.right
                anchors.right: notificationDestroyMessage.left
                anchors.rightMargin: 30
                anchors.leftMargin: 15
                font.pointSize: notificationRoot.textSize
            }

            ImageButton{
                id: notificationDestroyMessage
                x: 175
                y: 15
                width: 24
                height: this.width
                text: "\uf120"
                fontPointSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                borderVisible: false
                borderRadius: this.width
                btnIcon: "\uE801"
                onClicked: hideNotification.running = true
            }
        }
    }
    Component.onCompleted: {
        jsonSettings()
        //mainWindow.moveNotificationsDown(notificationRoot)
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:50;width:200}
}
##^##*/
