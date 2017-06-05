import VPlay 2.0
import QtQuick 2.0
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

    //Helikopter
    HelikopterScene {
        id: helikopterScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    //Credits
    CreditsScene {
        id: creditsScene
        onBackButtonPressed: gameWindow.state = "menu"
    }


       // default state is menu -> default scene is menuScene
       state: "menu"

       // state machine, takes care reversing the PropertyChanges when changing the state like changing the opacity back to 0
       states: [
         State {
           name: "menu"
           PropertyChanges {target: menuScene; opacity: 1}
           PropertyChanges {target: gameWindow; activeScene: menuScene}
         },
         State {
           name: "helikopter"
           PropertyChanges {target: helikopterScene; opacity: 1}
           PropertyChanges {target: gameWindow; activeScene: helikopterScene}
         },

         State {
           name: "credits"
           PropertyChanges {target: creditsScene; opacity: 1}
           PropertyChanges {target: gameWindow; activeScene: creditsScene}
         }





       ]



}
