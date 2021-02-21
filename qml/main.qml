import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import Qt.labs.platform 1.1

import "themes"

Window {
    id: root

    x: (Screen.width - width)/2
    y: 0
    width: Screen.width/2
    height: 0
    property int defaultHeight: Screen.height/2

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint
    color: DefaultTheme.mainBackground

    onVisibleChanged: {
        if (visible) {
            height = defaultHeight
            topButton.state = "Hidden"
        } else {
            height = 0
            topButton.state = "Inactive"
        }
    }

    Component.onCompleted: showMainWindowAction.trigger()

    Action {
        id: showMainWindowAction
        onTriggered: root.showNormal()
    }

    Component.onCompleted: {
        contentWindow.showNormal()
    }

    TopButton {
        id: topButton
        icon {
            height: topButton.implicitHeight
            source: Qt.resolvedUrl("qrc:/icons/eye.png")
            color: DefaultTheme.textColor
        }

        display: AbstractButton.IconOnly

        implicitWidth: 75
        implicitHeight: 40

        state: "Inactive"

        onClicked: showMainWindowAction.trigger()
    }

    ContentItem {
        id: contentItem
        anchors.fill: parent
        z: 2

        onHide: root.hide()
    }

    Behavior on height {
        PropertyAnimation {
            id: heightAnimation
            duration: 300
            property: "height"
            easing.type: Easing.OutCirc
        }
    }

    SystemTrayIcon {
        id: trayIcon
        visible: true
        icon.source: "qrc:/icons/app_icon.ico"

        menu: Menu {
            MenuItem {
                text: qsTr("Open")
                onTriggered: showMainWindowAction.trigger()
            }
            MenuSeparator{}
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }

        }

        tooltip: qsTr("Kraftways test app")

        onActivated: {
            if (reason == SystemTrayIcon.DoubleClick)
                showMainWindowAction.trigger()
        }
    }

    MouseArea {
        propagateComposedEvents: true
        property int prevX: 0
        property int prevY: 0
        anchors.fill: parent
        z: 0

        onPressed: {
            prevX = mouse.x;
            prevY = mouse.y
        }

        onPositionChanged:{
            var deltaX = mouse.x - prevX
            prevX = mouse.x - deltaX

            var deltaY = mouse.y - prevY
            prevY = mouse.y - deltaY

            root.setGeometry(root.x + deltaX, root.y + deltaY, root.width, root.height)
        }
    }
}
