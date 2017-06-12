import VPlay 2.0
import QtQuick 2.0

EntityBase {

    entityId: "entity"
    entityType: "cobankovic"

    x: parent.width/2
    y: parent.height+5

    BoxCollider {
        id: boxCollider
        bodyType: Body.Dynamic
        width: 70
        height: 84
        fixture.restitution: 0.5
        anchors.centerIn: parent
    }

    MultiResolutionImage {
        id: sprite
        width: 70
        height: 84
        source: "../../assets/PernarEscape/img/cobankovic.png"
        anchors.fill: boxCollider
    }

    MouseArea {
        anchors.fill: sprite
        onPressed: {
            pernarEscape.currScore += 5
            console.warn("Score++" + pernarEscape.currScore)
            removeEntity()
            console.warn("Entity kliknut"+mouseX+" "+mouseY)
        }
    }

}
