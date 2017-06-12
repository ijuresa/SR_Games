import QtQuick 2.0

Rectangle {
    id: button
    // this will be the default size, it is same size as the contained text + some padding
    implicitWidth: 125
    implicitHeight: 50

    // round edges
    radius: 15

    // the horizontal margin from the Text element to the Rectangle at both the left and the right side.
    property int paddingHorizontal: 10
    // the vertical margin from the Text element to the Rectangle at both the top and the bottom side.
    property int paddingVertical: 5

    // access the text of the Text component
    property alias text: buttonText.text

    // this handler is called when the button is clicked.
    signal clicked
    width: 170
    color: "#f87cfe"

    Text {
        id: buttonText
        anchors.centerIn: parent
        color: "black"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
    }
}
