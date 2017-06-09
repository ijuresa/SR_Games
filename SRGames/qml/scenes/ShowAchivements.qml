import VPlay 2.0
import QtQuick 2.0

import "../common"

SceneBase {
    id: showAchivements

    property alias gameNetworkView: myGameNetworkView

//    VPlayGameNetwork {
//        id: gameNetwork
//        gameId: 369
//        secret: "12345678987654321"
//        gameNetworkView: myGameNetworkView

//        Component.onCompleted: {
//            // Put here achievements
//        }

//        achievements: [
//            Achievement {
//                key: "SpockKillingSpree"
//                name: "Killing Spree"
//                iconSource: "../../assets/RockPaper/img/spockKillingSpree.png"
//                target: 3
//                points: 5
//                description: "Win 3 in a row"
//                descriptionAfterUnlocking: "Won 3 in a row"
//            },

//            Achievement {
//                key: "SpockRampage"
//                name: "Rampage"
//                iconSource: "../../assets/RockPaper/img/spockRampage.png"
//                target: 5
//                points: 10
//                description: "Win 5 in a row"
//            },

//            Achievement {
//                key: "SpockGodlike"
//                name: "Godlike"
//                iconSource: "../../assets/RockPaper/img/spockGodlike.png"
//                target: 9
//                points: 20
//                description: "Win 7 in a row"
//            },

//            Achievement {
//                key: "SpockDraw"
//                name: "Draw Sensei"
//                iconSource: "../../assets/RockPaper/img/spockDraw.png"
//                target: 3
//                points: 10
//                description: "Draw 3 in a row"
//            }
//        ]
//    }

    VPlayGameNetworkView {
        id: myGameNetworkView
        gameNetworkItem: gameNetwork
        anchors.fill: showAchivements.gameWindowAnchorItem

        onShowCalled: {
            myGameNetworkView.visible = true
        }

        onBackClicked: {
            myGameNetworkView.visible = false
            window.state = "menu"
        }
    }

}
