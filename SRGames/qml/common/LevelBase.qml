import QtQuick 2.0

Item {
    // this will be displayed in the GameScene
    property string levelName
    property int divider: 6
    property int spockMarginBottom: 10
    property int spockMarginLeft: 7
    // this is emitted whenever the rectangle has been tapped successfully, the GameScene will listen to this signal and increase the score
    signal rectanglePressed
    property int score

    signal highscoreAchieved(int highscore)
    signal achievementUnlock(int id)
    // Signals

}
