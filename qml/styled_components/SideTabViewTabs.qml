import QtQuick 2.0
import QtQuick.Controls 2.2

import "../themes"

Column {
    id: root

    property var align: Qt.AlignTop
    property var view

    property int tabWidth: 0
    property int tabHeight: 0

    spacing: -5


    Repeater {
        id: tabsRepeater

        model: view.count

        delegate: Button {
            id: repeaterDelegate

            implicitWidth: 20
            implicitHeight: 95

            text: view.getTab(index).title

            onDownChanged: {
                canvas.requestPaint()
            }

            background: Canvas {
                id: canvas
                anchors.fill: parent

                antialiasing: true

                property int radius: 3

                property real tabAngle: Math.PI/8

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = index == view.currentIndex
                            ? DefaultTheme.activeControlBackground
                            : DefaultTheme.disabledControlBackground
                    ctx.strokeStyle = DefaultTheme.mainBackground

                    ctx.lineWidth = 1

                    ctx.beginPath()

                    ctx.moveTo(width, height)
                    ctx.lineTo(radius,height - (width/Math.cos(tabAngle) - radius))
                    ctx.bezierCurveTo(radius, height - (width/Math.cos(tabAngle) - radius),
                                      0, height - (width/Math.cos(tabAngle) - radius/2),
                                      0, height - (width/Math.cos(tabAngle) + radius))
                    ctx.lineTo(0, radius)
                    ctx.arcTo(0, 0, radius, 0, radius)
                    ctx.lineTo(width, 0)
                    ctx.lineTo(width, height)
                    ctx.fill()
                    ctx.stroke()

                    ctx.save()
                    ctx.font = "12px Arial, sans-serif"
                    ctx.fillStyle = repeaterDelegate.down ? DefaultTheme.disabledTextColor : DefaultTheme.textColor
                    ctx.textAlign = "left"

                    var textWidth = ctx.measureText(repeaterDelegate.text).width
                    var textWidthBaseline = (width + repeaterDelegate.font.pixelSize)/2
                    ctx.translate(textWidthBaseline, height)
                    ctx.rotate(-Math.PI/2)
                    ctx.fillText(repeaterDelegate.text, (width/Math.cos(tabAngle))/2 + (height - textWidth)/2, width/2 - repeaterDelegate.font.pixelSize)
                    ctx.restore();
                }

                Connections {
                    target: view
                    function onCurrentIndexChanged() { canvas.requestPaint() }
                }

                Component.onCompleted: requestPaint()
            }

            contentItem: Item {}

            onClicked: view.currentIndex = index
        }
    }
}
