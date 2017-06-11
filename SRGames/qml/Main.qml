import VPlay 2.0
import QtQuick 2.0

import "scenes"
import "games"

GameWindow {
    id: window
    screenWidth: 960
    screenHeight: 640

    // Create and remove entities at runtime
    EntityManager {
        id: entityManager
    }

    ShowAchivements {
        id: showAchivements
    }


    VPlayGameNetwork {
        id: gameNetwork
        gameId: 370
        secret: "jucapuca"
        gameNetworkView: showAchivements.gameNetworkView

        Component.onCompleted: {
            // Put here achievements
        }

        achievements: [
            Achievement {
                key: "SpockKillingSpree"
                name: "Killing Spree"
                iconSource: "../../assets/RockPaper/img/spockKillingSpree.png"
                target: 3
                points: 5
                description: "Win 3 in a row"
                descriptionAfterUnlocking: "Won 3 in a row"
            },

            Achievement {
                key: "SpockRampage"
                name: "Rampage"
                iconSource: "../../assets/RockPaper/img/spockRampage.png"
                target: 5
                points: 10
                description: "Win 5 in a row"
                descriptionAfterUnlocking: "Won 5 in a row"
            },

            Achievement {
                key: "SpockGodlike"
                name: "Godlike"
                iconSource: "../../assets/RockPaper/img/spockGodlike.png"
                target: 9
                points: 20
                description: "Win 7 in a row"
                descriptionAfterUnlocking: "Won 7 in a row"
            },

            Achievement {
                key: "SpockDraw"
                name: "Draw Sensei"
                iconSource: "../../assets/RockPaper/img/spockDraw.png"
                target: 3
                points: 10
                description: "Draw 3 in a row"
                descriptionAfterUnlocking: "Draw 3 in a row"
            },

            Achievement {
                key: "score4"
                name: "Peasant"
                iconSource: "../../assets/RockPaper/img/score4.png"
                target: 4
                points: 5
                description: "Get 4 score without losing"
                descriptionAfterUnlocking: "Fourth"
            },

            Achievement {
                key: "score6"
                name: "Lord"
                iconSource: "../../assets/RockPaper/img/score6.png"
                target: 6
                points: 5
                description: "Get 6 score without losing"
                descriptionAfterUnlocking: "Sixth"
            },

            Achievement {
                key: "score10"
                name: "Overlord"
                iconSource: "../../assets/RockPaper/img/score10.png"
                target: 10
                points: 20
                description: "Get 10 score without losing"
                descriptionAfterUnlocking: "Tenth"
            },

            Achievement {
                key: "scoreOverall50"
                name: "Noob"
                iconSource: "../../assets/RockPaper/img/baseCoins50.png"
                target: 50
                points: 5
                description: "Get 50 score"
                descriptionAfterUnlocking: "Scored 50"
            },

            Achievement {
                key: "scoreOverall100"
                name: "Persistent"
                iconSource: "../../assets/RockPaper/img/baseCoins100.png"
                target: 100
                points: 10
                description: "Get 100 score"
                descriptionAfterUnlocking: "Scored 100"
            },

            Achievement {
                key: "scoreOverall500"
                name: "Pro"
                iconSource: "../../assets/RockPaper/img/baseCoins500.png"
                target: 500
                points: 20
                description: "Get 500 score"
                descriptionAfterUnlocking: "Scored 500"
            },

            Achievement {
                key: "scoreOverall1000"
                name: "No Lifer"
                iconSource: "../../assets/RockPaper/img/baseCoins1000.png"
                target: 1000
                points: 40
                description: "Get 1000 score"
                descriptionAfterUnlocking: "Scored 1000"
            },
            //////////////HelicopterClimb Scores///////////////////
            Achievement {
                key: "heliScore10"
                name: ""
                iconSource: "../../assets/RockPaper/img/score10.png"
                target: 10
                points: 1
                description: "Get 30 score"
                descriptionAfterUnlocking: "Scored 30"
            },

            Achievement {
                key: "heliScore100"
                name: "RoflCopter"
                iconSource: "../../assets/RockPaper/img/baseCoins50.png"
                target: 100
                points: 50
                description: "Get 100 score"
                descriptionAfterUnlocking: "You are really good at being tard"
            },

            Achievement {
                key: "heliFire"
                name: "Firebender"
                iconSource: "../../assets/particleFire_32.png"
                target: 1
                points: 5
                description: "Set helicopter afire!"
                descriptionAfterUnlocking: "Hot, hot, hot!"
            }
        ]
    }

    // MENU scene
    MenuScene {
        id: menuScene

        // Button Listener
        // Changes scenes according to button click
        onSelectGamePressed: window.state = "selectGame"
        onSelectLevelPressed: window.state = "selectLevel"
        onShowAchivementsPressed: window.state = "achievements"

        // When user wants to exit from MENU scene
        onBackButtonPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }

        // listen to the return value of the MessageBox
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
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
            mainGameScene.parseAchievements()
            window.state = "gameOn"
        }
        onBackButtonPressed: window.state = "menu"
    }

    MainGameScene {
        id: mainGameScene
        onBackButtonPressed: window.state = "selectGame"
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
        },
        State {
            name: "achievements"
            PropertyChanges { target: showAchivements; opacity: 1 }
            PropertyChanges { target: window; activeScene: showAchivements }
        }

    ]
}
