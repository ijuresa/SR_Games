import VPlay 2.0
import QtQuick 2.0

import "../scenes"
import "../entities"
import "../common" as Common

Common.LevelBase {
    levelName: "PernarEscape"

    id: pernarEscape

    property int numberOfCharacters: 0

    property bool gameRunning: false


    PhysicsWorld {
        id: physicsId
        gravity.y: -1
        debugDrawVisible: false
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
        anchors.bottom: parent.top
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
//        pervanCharacter.removeAllEntities()
        startGame()
    }

    function gameLost() {
        gameRunning = false
        entityTimer.stop()
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
            var newEntityProperties = {
                x: Math.random() * (parent.width - 50) + 50,
                y: parent.height + 30,
            }

            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl(
                              "../entities/Character.qml"),
                              newEntityProperties);
        }
    }

    EntityManager {
        id: entityManager
        entityContainer: pernarEscape
    }

    //Menu nakon završetka igre
    Column{
        anchors.centerIn: parent
        spacing: 10
        enabled: gameRunning ? false : true
        opacity: gameRunning ? 0 : 1

        //Button za ponovno pokretanje igre
        Common.MenuButton{
            text: "Play Again"

            onClicked: {
                resetGame()
            }
        }

        //Button za ponovno pokretanje igre
        Common.MenuButton{
            text: ":("

            onClicked: backButtonPressed()
        }
    }
}


