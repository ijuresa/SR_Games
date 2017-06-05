import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"



    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640

    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 480
        height: 320

        // background rectangle matching the logical scene size (= safe zone available on all devices)
        // see here for more details on content scaling and safe zone: https://v-play.net/doc/vplay-different-screen-sizes/


        Rectangle {
            id: rectangle
            anchors.fill: scene.gameWindowAnchorItem
            color: "grey"
        }// Rectangle with size of logical scene

        Text {
            id: title
            anchors.centerIn: parent
            anchors.top: scene.gameWindowAnchorItem
            //anchors.topMargin: 5
            //color: "pink"
            text: "SRgam-\nes"
            font.pixelSize: 100
        }

        Column {
        anchors.centerIn: scene
        spacing: 5
        MyButton {
            labelText: "Pernar"
        }

        MyButton {
            labelText: "Zrakomlat"
        }

        MyButton {
            labelText: "Puhaljka"
        }

        }


    }
}
