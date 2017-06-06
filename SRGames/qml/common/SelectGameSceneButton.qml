import VPlay 2.0
import QtQuick 2.0

// Buttons with images which will be used on gameSelectScreen

Item {
    id: selectGameSceneButton

    signal clicked
    signal pressed
    signal released

    width: sprite.width
    height: sprite.height

    property alias source: sprite.source

    MultiResolutionImage {
        id: sprite
    }

    MouseArea {
        id: mouseArea
        enabled: selectGameSceneButton.enabled
        anchors.fill: selectGameSceneButton
        hoverEnabled: true

        onClicked: selectGameSceneButton.clicked()
        onPressed: selectGameSceneButton.pressed()
        onReleased: selectGameSceneButton.released()
    }

    onClicked: { }

    onPressed: {
        opacity = 0.5
    }

    onReleased: {
        opacity = 1.0
    }
}
