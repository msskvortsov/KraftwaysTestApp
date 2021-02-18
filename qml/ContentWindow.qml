import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

Window {
    id: root
    x: 0
    y: 0
    width: Screen.width/2
    height: Screen.height/2

    flags: Qt.FramelessWindowHint
    color: "blue"

    CustomTabView {
        anchors.fill: parent
        z: 2
    }

    Button {
        id: settingsButton
        width: 30
        height: 30
        z: 2
        icon {
            source: Qt.resolvedUrl("qrc:/icons/settings_icon.png")
            height: closeButton.height
            width: closeButton.width
        }

        anchors {
            left: parent.left
            bottom: closeButton.top
        }

        onClicked: {
            console.debug("There is no app settings yet")
        }
    }

    Button {
        id: closeButton
        width: 30
        height: 30
        z: 2
        icon {
            source: Qt.resolvedUrl("qrc:/icons/exit_icon.png")
            height: closeButton.height
            width: closeButton.width
        }

        anchors {
            left: parent.left
            bottom: parent.bottom
        }

        onClicked: {
            root.close()
        }
    }

    MouseArea {
           id: iMouseArea
           propagateComposedEvents: true
           property int prevX: 0
           property int prevY: 0
           anchors.fill: parent

           onPressed: {
               prevX = mouse.x;
               prevY = mouse.y
           }

           onPositionChanged:{
               var deltaX = mouse.x - prevX;
               root.x += deltaX;
               prevX = mouse.x - deltaX;

               var deltaY = mouse.y - prevY
               root.y += deltaY;
               prevY = mouse.y - deltaY;
           }
       }
}
