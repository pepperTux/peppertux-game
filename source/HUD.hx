package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxState
{
    var scoreText:FlxText;
    var distroText:FlxText;
    var livesText:FlxText;
    var unfinishedText:FlxText;

    public function new()
    {
        super();

        scoreText = new FlxText(4, 4, 0, "Score: " + Global.score, 14);
        scoreText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreText.scrollFactor.set();
        scoreText.borderSize = 1.25;

        distroText = new FlxText(0, 4, 640, "Distros: " + Global.distros, 14);
        distroText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        distroText.scrollFactor.set();
        distroText.borderSize = 1.25;

        livesText = new FlxText(0, 4, 636, "Lives: " + Global.lives, 14);
        livesText.setFormat(null, 14, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        livesText.scrollFactor.set();
        livesText.borderSize = 1.25;

        unfinishedText = new FlxText(0, 460, 640, "This game is unfinished!", 14);
        unfinishedText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        unfinishedText.scrollFactor.set();
        unfinishedText.borderSize = 1.25;

        add(scoreText);
        add(distroText);
        add(livesText);
        add(unfinishedText);
    }

    override public function update(elapsed:Float)
    {
        scoreText.text = "Score: " + (Global.score);
        distroText.text = "Distros: " + (Global.distros);
        livesText.text = "Lives: " + (Global.lives);
        super.update(elapsed);
    }
}