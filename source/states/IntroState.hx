package states;

import flixel.FlxG;
import worldmap.WorldmapState.WorldMapState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.util.FlxColor;
import flixel.FlxState;

class IntroState extends FlxState
{
    var introText:FlxText;

    var speed = 20;
    var increaseOrDecreaseSpeed = 10;

    override public function create()
    {
        super.create();

        var bg = new FlxSprite();
        bg.loadGraphic("assets/images/cutscene/intro.png", false);
        add(bg);
        
        introText = new FlxText(-25, 716, FlxG.width, "
        Somewhere in a very cold place named Icy Island...
        there were two penguins named Tux and Penny.
        They were having a picnic, when suddenly...
        a creature came out from a small tree and attacked!
        
        When Tux woke up, he noticed Penny was gone, and there was a letter. 
        But when he read the letter, he was shocked!
        It was from a creature named Nolok, and Nolok had captured Penny!
        Tux, seeing Nolok's castle ahead, decided to go forward towards the castle, not
        knowing the difficult journey that was ahead...
        
        Press SPACE to play.", 18);
        introText.setFormat("assets/fonts/SuperTux-Medium.ttf", 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        introText.borderSize = 1.25;
        introText.moves = true;
        introText.velocity.y = -speed;
        add(introText);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(WorldMapState.new); // Switch State
        }
        
        if (FlxG.keys.justPressed.DOWN)
        {
            introText.velocity.y -= increaseOrDecreaseSpeed;
        }
        else if (FlxG.keys.justPressed.UP)
        {
            introText.velocity.y += increaseOrDecreaseSpeed;
        }
    }
}