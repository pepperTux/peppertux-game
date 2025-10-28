package substates;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import states.MainMenuState;

class IntroSubState extends FlxSubState
{
    var readyText:FlxText;
    var titleText:FlxText;
    var creatorText:FlxText;

    var gameOver = false;
    var waitTime = 2;

    override public function create()
    {
        super.create();

        if (FlxG.sound.music != null) // Check if song is playing, if it is, stop song. This if statement is here just to avoid a really weird crash.
        {
            FlxG.sound.music.stop();
        }

        if (Global.lives == 0 || Global.lives <= 0)
        {
            gameOver = true;
        }

        titleText = new FlxText(0, 5, 0, Global.levelName, 14);
        titleText.setFormat(null, 14, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
        titleText.scrollFactor.set();
        titleText.screenCenter(X);
        titleText.borderSize = 1.25;

        creatorText = new FlxText(0, 21, 0, Global.creatorOfLevel, 14);
        creatorText.setFormat(null, 14, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
        creatorText.scrollFactor.set();
        creatorText.screenCenter(X);
        creatorText.borderSize = 1.25;

        readyText = new FlxText(0, 0, 0, "Get Ready!", 14);
        readyText.setFormat(null, 14, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
        readyText.scrollFactor.set();
        readyText.screenCenter();
        readyText.borderSize = 1.25;

        add(titleText);
        add(creatorText);
        add(readyText);

        if (gameOver)
        {
            titleText.visible = false;
            creatorText.visible = false;
            readyText.text = "Game Over";
        }

        new FlxTimer().start(waitTime, function(_)
        {
            if (gameOver)
            {
                FlxG.switchState(MainMenuState.new);
            }
            else
            {
                if (Global.currentSong != null) // If it's null and this isn't done, the game will crash.
                {
                    FlxG.sound.playMusic(Global.currentSong, 1.0, true);
                }
                close();
            }
        } , 1);
    }
}