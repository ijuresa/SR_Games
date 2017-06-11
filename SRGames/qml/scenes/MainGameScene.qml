import VPlay 2.0
import QtQuick 2.0

import "../common"
import "../games"

SceneBase {
    id: mainGameScene

    property string activeGameFileName
    property variant activeGame
    property int score: 0
    property int countdown: 0
    property bool gameRunning

    function setGame(fileName) {
        activeGameFileName = fileName
    }

    function parseAchievements() {

    }
    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#47688e"
    }

    Loader {
        id: loader
        source: activeGameFileName != "" ? "../games/" + activeGameFileName : ""

        onLoaded: {
            item.width = mainGameScene.width
            item.height = mainGameScene.height

            activeGame = item
            gameRunning = true
            score = 0
            countdown = 3
        }
    }

    Connections {
        target: activeGame
        onAchievementUnlock: {
        }
    }

    Timer {
        repeat: true
        running: countdown > 0
        onTriggered: {
            countdown--
        }
    }

    onBackButtonPressed: {
        activeGameFileName = ""
        activeGame = null
        spockLizardGame.turnBackgroundMusicOff()
        pernarEscape.turnBackgroundMusicOff()
    }

}
