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
        color: root.down ? DefaultTheme.backgroundComponentActive : DefaultTheme.backgroundComponent
        radius: 3
        border {
            color: root.down ? DefaultTheme.borderColorDisabled : DefaultTheme.borderColor
            width: DefaultTheme.borderWidth
        }

        layer.enabled: !root.down && root.shadowEnabled
        layer.effect: DropShadow {
            transparentBorder: true
            verticalOffset: root.down ? 0 : 1
            horizontalOffset: root.down ? 0 : 1
            color: DefaultTheme.shadowColor
            spread: DefaultTheme.shadowSpread
        }

    }

    contentItem: Text {
        text: root.text
        font: root.font
        color: root.down ? DefaultTheme.textColorDisabled : DefaultTheme.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
