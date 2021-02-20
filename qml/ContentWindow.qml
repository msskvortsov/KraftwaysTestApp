import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

import "themes"

Window {
    id: root
    x: (Screen.width - width)/2
    y: 0
    width: Screen.width/2
    height: 0
    property int defaultHeight: Screen.height/2

    flags: Qt.FramelessWindowHint
    color: DefaultTheme.mainBackground

    CustomTabView {
        anchors.fill: parent
        anchors.margins: 5
        anchors.leftMargin: 10
        z: 2
        visible: !heightAnimation.running
    }

    Button {
        id: settingsButton
        width: 30
        height: 30
        z: 2
        display: AbstractButton.IconOnly
        icon {
            source: Qt.resolvedUrl("qrc:/icons/settings_icon.png")
            height: closeButton.height
            width: closeButton.width
            color: settingsButton.down ? DefaultTheme.disabledTextColor : DefaultTheme.textColor
        }

        anchors {
            left: parent.left
            bottom: closeButton.top
            bottomMargin: -5
            leftMargin: 3
        }
        background: Item{}

        onClicked: {
            console.debug("There is no app settings yet")
            settingsRotationAnimation.start()
        }

        PropertyAnimation {
            id: settingsRotationAnimation
            target: settingsButton
            property: "rotation"
            from: 0
            to: 360
            duration: 300
        }
    }

    Button {
        id: closeButton
        width: 30
        height: 30
        z: 2
        display: AbstractButton.IconOnly
        icon {
            source: Qt.resolvedUrl("qrc:/icons/exit_icon.png")
            height: closeButton.height
            width: closeButton.width
            color: closeButton.down ? DefaultTheme.disabledTextColor : DefaultTheme.textColor
        }
        hoverEnabled: true

        background: Item{}
        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 3
        }

        onClicked: root.hide()

        onHoveredChanged: {
            if (hovered) {
                rotationAnimation.from = 0
                rotationAnimation.to = 90
                rotationAnimation.start()
            } else {
                rotationAnimation.from = 90
                rotationAnimation.to = 0
                rotationAnimation.start()
            }
        }

        PropertyAnimation {
            id: rotationAnimation
            target: closeButton
            property: "rotation"
            duration: 150
        }
    }

    MouseArea {
        propagateComposedEvents: true
        property int prevX: 0
        property int prevY: 0
        anchors.fill: parent

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

    onVisibleChanged: {
        if (visible)
            height = defaultHeight
        else
            height = 0
    }

    Behavior on height {
        PropertyAnimation {
            id: heightAnimation
            duration: 300
            property: "height"
            easing.type: Easing.OutCirc
        }
    }
}
