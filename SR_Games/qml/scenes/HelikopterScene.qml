import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

SceneBase {

    id: helikopterScene

    Rectangle {
        id: rectangle
        anchors.fill: parent.gameWindowAnchorItem
        color: "white"
    }// Rectangle with size of logical scene

    Text {
        text: "helikopter wuhuu"
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
