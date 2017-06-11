import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "character"
    width: 70
    height: 84

    // transformOrigin: Item.TopLeft

    BoxCollider {
        id: boxCollider
        x: - width / 2
        y: - height / 2
        fixture.restitution: 0.5
    }

    MultiResolutionImage {
        id: sprite
        source: "../../assets/PernarEscape/img/pernarFront.png"
        anchors.fill: boxCollider
    }

    MouseArea {
        anchors.fill: sprite
        onPressed: {
            pernarEscape.score ++
            pernarEscape.pernarCry.play()
            removeEntity()
        }
    }
}
