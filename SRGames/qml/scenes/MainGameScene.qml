import VPlay 2.0
import QtQuick 2.0

import "../common"

SceneBase {
    id: mainGameScene

    property string activeGameFileName
    property variant activeGame

    function setGame(fileName) {
        activeGameFileName = fileName
    }

    Loader {
        id: loader
        source: activeGameFileName != "" ? "../games/" + activeGameFileName : ""

        onLoaded: {
            item.width = mainGameScene.width
            item.height = mainGameScene.height

            activeGame = item
        }
    }
}
