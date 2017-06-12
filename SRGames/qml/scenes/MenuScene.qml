import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    signal selectLevelPressed
    signal selectGamePressed
    signal showAchivementsPressed

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#ffffff"
    }

    // the "logo"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 30
        color: "#f12d2d"
        text: "SR Games"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            text: "Games"
            onClicked: selectGamePressed()
        }

        MenuButton {
            text: "Show Achievements"
            onClicked: showAchivementsPressed()

        }
    }
}
