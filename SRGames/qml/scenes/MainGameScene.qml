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

    ///Spajano
    Connections {
        // only connect if a game is loaded, to prevent errors
        target: activeGame !== undefined ? activeGame : null
        // increase the score when the rectangle is clicked
        onHighscoreAchieved: {
            gameNetwork.reportScore(highscore);
            console.error("triggered Highscore with score:" + highscore)
            }
        onAchievementUnlocked: {
            if(amount>0){
                gameNetwork.incrementAchievement(key, amount, true)
            }
            else{
                gameNetwork.unlockAchievement(key, true)
            }


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
