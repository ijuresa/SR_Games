import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

SceneBase {

    id: creditsScene

    Rectangle {
        id: rectangle
        anchors.fill: parent.gameWindowAnchorItem
        color: "white"
    }// Rectangle with size of logical scene

    Text {
        text: "Credits yo"
        color: "green"
        anchors.centerIn: parent
    }

    MenuButton {
      text: "Back"
      anchors.right: selectLevelScene.gameWindowAnchorItem.right
      anchors.rightMargin: 10
      anchors.top: selectLevelScene.gameWindowAnchorItem.top
      anchors.topMargin: 10
      onClicked: backButtonPressed()
    }

}
