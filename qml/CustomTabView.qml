import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    Column {
        id: tabNamesColumn
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        Repeater {
            model: view.count
            delegate: Rectangle {
                width: 30
                height: 75
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: view.getTab(index).title
                    rotation: 270
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: view.currentIndex = index
                }
            }
        }
    }

    TabView {
        id: view
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: tabNamesColumn.right
        }
        style: TabViewStyle{
            tab: Item {}
        }

        Tab {
            title: "Карта"
            Image {
                anchors.fill: parent
                source: "qrc:/images/map.jpg"
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
            }
        }

        Tab {
            title: "Картинка"
            Image {
                anchors.fill: parent
                source: "qrc:/images/image.jpg"
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
            }
        }
        Tab {
            title: "Факториал"
            Rectangle {
                anchors.fill: parent
                color: "gray"
                Column {
                    anchors.centerIn: parent
                    spacing: 5
                    Row {
                        spacing: 5
                        TextField {
                            id: factorialTextEdit
                            width: 125
                            height: 20
                            enabled: !factorialCounter.isRunning
                            placeholderText: qsTr("Enter int value")
                        }
                        Button {
                            z: 2
                            height: 20
                            width: 25
                            text: qsTr("Go!")
                            onClicked: factorialCounter.setValue(factorialTextEdit.text)
                        }
                    }
                    Text {
                        width: 150
                        height: 20
                        text: factorialCounter.result
                    }
                }
            }
        }
    }
}
