import QtQuick 2.0
import QtQuick.Window 2.11
import QtQuick.Controls 2.0

// This is a button which appears at the top of the screen to open the minimized app

Button {
    id: root

    function checkIntersection(position) {
        return position.x >= showUpRect.x
                && position.y >= showUpRect.y
                && position.x <= showUpRect.width
                && position.y <= showUpRect.height;
    }

    property var showUpRect: Qt.rect(2*Screen.width/5, 0, 3*Screen.width/5, 150)
    property var globalMousePos: mouseGlobal.pos
    property bool cursorInsideShowUpRect: false

    onGlobalMousePosChanged: {
        cursorInsideShowUpRect = checkIntersection(globalMousePos);
        if (cursorInsideShowUpRect)
            state = "Active"
        else
            state = "Inactive"
    }

    states: [
        State {
            name: "Inactive"
            PropertyChanges {
                target: root
                visible: false
                height: 0
            }
        },
        State {
            name: "Active"
            PropertyChanges {
                target: root
                visible: true
                height: implicitHeight
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            duration: 300
            property: "height"
            easing.type: Easing.InOutQuad
        }
    }
}
