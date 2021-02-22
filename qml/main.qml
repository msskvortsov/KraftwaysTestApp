import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.3
import Qt.labs.platform 1.1

import "themes"

Window {
    id: root

    x: (Screen.width - width)/2
    y: 0
    width: defaultWidth
    height: visible ? defaultHeight : 0
    readonly property int defaultWidth: Screen.width/2
    readonly property int defaultHeight: Screen.height/2

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint
    color: Theme.window.background

    onVisibleChanged: {
        if (visible)
            topButton.hide()
        else
            topButton.show()
    }

    Component.onCompleted: showMainWindowAction.trigger()

    Behavior on height {
        PropertyAnimation {
            id: heightAnimation
            duration: 300
            property: "height"
            easing.type: Easing.OutCirc
        }
    }

    Action {
        id: showMainWindowAction
        onTriggered: root.showNormal()
    }

    TopButton {
        id: topButton
        icon {
            height: topButton.implicitHeight
            source: Theme.icons.topButton
            color: topButton.down ? Theme.button.icon.colorPressed : Theme.button.icon.color
        }

        display: AbstractButton.IconOnly

        implicitWidth: 75
        implicitHeight: 40

        onClicked: showMainWindowAction.trigger()
    }

    ContentItem {
        id: contentItem
        anchors.fill: parent
        z: Theme.layers.basic

        onHide: root.hide()
    }

    SystemTrayIcon {
        id: trayIcon
        visible: true
        icon.source: Theme.icons.trayIcon

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
        z: Theme.layers.zero

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
