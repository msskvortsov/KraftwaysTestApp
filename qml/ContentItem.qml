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
        visible: !heightAnimation.running
    }

    Button {
        id: settingsButton
        width: 30
        height: 30
        display: AbstractButton.IconOnly

        icon {
            source: Theme.icons.settingsIcon
            height: settingsButton.height
            color: settingsButton.down ? Theme.button.icon.colorPressed : Theme.button.icon.color
        }

        anchors {
            left: parent.left
            bottom: closeButton.top
        }

        background: Item{}

        onClicked: {
            console.debug("There is no app settings yet")
            settingsButtonRotationAnimation.start()
        }

        PropertyAnimation {
            id: settingsButtonRotationAnimation
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
        display: AbstractButton.IconOnly
        icon {
            source: Theme.icons.closeIcon
            height: closeButton.height
            color:  settingsButton.down ? Theme.button.icon.colorPressed : Theme.button.icon.color
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
                closeButtonRotationAnimation.from = 0
                closeButtonRotationAnimation.to = 90
                closeButtonRotationAnimation.start()
            } else {
                closeButtonRotationAnimation.from = 90
                closeButtonRotationAnimation.to = 0
                closeButtonRotationAnimation.start()
            }
        }

        PropertyAnimation {
            id: closeButtonRotationAnimation
            target: closeButton
            property: "rotation"
            duration: 150
        }
    }
}
