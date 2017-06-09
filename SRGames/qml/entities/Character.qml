import VPlay 2.0
import QtQuick 2.0

EntityBase {

    property alias source: sprite.source

    BoxCollider {
        anchors.fill: parent
        height: sprite.height
        width: sprite.width
        bodyType: Body.Dynamic
    }

    MultiResolutionImage {
        id: sprite
        source: "../../assets/PernarEscape/img/PernarFront"
    }

    MouseArea {
        anchors.fill: sprite

        onPressed: {
            // TODO: Pressed event
        }
    }

    Component.onCompleted: {
        x = Utils.generateRandomValueBetween(15, PernalEscape.width - 15)
        y = PernarEscape.height
    }
}
