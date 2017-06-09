import VPlay 2.0
import QtQuick 2.0

import "../scenes"
import "../entities"
import "../common" as Common

Common.LevelBase {
    levelName: "PernarEscape"
    id: pernarEscape

    property int numberOfCharacters: 0


    PhysicsWorld {
        gravity.y: 3
        debugDrawVisible: false
    }

    Image {
        source: "../../assets/PernarEscape/img/pernarBackground.jpg"
    }

    BackgroundMusic {
        source: "../../assets/PernarEscape/audio/pernarQuak"
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
        spawnCharacters.start()
    }

    // Reset Game ( Timer )
    function resetGame() {

    }

    Timer {
        id: spawnCharacters
        interval: 20
        repeat: true

        onTriggered: {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("../entities/Character"))
            numberOfCharacters ++
            if(numberOfCharacters == 20) {

            }
        }
    }
}


