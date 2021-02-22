import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import "../themes"

Button {
    id: root

    implicitWidth: 75
    implicitHeight: 25

    property bool shadowEnabled: true

    background: Rectangle {
        anchors.fill: parent
        color: root.down ? Theme.button.background.colorPressed : Theme.button.background.color
        radius: 3
        border {
            color: root.down ? Theme.button.boreder.colorPressed : Theme.button.boreder.color
            width: Theme.button.boreder.width
        }

        layer.enabled: !root.down && root.shadowEnabled
        layer.effect: DropShadow {
            transparentBorder: true
            verticalOffset: root.down ? 0 : 1
            horizontalOffset: root.down ? 0 : 1
            color: Theme.shadow.color
            spread: Theme.shadow.spread
        }

    }

    contentItem: Text {
        text: root.text
        font: root.font
        color: root.down ? Theme.button.text.colorPressed : Theme.button.text.color
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
