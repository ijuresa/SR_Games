import VPlay 2.0
import QtQuick 2.0

import "scenes"

GameWindow {
    id: window
    screenWidth: 960
    screenHeight: 640

    // Create and remove entities at runtime
    EntityManager {
        id: entityManager
    }

    // MENU scene
    MenuScene {
        id: menuScene

        // Button Listener
        // Changes scenes according to button click
        onSelectGamePressed: window.state = "selectGame"
        onSelectLevelPressed: window.state = "selectLevel"
        onCreditsPressed: window.state = "credits"

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }
        // listen to the return value of the MessageBox
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
                // only quit, if the activeScene is menuScene - the messageBox might also get opened from other scenes in your code
                if(accepted && window.activeScene === menuScene)
                    Qt.quit()
            }
        }
    }

    // scene for selecting levels
    SelectLevelScene {
        id: selectLevelScene
        onLevelPressed: {
            // selectedLevel is the parameter of the levelPressed signal
            gameScene.setLevel(selectedLevel)
            window.state = "game"
        }
        onBackButtonPressed: window.state = "menu"
    }

    // Select Game Scene
    SelectGameScene {
        id: selectGameScene
        onGamePressed: {
           mainGameScene.setGame(gamePressed)
            window.state = "gameOn"
        }

        onBackButtonPressed: window.state = "menu"
    }

    MainGameScene {
        id: mainGameScene
        onBackButtonPressed: window.state = "selectGame"
    }

    // credits scene
    CreditsScene {
        id: creditsScene
        onBackButtonPressed: window.state = "menu"
    }


    // game scene to play a level
    GameScene {
        id: gameScene
        onBackButtonPressed: window.state = "selectLevel"
    }

    // Initially active scene
    state: "menu"
    activeScene: menuScene

    // state machine, takes care reversing the PropertyChanges when changing the state, like changing the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "selectLevel"
            PropertyChanges {target: selectLevelScene; opacity: 1}
            PropertyChanges {target: window; activeScene: selectLevelScene}
        },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: window; activeScene: creditsScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        },
        State {
            name: "selectGame"
            PropertyChanges { target: selectGameScene; opacity: 1 }
            PropertyChanges { target: window; activeScene: selectGameScene }
        },
        State {
            name: "gameOn"
            PropertyChanges { target: mainGameScene; opacity: 1 }
            PropertyChanges { target: window; activeScene: mainGameScene }
        }
    ]
}
