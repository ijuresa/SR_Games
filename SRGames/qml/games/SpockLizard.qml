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
            width: newWidth / 2
            onClicked: {

            }
            source: "../../assets/RockPaper/img/rock.png"
        }

        Common.SelectGameSceneButton {
            id: paperImage
            width: newWidth / 2
            onClicked: {

            }
            source: "../../assets/RockPaper/img/paper.png"
        }

        Common.SelectGameSceneButton {
            id: scissorsImage
            width: newWidth / 2
            onClicked: {

            }
            source: "../../assets/RockPaper/img/scissor.png"
        }

        Common.SelectGameSceneButton {
            id: lizardImage
            width: newWidth / 2
            onClicked: {

            }
            source: "../../assets/RockPaper/img/lizard.png"
        }

        Common.SelectGameSceneButton {
            id: spockImage
            width: newWidth / 2
            onClicked: {

            }
            source: "../../assets/RockPaper/img/spock.png"
        }

    }


//    Grid {
//        anchors.centerIn: parent
//        spacing: 10
//        columns: 5

//        Common.SelectGameSceneButton {
//            id: rockImage
//            width: newWidth / 2
//            onClicked: {

//            }
//            source: "../../assets/RockPaper/img/rock.png"
//        }

//        Common.SelectGameSceneButton {
//            id: scissorsImage
//            width: 50
//            onClicked: {

//            }
//            source: "../../assets/RockPaper/img/scissors.png"
//        }

//        Common.SelectGameSceneButton {
//            id: lizardImage
//            width: parent.width / 5
//            onClicked: {

//            }
//            source: "../../assets/RockPaper/img/lizard.png"
//        }

//        Common.SelectGameSceneButton {
//            id: spockImage
//            width: parent.width / 5
//            onClicked: {

//            }
//            source: "../../assets/RockPaper/img/spock.png"
//        }
//    }
}
