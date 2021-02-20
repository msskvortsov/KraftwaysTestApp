import QtQuick 2.0
import QtQuick.Window 2.11
import QtQuick.Controls 2.0

import "themes"
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
    property bool allowShowUp: true

    background: Rectangle {
        anchors.fill: parent
        color: root.down ? DefaultTheme.activeControlBackground : DefaultTheme.controlBackground
        radius: 5

        Rectangle {
            width: parent.radius
            height: parent.height > parent.radius ? parent.radius : parent.height
            color: parent.color
            anchors {
                top: parent.top
                left: parent.left
            }
        }

        Rectangle {
            width: parent.radius
            height: parent.height > parent.radius ? parent.radius : parent.height
            color: parent.color
            anchors {
                top: parent.top
                right: parent.right
            }
        }
    }

    onGlobalMousePosChanged: {
        if (!allowShowUp)
            return

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
                allowShowUp: true
            }
        },
        State {
            name: "Active"
            PropertyChanges {
                target: root
                visible: true
                height: implicitHeight
                allowShowUp: true
            }
        },
        State {
            name: "Hidden"
            PropertyChanges {
                target: root
                visible: false
                allowShowUp: false
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
