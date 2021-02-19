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
        color: root.down ? DefaultTheme.activeControlBackground : DefaultTheme.controlBackground
        radius: 3
        border {
            color: root.down ? DefaultTheme.disabledTextColor : DefaultTheme.textColor
            width: 1
        }

        layer.enabled: !root.down && root.shadowEnabled
        layer.effect: DropShadow {
            transparentBorder: true
            verticalOffset: root.down ? 0 : 1
            horizontalOffset: root.down ? 0 : 1
            color: "#666666"
            spread: 0.5
        }

    }

    contentItem: Text {
        text: root.text
        font: root.font
        color: root.down ? DefaultTheme.disabledTextColor : DefaultTheme.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
