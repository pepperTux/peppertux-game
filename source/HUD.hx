package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxState
{
    var scoreText:FlxText;
    var distroText:FlxText;
    var livesText:FlxText;

    public function new()
    {
        super();

        scoreText = new FlxText(4, 4, 0, "Score: " + Global.score, 18);
        scoreText.setFormat(null, 18, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreText.scrollFactor.set();
        scoreText.borderSize = 1.25;

        distroText = new FlxText(0, 4, FlxG.width, "Coins: " + Global.coins, 18);
        distroText.setFormat(null, 18, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        distroText.scrollFactor.set();
        distroText.borderSize = 1.25;

        livesText = new FlxText(0, 4, 1276, "Lives: " + Global.lives, 18);
        livesText.setFormat(null, 18, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        livesText.scrollFactor.set();
        livesText.borderSize = 1.25;

        add(scoreText);
        add(distroText);
        add(livesText);
    }

    override public function update(elapsed:Float)
    {
        scoreText.text = "Score: " + (Global.score);
        distroText.text = "Coins: " + (Global.coins);
        livesText.text = "Lives: " + (Global.lives);
        super.update(elapsed);
    }
}