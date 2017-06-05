import VPlay 2.0
import QtQuick 2.0

SceneBase {
    id: menuScene

    // signal indicating that the helikopter should be displayed
    signal helikopterPressed
    // signal indicating that the creditsScene should be displayed
    signal pernarPressed
    // signal indicating that the settingsScene should be displayed
    signal creditsPressed

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#47688e"
    }

    // the "logo"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 30
        color: "#e9e9e9"
        text: "Menu"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 10

        // TODO replace the buttons with your custom styled buttons
        MenuButton {
            text: "Levels"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: selectLevelPressed()
                // TODO load your levelselection scene here or start the game
        }

        MenuButton {
            text: "Helikopter"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: helikopterPressed()

        }

        MenuButton {
            text: "Credits"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                // TODO load your credits scene here
                creditsPressed()
            }
        }
    }
}
