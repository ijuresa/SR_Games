import VPlay 2.0
import QtQuick 2.0

import "../scenes"
import "../entities"
import "../common" as Common

Common.LevelBase {
    levelName: "PernarEscape"

    id: pernarEscape

    property int numberOfCharacters: 0
    property int currScore: 0
    property int maxScore: 0

    property bool gameRunning: false

    property int gameMode: 0
    property int cobanSpawn: 0


    PhysicsWorld {
        id: physicsId
        gravity.y: -1
        debugDrawVisible: false
    }

    function incrementGravity() {
        physicsId.gravity.y *= 1.05
    }


    Image {
        source: "../../assets/PernarEscape/img/pernarBackground.jpg"
    }

    BackgroundMusic {
        id: backgroundMusic
        autoPlay: false
        source: "../../assets/PernarEscape/audio/quakBackground.wav"
    }

    // Pernar pop
    SoundEffectVPlay {
        id: pernarCry
        source: "../../assets/PernarEscape/audio/GospodinPernar.wav"
    }

    // Left Wall
    Wall {
        height: parent.height
        anchors.right: parent.left
    }

    // Right
    Wall {
        height: parent.height
        anchors.left: parent.right
    }

    // Ceiling
    Wall {
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left

        BoxCollider {
            fixture.onBeginContact: {
                gameLost()
            }
        }
    }

    // Start game ( Timer )
    function startGame() {
        gameRunning = true
        backgroundMusic.play()
        entityTimer.start()
    }

    function turnBackgroundMusicOff() {
        backgroundMusic.stop()
    }

    // Reset Game ( Timer )
    function resetGame() {
        // Reset Pernars     
        entityManager.removeEntitiesByFilter("character")
        startGame()
    }

    function gameLost() {
        entityManager.removeEntitiesByFilter("character")
        gameRunning = false
        entityTimer.stop()

        // Check if it is new highscore
        if(currScore > maxScore) {
            maxScore = currScore
            console.warn("MaxScore" + maxScore)
        }

//        physicsId.running = false
    }

    Character {
        id: pervanCharacter
    }

    Timer {
        id: entityTimer
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            cobanSpawn += 3
            var newEntityProperties = {
                x: Math.random() * (parent.width - 50) + 50,
                y: parent.height + 30,
            }

            if(cobanSpawn %3 == 0) {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl(
                                  "../entities/Character.qml"),
                                  newEntityProperties);
            } else {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl(
                                  "../entities/Character.qml"),
                                  newEntityProperties);
            }

        }
    }

    EntityManager {
        id: entityManager
        entityContainer: pernarEscape
    }

    //Menu nakon završetka igre
    Column {
        anchors.centerIn: parent
        spacing: 10
        enabled: gameRunning ? false : true
        opacity: gameRunning ? 0 : 1

        //Button za ponovno pokretanje igre
        Common.MenuButton{
            text: "Play"

            onClicked: {
                resetGame()
            }
        }

        //Button za ponovno pokretanje igre
        Common.MenuButton{
            text: "Quit"
            onClicked: backButtonPressed()
        }
    }

    // Display max score
    Text {
        id: maxScoree
        anchors.top: parent.top
        anchors.topMargin: 10

        anchors.left: maxScoreText.right
        anchors.leftMargin: 10

        color: "white"
        font.pixelSize: 25
        text: maxScore
    }

    // Current score
    Text {
        id: score
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 80

        color: "white"
        font.pixelSize: 30
        text: currScore
    }

    Timer {
        id: musicTimer
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            gameMode ++

            if(gameMode >= 10) {
                incrementGravity()
                console.warn("Gravity Incremented:" + physicsId.gravity.y)
            }

            backgroundMusic.play();
        }
    }
}


