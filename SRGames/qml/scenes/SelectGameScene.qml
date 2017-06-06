import VPlay 2.0
import QtQuick 2.0

import "../common"

SceneBase {
    id: selectGameScene

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#49a349"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectGameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: selectGameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    Row {
        spacing: 18
        anchors.horizontalCenter: parent.horizontalCenter
        height: menuItem.height

        SelectGameSceneButton {
            id: menuItem
            onClicked: {
                // TODO:
            }
            source: "../../assets/HelicopterClimb/img/Menu_Green_01.png"

        }
    }


}