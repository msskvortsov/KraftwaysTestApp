pragma Singleton
import QtQuick 2.0

QtObject {
    id: defaultTheme

    property color mainBackground: "#2a5a7c"
    property color controlBackground: "#3a7baa"
    property color disabledControlBackground: "#3a43aa"
    property color activeControlBackground: "#38739e"
    property color controlBorderColor: "#ffffff"

    property color textColor: "#ffffff"
    property color disabledTextColor: "#c2c3c6"

}
