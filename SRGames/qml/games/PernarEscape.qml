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
    }

    // Floor
    Wall {
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }

    // Start game ( Timer )
    function startGame() {
        backgroundMusic.play()
        spawnCharacters.start()
    }

    function turnBackgroundMusicOff() {
        backgroundMusic.stop()
    }

    // Reset Game ( Timer )
    function resetGame() {

    }

    EntityBase {
        entityType: "pervan"
        x: parent.width / 2
        y: parent.height / 2

        BoxCollider {
            width: 100
            height: 121
            bodyType: Body.Dynamic
            anchors.centerIn: parent
        }

        MultiResolutionImage {
            id: pernarSprite
            source: "../../assets/PernarEscape/img/pernarFront.png"
            anchors.centerIn: parent
        }
    }

//    Timer {
//        id: spawnCharacters
//        interval: 20
//        repeat: true

//        onTriggered: {
//            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Character.qml"))
//            numberOfCharacters ++
//            if(numberOfCharacters == 50) {
//                running = false
//                gameRunning = true
//            }
//        }
//    }

//    Text {
//        id: infoText
//        anchors.bottom: parent.bottom
//        height: 40
//        text: "Char "+ numberOfCharacters
//    }

    // Create entities at runtime
//    EntityManager {
//        id: entityManager
//        entityContainer: pernarEscape
//    }

}


