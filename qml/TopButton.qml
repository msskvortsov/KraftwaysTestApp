import QtQuick 2.0
import QtQuick.Window 2.11
import QtQuick.Controls 2.0

import "themes"
// This is a button which appears at the top of the screen to open the minimized app

Window {
    id: root
    width: button.implicitWidth
    height: button.implicitHeight
    x: (Screen.width - width)/2
    y: 0
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WA_TranslucentBackground | Qt.WindowStaysOnTopHint
    color: "#00000000"

    property alias implicitWidth: button.implicitWidth
    property alias implicitHeight: button.implicitHeight
    property alias icon: button.icon
    property alias display: button.display
    property alias state: button.state
    signal clicked()

    Button {
        id: button

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

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        background: Rectangle {
            anchors.fill: parent
            color: button.down ? DefaultTheme.activeControlBackground : DefaultTheme.controlBackground
            radius: 5

            // Можно вместо использования двух квадратиков, закрывающих скругленные углы сверху,
            // просто нарисовать свою форму через Canvas, как это сделано в SideTabViewTabs.qml
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

        onClicked: root.clicked()

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
                    target: button
                    visible: false
                    height: 0
                    allowShowUp: true
                }
            },
            State {
                name: "Active"
                PropertyChanges {
                    target: button
                    visible: true
                    height: implicitHeight
                    allowShowUp: true
                }
            },
            State {
                name: "Hidden"
                PropertyChanges {
                    target: button
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
}
