import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.0
import Qt.labs.platform 1.1

import "themes"

Window {
    id: root

    width: 75
    height: 40
    x: (Screen.width - width)/2
    y: topButton.y
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WA_TranslucentBackground | Qt.WindowStaysOnTopHint
    color: "#00000000"

    TopButton {
        id: topButton
        icon {
            height: parent.height
            source: Qt.resolvedUrl("qrc:/icons/eye.png")
            color: DefaultTheme.textColor
        }

        display: AbstractButton.IconOnly

        implicitWidth: 75
        implicitHeight: 40
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        state: "Inactive"

        onClicked: {
            contentWindow.showNormal()
        }
    }

    ContentWindow {
        id: contentWindow

        onVisibleChanged: {
            if (visible)
                topButton.state = "Hidden"
            else
                topButton.state = "Inactive"
        }
    }

    SystemTrayIcon {
        id: trayIcon
        visible: true
        icon.source: "qrc:/icons/settings_icon.png"

        menu: Menu {
            MenuItem {
                text: qsTr("Open")
                onTriggered: contentWindow.showNormal()
            }
            MenuSeparator{}
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }

        }

        tooltip: qsTr("Kraftways test app")
    }
}
