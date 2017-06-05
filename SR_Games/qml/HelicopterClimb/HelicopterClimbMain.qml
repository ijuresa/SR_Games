import VPlay 2.0
import QtQuick 2.0

import "scenes"
import "common"

GameWindowItem {
    id: helicopterWindow
    
    // Set property to this window ID
    property alias window: helicopterWindow

    // Input screen in game
    activeScene: helicopterSplashScreen

    Component.onCompleted: {
        helicopterSplashScreen.opacity = 1
        mainItemDelay.start()
    }

    Timer {
        id: mainItemDelay
        interval: 500
        onTriggered: {
            mainItemLoader.source = "MainItem.qml"
        }
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

    HelicopterSplashScreen {
        id: helicopterSplashScreen
    }

}



