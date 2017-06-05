import VPlay 2.0
import QtQuick 2.0

import "HelicopterClimb"
import "HelicopterClimb/scenes"
import "HelicopterClimb/common"
import "scenes"

GameWindow {
    id: gameWindow

    screenWidth: 960
    screenHeight: 640

    // Menu scena
    MenuScene {
        id: menuScene
        onHelikopterPressed: gameWindow.state = "helikopter"
        onCreditsPressed: gameWindow.state = "credits"
    }

    // Helicopter
    HelicopterSplashScreen {
        id: helicopterSplashScreen
        onBackButtonPressed: gameWindow.state = "menu"
    }

    // Credits
    CreditsScene {
        id: creditsScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    // Default state is menu -> default scene is menuScene
    state: "menu"

    // State machine, takes care reversing the PropertyChanges when
    // changing the state like changing the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: menuScene}
         },

         State {
            name: "helikopter"
            PropertyChanges {target: helicopterSplashScreen; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: helicopterSplashScreen}

            Component.onCompleted: {
            helicopterSplashScreen.opacity = 1
            mainItemDelay.start()
            }
         },

         State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: creditsScene}
         }
    ]

    Timer {
        id: mainItemDelay
        interval: 500
        onTriggered: mainItemLoader.source = "HelicopterClimb/MainItem.qml"
    }

    Loader {
        id: mainItemLoader
        onLoaded: {
            if(item) {
                hideSplashDelay.start()
            }
        }
    }

    Timer {
        id: hideSplashDelay
        interval: 200
        onTriggered: {
            helicopterSplashScreen.opacity = 0
        }
    }
}
