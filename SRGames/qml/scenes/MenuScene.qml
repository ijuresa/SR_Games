import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    signal selectLevelPressed
    signal creditsPressed
    signal selectGamePressed

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
        text: "MultiSceneMultiLevel"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            text: "Games"
            onClicked: selectGamePressed()
        }

        MenuButton {
            text: "Levels"
            onClicked: selectLevelPressed()
        }

        MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
        }


    }
}
