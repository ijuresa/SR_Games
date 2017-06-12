import VPlay 2.0
import QtQuick 2.0

import "../common"
import "../scenes"

SceneBase {
    id: selectGameScene

    // Indicate which game is pressed
    signal gamePressed(string gamePressed)

    function test22() {

    }

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#ffffff"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        id: backButtonMenu
        width: 100
        color: "#f12d2d"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectGameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: selectGameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    Column {
        spacing: 18
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: backButtonMenu.bottom
        anchors.topMargin: 10
        height: menuItem.height

        SelectGameSceneButton {
            id: menuItem
            width: newWidth
            height: newHeight
            onClicked: {
                gamePressed("HelicopterClimb.qml")
            }
            source: "../../assets/HelicopterClimb/img/helicopterButton.png"
        }

        SelectGameSceneButton {
            width: newWidth
            height: newHeight
            onClicked: {
                gamePressed("SpockLizard.qml")
                spockLizardGame.turnBackgroundMusicOn()
            }
            source: "../../assets/RockPaper/img/spockPlayButton.png"
        }

        SelectGameSceneButton {
            width: newWidth
            height: newHeight
            onClicked: {
                gamePressed("PernarEscape.qml")
                pernarEscape.startGame()
            }
            // TODO: Change with Pernar button
            source: "../../assets/PenarEscape/img/pernarEscapeButton.png"
        }
    }
}
