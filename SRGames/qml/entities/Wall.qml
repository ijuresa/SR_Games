import VPlay 2.0
import QtQuick 2.0

EntityBase {

    entityType: "wall"
    width: 1
    height: 1

    // only collider since we want the wall to be invisible
    BoxCollider {
      anchors.fill: parent
      bodyType: Body.Static // the body shouldn't move
    }

}
