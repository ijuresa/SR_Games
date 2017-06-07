import VPlay 2.0
import QtQuick 2.0

import "../common" as Common

Common.LevelBase {
    levelName: "SpockLizard"

    Rectangle {
        anchors.fill: parent
        color: "#47688e"
    }

    Row {
        spacing: 10
        height: rockImage.height
        width: parent.width
        anchors.left: parent.left

        Common.SelectGameSceneButton {
            id: rockImage
            newSourceSizeWidth: parent.width / 5
            newSourceSizeHeight: parent.height / 5
            anchors.leftMargin: 10

            onClicked: {

            }
            source: "../../assets/RockPaper/img/rock.png"
        }

        Common.SelectGameSceneButton {
            id: paperImage
            newSourceSizeWidth: parent.width / 5
            newSourceSizeHeight: parent.height / 5

            anchors.left: rockImage.right
            anchors.leftMargin: rockImage.newSourceSizeWidth + 3

            onClicked: {

            }
            source: "../../assets/RockPaper/img/paper.png"
        }

        Common.SelectGameSceneButton {
            id: scissorsImage
            newSourceSizeWidth: parent.width / 5
            newSourceSizeHeight: parent.height / 5

            anchors.left: paperImage.right
            anchors.leftMargin: rockImage.newSourceSizeWidth + 3
            onClicked: {

            }
            source: "../../assets/RockPaper/img/scissor.png"
        }

        Common.SelectGameSceneButton {
            id: lizardImage
            newSourceSizeWidth: parent.width / 5
            newSourceSizeHeight: parent.height / 5

            anchors.left: scissorsImage.right
            anchors.leftMargin: rockImage.newSourceSizeWidth + 3
            onClicked: {

            }
            source: "../../assets/RockPaper/img/lizard.png"
        }

        Common.SelectGameSceneButton {
            id: spockImage
            newSourceSizeWidth: parent.width / 5
            newSourceSizeHeight: parent.height / 5

            anchors.left: lizardImage.right
            anchors.leftMargin: rockImage.newSourceSizeWidth + 3
            onClicked: {

            }
            source: "../../assets/RockPaper/img/spock.png"
        }

    }


}
