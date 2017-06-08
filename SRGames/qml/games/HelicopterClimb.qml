import VPlay 2.0
import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.0

import "../common" as Common

Common.LevelBase {
    levelName: "HelicopterClimb"



    // score
    property int score: 0
    // helikopter pozicija


    BackgroundImage {
        id: backgroundImage
        source: "../../assets/HelicopterClimb/img/sky1920x1276.jpg"
        anchors.fill: parent
    }

    //Postavke fizike
    PhysicsWorld {

        id: world
        running: true
        gravity.y: -2.0
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

            fixture.onBeginContact: {
                collisionSound.play();
                collisionParticleEffect.start();
                score++;
            }
        }
    }

    //Lijevi zid
    EntityBase {
        entityId: "wallL"
        entityType: "wall"
        height: parent.height
        anchors {
            left: parent.left
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

    //Desni zid
    EntityBase {
        entityId: "wallR"
        entityType: "wall"
        height: parent.height
        anchors {
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

    //Strop
    EntityBase {
        entityId: "wallT"
        entityType: "ceiling"
        anchors {
            right: parent.right
            left: parent.left
            top: parent.top
        }


        BoxCollider {
            anchors.fill: parent
            bodyType: Body.Static
        }
    }


    //Helikopter
    EntityBase {
        id: heli1
        entityId: "heli1"
        entityType: "heli"
        x: parent.width / 2
        y: parent.top
        Behavior on x { SmoothedAnimation {velocity: 200}}
        Behavior on y { SmoothedAnimation {velocity: 200}}

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

        }

        SoundEffectVPlay {
            id: collisionSound
            source: "../../assets/HelicopterClimb/sound/collision.wav"
        }

        ParticleVPlay {
          id: collisionParticleEffect
          property string smokeFilePath: "../../assets/particleEffect/SmokeParticle.json"
          property string fireFilePath: "../../assets/particleEffect/FireParticle.json"
          fileName: (score > 20) ? collisionParticleEffect.fireFilePath : collisionParticleEffect.smokeFilePath
          // make the particles float independent from the entity position - this would be the default setting, but for making it clear it is added explicitly here as well
          positionType: 0



        }
    }

    //Score displayed
    Text {
        id: textScore
        x: parent.width/2
        anchors.top: parent.top
        anchors.topMargin: 10
        color: "white"
        font.pixelSize: 30
        text: score
    }

    Text {
        id: sensorLabel
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: 10
            }
        color: "white"
        font.pixelSize: 20
        text: "Sensor gesture:"
    }


    //States for sensor movement
    states: [
            State {
                name: "rotated"
                PropertyChanges { target: heli1; rotation: 180 }
                },
            State {
                name: "default"
                PropertyChanges { target: heli1; rotation: 0;
                    x: parent.width / 2 - (heli1.width / 2)
                    y: parent.height / 2 - (heli1.height);
                }
            },
            State {
                name: "whipped"
                PropertyChanges { target: heli1; rotation: 0; x:0; }
            },
            State {
                name: "twistedR"
                PropertyChanges { target: heli1; rotation: 270;
                    x:parent.width - heli1.width;
                }
            },
            State {
                name: "twistedL"
                PropertyChanges { target: heli1; rotation: 270;
                    x:0;
                }
            },
            State {
                name :"slammed"
                PropertyChanges { target: heli1; rotation: 0;
                    x: 0;
                    y: 0 + 30
                }
            }
        ]

    //Sensor movement
    SensorGesture {
            id: sensorGesture
            enabled: true
            gestures : ["QtSensors.shake", "QtSensors.whip", "QtSensors.twist", "QtSensors.cover",
                "QtSensors.hover", "QtSensors.turnover", "QtSensors.pickup", "QtSensors.slam" , "QtSensors.doubletap"]
            onDetected:{
                console.debug(gesture)
                sensorLabel.text = gesture

                if (gesture == "shake") {
                    parent.state == "rotated" ? parent.state = "default" : parent.state = "rotated"
                    timer.start()
                }
                if (gesture == "whip") {
                    parent.state == "whipped" ? parent.state = "default" : parent.state = "whipped"
                    timer.start()

                }
                if (gesture == "twistRight") {
                    parent.state == "twistedR" ? parent.state = "default" : parent.state = "twistedR"
                    timer.start()
                }
                if (gesture == "twistLeft") {
                    parent.state == "twistedL" ? parent.state = "default" : parent.state = "twistedL"
                    timer.start()
                }
                if (gesture == "cover") {
                    parent.state == "covered" ? parent.state = "default" : parent.state = "covered"
                    timer.start()
                }
                if (gesture == "hover") {
                    parent.state == "hovered" ? parent.state = "default" : parent.state = "hovered"
                    timer.start()
                }
                if (gesture == "turnover") {
                    parent.state = "default"

                    timer.start()
                }
                if (gesture == "pickup") {
                    parent.state = "default"

                    timer.start()
                }
                if (gesture == "slam") {
                    parent.state == "slammed" ? parent.state = "default" : parent.state = "slammed"
                    timer.start()
                }
                if (gesture == "doubletap") {
                    parent.state == "doubletapped" ? parent.state = "default" : parent.state = "doubletapped"
                    timer.start()
                }
            }
        }
        Timer {
            id: timer
            running: false
            repeat: false
            interval: 3000
            onTriggered: {
                console.log("timer triggered")
                parent.state = "default"
                label.text = "Try another gesture"
            }
        }
}

