import VPlay 2.0
import QtQuick 2.0

import "../common" as Common

Common.LevelBase {
    levelName: "SpockLizard"

    property bool cardPicked: false
    property var cards: { "Rock": 1, "Paper": 2, "Scissors": 3,
                            "Lizard": 4, "Spock": 5 }

    // Player card information
    property var playerCard
    property bool isPlayerCardVisible: false
    property int player: 1

    // Computer card information
    property var computerCard
    property bool isComputerCardVisible: false
    property int computer: 2

    property bool isGameOn: false

    Rectangle {
        anchors.fill: parent
        color: "#47688e"
    }

    Row {
        spacing: 10
        height: rockImage.newSourceSizeHeight
        width: parent.width
        anchors.left: parent.left
        anchors.leftMargin: spockMarginLeft

        anchors.bottom: parent.bottom
        anchors.bottomMargin: spockMarginBottom

        Common.SelectGameSceneButton {
            id: rockImage
            height: newHeight
            width: newWidth
            anchors.leftMargin: spockMarginLeft
            anchors.bottomMargin: spockMarginBottom

            onClicked: {
                playerCard = "Rock"
                showSpecificCard(player, 2)
                showSpecificCard(computer, 1)
            }
            source: "../../assets/RockPaper/img/rock1.png"
        }

        Common.SelectGameSceneButton {
            id: paperImage
            height: newHeight
            width: newWidth

            anchors.left: rockImage.right
            anchors.leftMargin: spockMarginLeft

            onClicked: {

            }
            source: "../../assets/RockPaper/img/paper1.png"
        }

        Common.SelectGameSceneButton {
            id: scissorsImage
            height: newHeight
            width: newWidth

            anchors.left: paperImage.right
            anchors.leftMargin: spockMarginLeft
            onClicked: {

            }
            source: "../../assets/RockPaper/img/scissor1.png"
        }

        Common.SelectGameSceneButton {
            id: lizardImage
            height: newHeight
            width: newWidth

            anchors.left: scissorsImage.right
            anchors.leftMargin: spockMarginLeft
            onClicked: {

            }
            source: "../../assets/RockPaper/img/lizard1.png"
        }

        Common.SelectGameSceneButton {
            id: spockImage
            height: newHeight
            width: newWidth

            anchors.left: lizardImage.right
            anchors.leftMargin: spockMarginLeft
            onClicked: {

            }
            source: "../../assets/RockPaper/img/spock1.png"
        }
    }

    Text {
        id: text
        x: parent.width/2
        anchors.top: parent.top
        anchors.topMargin: 10
        color: "white"
        font.pixelSize: 30
        text: playerCard
    }

    // Set all cards to the same spot for computer and player

    /********* Computer Images *********/
    // Rock
    Image {
        id: rockComputer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 40
        visible: false

        source: "../../assets/RockPaper/img/rock1.png"
    }
    // Rock Image for computer
    Image {
        id: paperComputer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 25
        visible: false

        source: "../../assets/RockPaper/img/paper1.png"
    }
    // Rock Image for computer
    Image {
        id: scissorsComputer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 25
        visible: false

        source: "../../assets/RockPaper/img/scissor1.png"
    }
    // Rock Image for computer
    Image {
        id: lizardComputer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 25
        visible: false

        source: "../../assets/RockPaper/img/lizard1.png"
    }
    // Rock Image for computer
    Image {
        id: spockComputer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 25
        visible: false

        source: "../../assets/RockPaper/img/spock1.png"
    }


    /********* Player Images *********/
    // Rock
    Image {
        id: rockPlayer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -25
        visible: false

        source: "../../assets/RockPaper/img/rock1.png"
    }
    // Rock Image for computer
    Image {
        id: paperPlayer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -40
        visible: false

        source: "../../assets/RockPaper/img/paper1.png"
    }
    // Rock Image for computer
    Image {
        id: scissorsPlayer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -25
        visible: false

        source: "../../assets/RockPaper/img/scissor1.png"
    }
    // Rock Image for computer
    Image {
        id: lizardPlayer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -25
        visible: false

        source: "../../assets/RockPaper/img/lizard1.png"
    }
    // Rock Image for computer
    Image {
        id: spockPlayer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -25
        visible: false

        source: "../../assets/RockPaper/img/spock1.png"
    }

    function cardPicked(inputCard) {
        playerCard = inputCard
    }

    // Set all card visibility to false
    function hideAllCards() {
        rockComputer.visible        = false;
        rockPlayer.visible          = false;

        paperComputer.visible       = false;
        paperPlayer.visible         = false;

        scissorsComputer.visible    = false;
        scissorsPlayer.visible      = false;

        lizardComputer.visible      = false;
        lizardPlayer.visible        = false;

        spockComputer.visible       = false;
        spockPlayer.visible         = false;
    }

    /* Show specific card
     * Here we will show only one card
     * Cards are mapped as shown below:
     *  1 - Rock
     *  2 - Paper
     *  3 - Scissors
     *  4 - Lizard
     *  5 - Spock
     *
     * Players are mapped as shown below:
     *  1 - Player
     *  2 - Computer
     *
     */
    function showSpecificCard(index, player) {
        // Check if we want to show computer of human card
        if(player === 1) {
            switch(index) {
            case 1:
                rockPlayer.visible = true
                break;
            case 2:
                paperPlayer.visible = true
                break;
            case 3:
                scissorsPlayer.visible = true
                break;
            case 4:
                lizardPlayer.visible = true
                break;
            case 5:
                spockPlayer.visible = true
                break;
            default:
                break;
            }
        } else {
            switch(index) {
            case 1:
                rockComputer.visible = true
                break;
            case 2:
                paperComputer.visible = true
                break;
            case 3:
                scissorsComputer.visible = true
                break;
            case 4:
                lizardComputer.visible = true
                break;
            case 5:
                spockComputer.visible = true
                break;
            default:
                break;
            }
        }
    }
}
