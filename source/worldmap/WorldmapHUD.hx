package worldmap;

// Original HUD file by Vaesea
// Worldmap HUD by AnatolyStev

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class WorldmapHUD extends FlxState
{
    var worldText:FlxText;
    var scoreText:FlxText;
    var distroText:FlxText;
    var livesText:FlxText;
    var unfinishedText:FlxText;

    public function new()
    {
        super();

        var worldName = Global.worldmapName;

        worldText = new FlxText(0, 20, 640, "World: " + worldName, 14);
        worldText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        worldText.scrollFactor.set();
        worldText.borderSize = 1.25;

        scoreText = new FlxText(4, 4, 0, "Score: " + Global.score, 14);
        scoreText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreText.scrollFactor.set();
        scoreText.borderSize = 1.25;

        distroText = new FlxText(0, 4, 640, "Coins: " + Global.coins, 14);
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

        add(worldText);
        add(scoreText);
        add(distroText);
        add(livesText);
        add(unfinishedText);
    }

    override public function update(elapsed:Float)
    {
        scoreText.text = "Score: " + (Global.score);
        distroText.text = "Coins: " + (Global.coins);
        livesText.text = "Lives: " + (Global.lives);
        super.update(elapsed);
    }
}