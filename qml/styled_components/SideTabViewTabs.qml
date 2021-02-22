import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQml 2.0

import "../themes"

Column {
    id: root

    property var view

    property int tabWidth: 0
    property int tabHeight: 0

    spacing: -5

    Repeater {
        id: tabsRepeater

        model: view.count

        delegate: Button {
            id: repeaterDelegate

            implicitWidth: 25
            implicitHeight: 105

            text: view.getTab(index).title

            onDownChanged: {
                canvas.requestPaint()
            }

            background: Canvas {
                id: canvas
                anchors.fill: parent

                antialiasing: true

                property int radius: 3
                property int viewCurrentIndex: root.view.currentIndex

                property real tabAngle: Math.PI/8

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = index == view.currentIndex
                            ? Theme.tabViewTab.background.active
                            : Theme.tabViewTab.background.color
                    ctx.strokeStyle = Theme.tabViewTab.border.color

                    ctx.lineWidth = Theme.tabViewTab.border.width

                    ctx.beginPath()
                    ctx.moveTo(width, height)
                    // Draw sloped line
                    ctx.lineTo(radius, height - (width/Math.cos(tabAngle) - radius))
                    // Smoothly go to the vertical line using bezier curve
                    ctx.bezierCurveTo(radius, height - (width/Math.cos(tabAngle) - radius),
                                      0, height - (width/Math.cos(tabAngle)),
                                      0, height - (width/Math.cos(tabAngle) + radius))
                    ctx.lineTo(0, radius)
                    // Draw rounded corner
                    ctx.arcTo(0, 0, radius, 0, radius)
                    // Finishing with straight lines
                    ctx.lineTo(width, 0)
                    ctx.lineTo(width, height)
                    ctx.fill()
                    ctx.stroke()

                    // Setting text params
                    ctx.save()
                    ctx.font = Theme.tabViewTab.font.pixelSize + "px " + Theme.tabViewTab.font.family
                    ctx.fillStyle = repeaterDelegate.down
                            ? Theme.tabViewTab.text.colorPressed
                            : Theme.tabViewTab.text.color
                    ctx.textAlign = Theme.tabViewTab.text.align

                    var textWidth = ctx.measureText(repeaterDelegate.text).width
                    var textBaseline = (width + repeaterDelegate.font.pixelSize)/2

                    // Drawing text rotated by -90 dergees
                    ctx.translate(textBaseline, height)
                    ctx.rotate(-Math.PI/2)
                    ctx.fillText(repeaterDelegate.text,
                                 (width/Math.cos(tabAngle))/2 + (height - textWidth)/2,
                                 - width/2 + repeaterDelegate.font.pixelSize)
                    ctx.restore()
                }

                onViewCurrentIndexChanged: requestPaint()
                Component.onCompleted: requestPaint()
            }

            contentItem: Item {}

            onClicked: view.currentIndex = index
        }
    }
}
