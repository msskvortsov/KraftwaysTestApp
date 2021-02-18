import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.0
import Qt.labs.platform 1.1

Window {
    id: root

    width: 150
    height: 65
    x: (Screen.width - width)/2
    y: topButton.y
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WA_TranslucentBackground
    color: "#00000000"

    TopButton {
        id: topButton
        text: "Open main window"
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        state: "Inactive"

        onClicked: contentWindow.showNormal()
    }

    ContentWindow {
        id: contentWindow
    }

    SystemTrayIcon {
        visible: true
        icon.source: "qrc:/icons/settings_icon.png"

        menu: Menu {
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }

        tooltip: qsTr("Kraftways test app")
    }
}
