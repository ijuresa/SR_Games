import VPlay 2.0
import QtQuick 2.0

import "../common"

SceneBase {
    id: showAchivements

    property alias gameNetworkView: myGameNetworkView


    VPlayGameNetworkView {
        id: myGameNetworkView
        gameNetworkItem: gameNetwork
        anchors.fill: showAchivements.gameWindowAnchorItem

//        onShowCalled: {
//            myGameNetworkView.visible = true
//        }

        onBackClicked: {
            //myGameNetworkView.visible = false
            window.state = "menu"
        }
    }

}
