import VPlay 2.0
import QtQuick 2.0

import "../common"

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

    Timer {
        repeat: true
        running: countdown > 0
        onTriggered: {
            countdown--
        }
    }

    onBackButtonPressed:{
        activeGameFileName = ""
        activeGame = null
    }

}
