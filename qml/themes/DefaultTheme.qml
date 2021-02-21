pragma Singleton
import QtQuick 2.0

QtObject {
    id: defaultTheme

    property color backgroundApp: "#2a5a7c"
    property color backgroundComponent: "#3a7baa"
    property color backgroundComponentDisabled: "#38739e"
    property color backgroundComponentActive: "#489edb"

    property color shadowColor: "#666666"
    property real shadowSpread: 0.4

    property color textColor: "#ffffff"
    property color textColorDisabled: "#666666"
    property string fontFamily: "Arial, sans-serif"
    property int fontPixelSize: 12

    property color borderColor: "#ffffff"
    property color borderColorDisabled: "#666666"
    property int borderWidth: 1

}
