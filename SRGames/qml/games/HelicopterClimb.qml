import VPlay 2.0
import QtQuick 2.0

import "../common" as Common

Common.LevelBase {
    levelName: "HelicopterClimb.qml"

    BackgroundImage {
        id: backgroundImage
        source: "../../assets/HelicopterClimb/img/sky1920x1276.jpg"
        anchors.fill: parent
    }

    //Postavke fizike
    PhysicsWorld {
        id: world
        running: true
        gravity.y: 3.0
        z: 10

        updatesPerSecondForPhysics: 60
        velocityIterations: 5
        positionIterations: 5
        debugDrawVisible: false
    }

    //Pomicanje kutije mišem
    Component {
        id: mouseJoint
        MouseJoint{
            maxForce: 30000
            dampingRatio: 1
            frequencyHz: 2
        }
    }

    MouseArea {
        anchors.fill: parent
        property Body selectedBody: null
        property MouseJoint mouseJointWhileDragging: null

        onPressed: {
            selectedBody = world.bodyAt(Qt.point(mouseX, mouseY));
            console.debug("selected body at position", mouseX, mouseY, ":", selectedBody);
               // if the user selected a body, this if-check is true
               if(selectedBody) {
                   // create a new mouseJoint
                   mouseJointWhileDragging = mouseJoint.createObject(world)

                   // set the target position to the current touch position (initial position)
                   mouseJointWhileDragging.target = Qt.point(mouseX, mouseY)

                   // connect the joint with the body
                   mouseJointWhileDragging.bodyB = selectedBody
               }
           }

           onPositionChanged: {
               // this check is necessary, because the user might also drag when no initial body was selected
               if (mouseJointWhileDragging)
                   mouseJointWhileDragging.target = Qt.point(mouseX, mouseY)
           }
           onReleased: {
               // if the user pressed a body initially, remove the created MouseJoint
               if(selectedBody) {
                   selectedBody = null
                   if (mouseJointWhileDragging)
                       mouseJointWhileDragging.destroy()
               }
           }
}


    //Pod
    EntityBase {
        entityId: "ground1"
        entityType: "ground"
        height: 20
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        Rectangle {
            anchors.fill: parent
            color: "green"
        }

        Text {

        }

        BoxCollider {
            anchors.fill: parent
            bodyType: Body.Static
        }
    }


    //Helikopter
    EntityBase {
        entityId: "heli1"
        entityType: "heli"
        x: parent.width / 2

        AnimatedImage {
            id: heliImage
            source: "../../assets/HelicopterClimb/img/helicopterAnimation.gif"
            anchors.fill: boxCollider
            width: 128
            height: 64
        }
        BoxCollider {
            id: boxCollider
            width: 128
            height: 64
            anchors.centerIn: parent

            fixture.onBeginContact: {
                collisionSound.play();
            }
        }

        SoundEffectVPlay {
            id: collisionSound
            source: "../../assets/HelicopterClimb/sound/collision.wav"
        }
    }




}
