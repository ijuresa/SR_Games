import VPlay 2.0
import QtQuick 2.0

import "../common"

SceneBase {
    id: mainGameScene

    property string activeGameFileName
    property variant activeGame

    function setGame(fileName) {
        activeGameFileName = fileName
    }

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#dd94da"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: mainGameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: mainGameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
            backButtonPressed()
            activeGame = undefined
            activeGameFileName = ""
        }
    }

    Loader {
        id: loader
        source: activeGameFileName != "" ? "../games/" + activeGameFileName : ""

        onLoaded: {
            item.width = mainGameScene.width
            item.height = mainGameScene.height

            activeGame = item
        }
    }
}
