import VPlay 2.0
import QtQuick 2.0
import QtSensors 5.0
import QtMultimedia 5.0

import "../common" as Common

Common.LevelBase {
    id: heliClimb
    levelName: "HelicopterClimb"

    // default state for sensor
    state: "default"
    // score
    property int score: 0



    //Pozadina
    BackgroundImage {
        id: backgroundImage
        source: "../../assets/HelicopterClimb/img/sky1920x1276.jpg"
        anchors.fill: parent
    }

    //Pozadinski zvukovi
    BackgroundMusic {
        id: heliSound
        source:  "../../assets/HelicopterClimb/sound/heliSound.wav"
        autoPlay: true
    }

    //Postavke fizike
    PhysicsWorld {

        id: world
        running: true
        gravity.y: -3.0
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

    //TODO Maknuti state change kod poda////////////////////////////


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

        BoxCollider {
            anchors.fill: parent
            bodyType: Body.Static

            fixture.onBeginContact: {
                collisionSound.play();
                collisionParticleEffect.start();
                score++;
                //DEBUG
                heliClimb.state = "rotated"
                timer.start()

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
        y: parent.height / 2
        //rotation: 90
        //Behavior on x { SmoothedAnimation {velocity: 200}}
        //Behavior on y { SmoothedAnimation {velocity: 200}}

        //Reset pozicije helikoptera
        function heliReset()
        {
            x = parent.width /2
            y = parent.top
        }

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

            fixture.onBeginContact:
            {
                heliSound.play()
            }
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
                PropertyChanges { target: world;
                    gravity.y: -(world.gravity.y)

                }

                },
            State {
                name: "default"
                PropertyChanges { target: heli1;
                    rotation: 0;
                }
            },
            State {
                name: "whipped"
                PropertyChanges { target: heli1;
                    rotation: 0; y: heli1.y + 30; }
            },
            State {
                name: "twistedR"
                PropertyChanges { target: heli1;
                    rotation: 30;
                    x: heli1.x +20;
                }
            },
            State {
                name: "twistedL"
                PropertyChanges { target: heli1;
                    rotation: -30;
                    x: heli1.x -20;
                }
            },
            State {
                name :"slammed"
                PropertyChanges { target: heli1; rotation: 0;
                    y: heli1.y + 30
                }
            }
        ]

    //Sensor movement
    SensorGesture {
            id: sensorGesture
            enabled: true
            gestures : ["QtSensors.shake2","QtSensors.shake", "QtSensors.whip", "QtSensors.twist", "QtSensors.cover",
                "QtSensors.hover", "QtSensors.turnover", "QtSensors.pickup", "QtSensors.slam" , "QtSensors.doubletap"]
            onDetected:{
                console.debug(gesture)
                sensorLabel.text = gesture

                if (gesture == "shake") {
                    heliClimb.state = "default"
                    timer.start()
                }
                if (gesture == "whip") {
                    heliClimb.state == "whipped" ? heliClimb.state = "default" : heliClimb.state = "whipped"
                    timer.start()

                }
                if (gesture == "twistRight") {
                    heliClimb.state == "twistedR" ? heliClimb.state = "default" : heliClimb.state = "twistedR"
                    timer.start()
                }
                if (gesture == "twistLeft") {
                    heliClimb.state == "twistedL" ? heliClimb.state = "default" : heliClimb.state = "twistedL"
                    timer.start()
                }
                if (gesture == "cover") {
                    heliClimb.state == "covered" ? heliClimb.state = "default" : heliClimb.state = "covered"
                    timer.start()
                }
                if (gesture == "hover") {
                    heliClimb.state == "hovered" ? heliClimb.state = "default" : heliClimb.state = "hovered"
                    timer.start()
                }
                if (gesture == "turnover") {
                    heliClimb.state == "rotated" ? heliClimb.state = "default" : heliClimb.state = "rotated"

                    timer.start()
                }
                if (gesture == "pickup") {
                    heliClimb.state = "default"

                    timer.start()
                }
                if (gesture == "slam") {
                    heliClimb.state == "slammed" ? heliClimb.state = "default" : heliClimb.state = "slammed"
                    timer.start()
                }
                if (gesture == "doubletap") {
                    heliClimb.state == "doubletapped" ? heliClimb.state = "default" : heliClimb.state = "doubletapped"
                    timer.start()
                }
            }
        }

        //Timer za gesture
        Timer {
            id: timer
            running: false
            repeat: false
            interval: 300
            onTriggered: {
                console.debug("available gestures"+sensorGesture.availableGestures)
                console.debug("invalid gestures"+sensorGesture.invalidGestures)
                console.debug("valid gestures"+sensorGesture.validGestures)
                console.log("timer triggered")
                console.log("timer triggered")
                console.log("gravitacija "+world.gravity)
                console.log("state:"+heliClimb.state)
                heliClimb.state = "default"
                sensorLabel.text = "Try another gesture"
            }
        }

        //General purpose activation timer
        Timer {
            id: syncTimer
            running: true
            repeat: true
            interval: 300
            onTriggered: {
                if (heliSound.playing == false) heliSound.play()
            }
        }
}

