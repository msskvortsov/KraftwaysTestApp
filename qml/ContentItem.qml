import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

import "themes"

Item {
    id: root

    signal hide()

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
            color: settingsButton.down ? DefaultTheme.textColorDisabled : DefaultTheme.textColor
        }

        anchors {
            left: parent.left
            bottom: closeButton.top
            bottomMargin: -5
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
            color: closeButton.down ? DefaultTheme.textColorDisabled : DefaultTheme.textColor
        }
        hoverEnabled: true

        background: Item{}
        anchors {
            left: parent.left
            bottom: parent.bottom
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
}
