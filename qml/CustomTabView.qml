import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import "styled_components"
import "themes"

Item {
    SideTabViewTabs {
        id: tabViewTabs
        view: tabView
    }

    TabView {
        id: tabView
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: tabViewTabs.right
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
                color: "light blue"
                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Row {
                        spacing: 5
                        TextField {
                            id: factorialTextEdit
                            width: 135
                            height: 30
                            enabled: !factorialCounter.isRunning
                            validator: IntValidator { bottom: 0; top: 25 }
                            placeholderText: qsTr("Number from 0 to 25")
                            font {
                                pixelSize: Theme.font.pixelSize
                                family: Theme.font.family
                            }
                        }
                        StyledButton {
                            height: 30
                            width: 35
                            text: qsTr("Go!")
                            onClicked: factorialCounter.setValue(factorialTextEdit.text)
                        }
                    }

                    Item {
                        width: 150
                        height: 15
                        // text with factorial result
                        Text {
                            anchors.fill: parent
                            text: factorialCounter.result
                            font.pixelSize: 12
                            visible: !factorialCounter.isRunning
                        }
                        // factorial counter busy indicator
                        BusyIndicator {
                            visible: factorialCounter.isRunning
                            anchors.left: parent.left
                            height: parent.height
                            width: height
                        }
                    }
                }
            }
        }
    }
}
