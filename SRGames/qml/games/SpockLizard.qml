import VPlay 2.0
import QtQuick 2.0

import "../common" as Common
import "../scenes"

Common.LevelBase {
    levelName: "SpockLizard"
    id: spockLizardGame

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

    property int none: 3

    property int roundOverTimer: 3
    property bool isGameOn: false

    property int middleDivider: 60

    // Game mode, initially it's 0 what is easiest
    // TODO:
    property int mode: 0

    // For computer card selection
    property var minNumber
    property var maxNumber

    // Score and max score
    property var scoreCurr: 0
    property var scoreMax: 0

    // Winner
    property int winnerOfTheRound
    property var outcomeOfTheRound

    property string winner: "Win"
    property string loser: "Lose"
    property string draw: "Draw"

    // Unreal sounds
    property int soundChooser: 0

    // Game mode
    property int gameModeEasy: 5

    // Achievements
    property int loseAchievement
    property int drawAchievement
    property int scoreAchievement
    property int overallScore: 0

    property string achiText

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
                // Don't display cards if game is not ON
                if(roundOverTimer == 0) {
                    // Player Selection
                    playerCard = cards.Rock
                    showSpecificCard(player)

                    // Computer Selection
                    computerCardSelection()

                    // Check who wins
                    checkWinner()
                    setTextAndSound()
                }
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
                playerCard = "Paper"
                // Don't display cards if game is not ON
                if(roundOverTimer == 0) {
                    // Player Selection
                    playerCard = cards.Paper
                    showSpecificCard(player)

                    // Computer Selection
                    computerCardSelection()

                    // Check who wins
                    checkWinner()
                    setTextAndSound()
                }
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
                playerCard = "Scissors"
                // Don't display cards if game is not ON
                if(roundOverTimer == 0) {
                    // Player Selection
                    playerCard = cards.Scissors
                    showSpecificCard(player)

                    // Computer Selection
                    computerCardSelection()

                    // Check who wins
                    checkWinner()
                    setTextAndSound()
                }
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
                playerCard = "Lizard"
                // Don't display cards if game is not ON
                if(roundOverTimer == 0) {
                    // Player Selection
                    playerCard = cards.Lizard
                    showSpecificCard(player)

                    // Computer Selection
                    computerCardSelection()

                    // Check who wins
                    checkWinner()
                    setTextAndSound()
                }
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
                playerCard = "Spock"
                // Don't display cards if game is not ON
                if(roundOverTimer == 0) {
                    // Player Selection
                    playerCard = cards.Spock
                    showSpecificCard(player)

                    // Computer Selection
                    computerCardSelection(5)

                    // Check who wins
                    checkWinner()
                    setTextAndSound()
                }
            }
            source: "../../assets/RockPaper/img/spock1.png"
        }
    }

    // Max Score Text
    Text {
        id: maxScoreText
        anchors.top: parent.top
        anchors.topMargin: 10

        anchors.left: parent.left
        anchors.leftMargin: 10

        color: "white"
        font.pixelSize: 25
        text: "Max Score:"
    }

    // Display max score
    Text {
        id: maxSscore
        anchors.top: parent.top
        anchors.topMargin: 10

        anchors.left: maxScoreText.right
        anchors.leftMargin: 10

        color: "white"
        font.pixelSize: 25
        text: scoreMax
    }

    // Current score
    Text {
        id: score
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 80

        color: "white"
        font.pixelSize: 30
        text: scoreCurr
    }

    // Set all cards to the same spot for computer and player

    /********* Computer Images *********/
    // Rock
    Image {
        id: rockComputer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: middleDivider
        visible: false

        source: "../../assets/RockPaper/img/rock.png"
    }

    // Paper
    Image {
        id: paperComputer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: middleDivider
        visible: false

        source: "../../assets/RockPaper/img/paper.png"
    }

    // Scissors
    Image {
        id: scissorsComputer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: middleDivider
        visible: false

        source: "../../assets/RockPaper/img/scissor.png"
    }

    // Lizard
    Image {
        id: lizardComputer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: middleDivider
        visible: false

        source: "../../assets/RockPaper/img/lizard.png"
    }

    // Spock
    Image {
        id: spockComputer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: middleDivider
        visible: false

        source: "../../assets/RockPaper/img/spock.png"
    }

    /********* Player Images *********/
    // Rock
    Image {
        id: rockPlayer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - middleDivider
        visible: false

        source: "../../assets/RockPaper/img/rock.png"
    }

    // Paper
    Image {
        id: paperPlayer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - middleDivider
        visible: false

        source: "../../assets/RockPaper/img/paper.png"
    }

    // Scissors
    Image {
        id: scissorsPlayer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - middleDivider
        visible: false

        source: "../../assets/RockPaper/img/scissor.png"
    }

    // Lizard
    Image {
        id: lizardPlayer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - middleDivider
        visible: false

        source: "../../assets/RockPaper/img/lizard.png"
    }

    // Spock
    Image {
        id: spockPlayer
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: - middleDivider
        visible: false

        source: "../../assets/RockPaper/img/spock.png"
    }

    function checkAchivement(id) {
        gameNetwork.unlockAchievement()
    }

    // Check winner and set Text and SoundEffectVPlay
    // Increment killingSpree:
    function setTextAndSound() {
        if(winnerOfTheRound == player) {
            outcomeOfTheRound = winner
            soundChooser ++
            if(soundChooser == 3) {
                gameNetwork.unlockAchievement("SpockKillingSpree", true)
                unrealKillingSpree.play()
            } else if(soundChooser == 5) {
                gameNetwork.unlockAchievement("SpockRampage", true)
                unrealRampage.play()
            } else if(soundChooser == 9) {
                gameNetwork.unlockAchievement("SpockGodlike", true)
                unrealGodlike.play()
            } else if(soundChooser%4 == 0) {
                unrealMonsterKill.play()
            } else clappingSound.play()

        } else if(winnerOfTheRound == computer) {
            outcomeOfTheRound = loser
            youSuckSound.play()
            soundChooser = 0
        } else {
            outcomeOfTheRound = draw
        }
        roundOverTimer = 3
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
    function showSpecificCard(player) {
        // Check if we want to show computer of human card
        if(player === 1) {
            switch(playerCard) {
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
            switch(computerCard) {
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

    // Get random card for computer
    function getRandomCard(fromCard, toCard) {
        minNumber = Math.ceil(fromCard)
        maxNumber = Math.floor(toCard)
        return Math.floor(Math.random() * (maxNumber - minNumber + 1)) + minNumber;
    }

    // Computer card selection
    function computerCardSelection() {
        // Easy mode
        if(scoreCurr <= gameModeEasy) {
            switch(playerCard) {
            case 1:
                computerCard = getRandomCard(1, 4)
                break;
            case 2:
                computerCard = getRandomCard(3, 5)
                break;
            case 3:
                computerCard = getRandomCard(1, 5)
                break;
            case 4:
                computerCard = getRandomCard(1, 3)
                break;
            case 5:
                computerCard = getRandomCard(2, 5)
                break;
            }
        } else computerCard = getRandomCard(1, 5)
        showSpecificCard(computer)
    }

    // Check for new high score
    function checkIfNewHighScore() {
        if(scoreCurr > scoreMax) {
            scoreMax = scoreCurr
        }
        overallScore += scoreCurr
        gameNetwork.incrementAchievement("scoreOverall50", overallScore, true)
        gameNetwork.incrementAchievement("scoreOverall100", overallScore, true)
        gameNetwork.incrementAchievement("scoreOverall500", overallScore, true)
        gameNetwork.incrementAchievement("scoreOverall1000", overallScore, true)
        // OverallScore achievement
        if(overallScore >= 50) {
            gameNetwork.unlockAchievement("scoreOverall50", true)
        } else if(overallScore >= 100) {
            gameNetwork.unlockAchievement("scoreOverall100", true)
        } else if(overallScore >= 500) {
            gameNetwork.unlockAchievement("scoreOverall500", true)
        } else if(overallScore >= 1000) {
            gameNetwork.unlockAchievement("scoreOverall1000", true)
        }

        scoreCurr = 0;
    }

    onAchievementUnlocked: {
        achiText = "Achievement Unlocked"
    }

    // Check whos winner for this round
    // Point is to lose - so its vice versa
    function checkWinner() {
        if(playerCard === cards.Rock) {
            /* PLAYER Wins */
            if(computerCard === cards.Lizard) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }
            else if(computerCard === cards.Scissors) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }

            /* COMPUTER Wins */
            else if(computerCard === cards.Paper) {
                winnerOfTheRound = player
                scoreCurr ++
            }
            else if(computerCard === cards.Spock) {
                winnerOfTheRound = player
                scoreCurr ++
            }

            /* TIE */
            else {
                scoreCurr += 0.5
                winnerOfTheRound = none
            }
        }

        else if(playerCard === cards.Paper) {
            /* PLAYER Wins */
            if(computerCard === cards.Rock) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }
            else if(computerCard === cards.Spock) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }

            /* COMPUTER Wins */
            else if(computerCard === cards.Scissors) {
                winnerOfTheRound = player
                scoreCurr ++
            }
            else if(computerCard === cards.Lizard) {
                winnerOfTheRound = player
                scoreCurr ++
            }

            /* TIE */
            else {
                scoreCurr += 0.5
                winnerOfTheRound = none
            }
        }

        else if(playerCard === cards.Scissors) {
            /* PLAYER Wins */
            if(computerCard === cards.Paper) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }
            else if(computerCard === cards.Lizard) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }

            /* COMPUTER Wins */
            else if(computerCard === cards.Rock) {
                winnerOfTheRound = player
                scoreCurr ++
            }
            else if(computerCard === cards.Spock) {
                winnerOfTheRound = player
                scoreCurr ++
            }

            /* TIE */
            else {
                scoreCurr += 0.5
                winnerOfTheRound = none
            }
        }

        else if(playerCard === cards.Lizard) {
            /* PLAYER Wins */
            if(computerCard === cards.Spock) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }
            else if(computerCard === cards.Paper) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }

            /* COMPUTER Wins */
            else if(computerCard === cards.Rock) {
                winnerOfTheRound = player
                scoreCurr ++
            }
            else if(computerCard === cards.Scissors) {
                winnerOfTheRound = player
                scoreCurr ++
            }

            /* TIE */
            else {
                scoreCurr += 0.5
                winnerOfTheRound = none
            }
        }

        else if(playerCard === cards.Spock) {
            /* PLAYER Wins */
            if(computerCard === cards.Scissors) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }
            else if(computerCard === cards.Rock) {
                winnerOfTheRound = computer
                checkIfNewHighScore()
            }

            /* COMPUTER Wins */
            else if(computerCard === cards.Lizard) {
                winnerOfTheRound = player
                scoreCurr ++
            }
            else if(computerCard === cards.Paper) {
                winnerOfTheRound = player
                scoreCurr ++
            }

            /* TIE */
            else {
                scoreCurr += 0.5
                winnerOfTheRound = none
            }
        }

        // Current Score achievement
        if(scoreCurr >= 4) {
            gameNetwork.unlockAchievement("score4", true)
        } else if(scoreCurr >= 6) {
            gameNetwork.unlockAchievement("score6", true)
        } else if(scoreCurr >= 10) {
            gameNetwork.unlockAchievement("score10", true)
        }
    }

    // Timer for countdown between rounds
    Timer {
        repeat: true
        running: roundOverTimer > 0
        onTriggered: {
            roundOverTimer --
            if(roundOverTimer <= 0) {
                hideAllCards()
            }
        }
    }

    // Text to display timer
    Text {
        anchors.centerIn: parent
        anchors.verticalCenterOffset:  - 80
        color: "white"
        font.pixelSize: roundOverTimer > 0 ? 50 : 18
        text: roundOverTimer > 0 ? roundOverTimer : ""
    }

    // Text Display achivement
    Text {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 160
        color: "white"
        font.pixelSize: 70
        text: roundOverTimer > 0 ? achiText : ""
    }

    // Display Win, Lose or Draw
    Text {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 120
        color: "white"
        font.pixelSize: 70
        text: roundOverTimer > 0 ? outcomeOfTheRound : ""
    }

    // ClappingSound
    SoundEffectVPlay {
        id: clappingSound
        source: "../../assets/RockPaper/audio/clap.wav"
    }

    // YouSuckSound
    SoundEffectVPlay {
        id: youSuckSound
        source: "../../assets/RockPaper/audio/you-suck.wav"
    }

    SoundEffectVPlay {
        id: unrealKillingSpree
        source: "../../assets/RockPaper/audio/unrealKillingSpree.wav"
    }

    SoundEffectVPlay {
        id: unrealGodlike
        source: "../../assets/RockPaper/audio/unrealGodlike.wav"
    }

    SoundEffectVPlay {
        id: unrealMonsterKill
        source: "../../assets/RockPaper/audio/unrealMonsterKill.wav"
    }

    SoundEffectVPlay {
        id: unrealRampage
        source: "../../assets/RockPaper/audio/unrealRampage"
    }

    // Background Music
    BackgroundMusic {
        id: spockLizardMusic
        source: "../../assets/RockPaper/audio/Star_Trek_Theme.wav"
        autoPlay: false
    }

    function turnBackgroundMusicOn() {
        spockLizardMusic.play()
    }

    function turnBackgroundMusicOff() {
        spockLizardMusic.stop()
    }
}
