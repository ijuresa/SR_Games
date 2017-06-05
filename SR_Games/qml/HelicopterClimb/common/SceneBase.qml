import VPlay 2.0
import QtQuick 2.0

Scene {
    id: sceneBase

    width: 320
    height: 480

    // Set default opacity to 0
    opacity: 0

    visible: opacity > 0
    enabled: visible
}
