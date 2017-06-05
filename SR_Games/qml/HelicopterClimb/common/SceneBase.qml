import VPlay 2.0
import QtQuick 2.0


Scene {
    id: sceneBase

    width: 320
    height: 480

    opacity: 0

    visible: opacity === 0 ? false : true
    enabled: visible

    Behavior on opacity { NumberAnimation { duration: 250 } }

    signal enterPressed

    Keys.onPressed: {
        if(event.key === Qt.Key_Return) {
            enterPressed()
        }
    }

    Keys.onReturnPressed: {
        enterPressed()
    }
}
