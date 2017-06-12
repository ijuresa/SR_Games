import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "character"
    x: parent.width/2
    y: parent.height+5

    // transformOrigin: Item.TopLeft

    property alias source: sprite.source

    SoundEffectVPlay {
        id: pernarCry
        source: "../../assets/PernarEscape/audio/pernar.wav"
    }

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
        source: "../../assets/PernarEscape/img/pernarFront.png"
        anchors.fill: boxCollider
    }

    MouseArea {
        anchors.fill: sprite
        onPressed: {
            pernarEscape.currScore ++
            console.warn("Score++" + pernarEscape.currScore)
            pernarCry.play()
            removeEntity()
            console.warn("Entity kliknut"+mouseX+" "+mouseY)
        }
    }
}
