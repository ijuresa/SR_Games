import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "character"

    BoxCollider {
        anchors.fill: parent
        // height: sprite.height
        // width: sprite.width
        // bodyType: Body.Dynamic
        anchors.centerIn: parent
    }

    MultiResolutionImage {
        id: sprite
        source: "../../assets/PernarEscape/img/pernarFront.png"
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: sprite

        onPressed: {
            // TODO: Pressed event
        }
    }

    Component.onCompleted: {
        x = pernarEscape.width
        y = utils.generateRandomValueBetween(15, pernarEscape.height - 15)
    }


}
