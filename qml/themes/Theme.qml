pragma Singleton
import QtQuick 2.0

Item {
    id: root

    objectName: "Theme"

    // Common parameters
    property color textColor: "#ffffff"
    property color textColorDisabled: "#666666"

    property string fontFamily: "Arial, sans-serif"
    property int fontPixelSize: 12

    property color transparent: "#00000000"

    // Z layers
    property QtObject layers: QtObject {
        property int zero: 0
        property int basic: 1
    }

    // Icon paths
    property QtObject icons: QtObject {
        property string topButton: Qt.resolvedUrl("qrc:/icons/eye.png")
        property string trayIcon: Qt.resolvedUrl("qrc:/icons/app_icon.ico")
        property string closeIcon: Qt.resolvedUrl("qrc:/icons/exit_icon.png")
        property string settingsIcon: Qt.resolvedUrl("qrc:/icons/settings_icon.png")
    }

    // Window
    property QtObject window: QtObject {
        property color background:"#2a5a7c"
    }

    // Button
    property QtObject button: QtObject {
        id: buttonStyle

        property QtObject background: QtObject {
            property color color: "#3a7baa"
            property color colorPressed: "#38739e"
        }

        property QtObject border: QtObject {
            property int width: 1
            property color color: buttonStyle.text.color
            property color colorPressed: buttonStyle.text.colorPressed
        }

        property QtObject text: QtObject {
            property color color: root.textColor
            property color colorPressed: root.textColorDisabled
        }

        property QtObject font: QtObject {
            property string family: root.fontFamily
            property int pixelSize: root.fontPixelSize
        }

        property QtObject shadow: QtObject {
            property color color: "#666666"
            property real spread: 0.4
        }

        property QtObject icon: QtObject {
            property color color: buttonStyle.text.color
            property color colorPressed: buttonStyle.text.colorPressed
        }
    }

    // Tab view tabs
    property QtObject tabViewTab: QtObject {
        id: tabViewTabStyle
        property QtObject background: QtObject {
            property color color: "#3a7baa"
            property color active: "#489edb"
            property color disabled: "#38739e"
        }

        property QtObject border: QtObject {
            property color color: root.window.background
            property int width: 1
        }

        property QtObject text: QtObject {
            property color color: root.textColor
            property color colorPressed: root.textColorDisabled
            property string align: "left"
        }

        property QtObject font: QtObject {
            property string family: root.fontFamily
            property int pixelSize: root.fontPixelSize
        }
    }
}
