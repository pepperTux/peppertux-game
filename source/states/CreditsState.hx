package states;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxState;

class CreditsState extends FlxState
{
    var creditsText:FlxText;

    var speed = 20;
    var increaseOrDecreaseSpeed = 10;

    override public function create()
    {
        super.create();

        var bg = new FlxSprite();
        bg.loadGraphic("assets/images/menu/title.png", false);
        add(bg);
        
        creditsText = new FlxText(-25, 470, 0, "
        Vaesea - Coding, Levels\n
        Convival - Levels\n
        AnatolyStev - Coding, Levels\n
        SuperTux Team - Original SuperTux assets, both from Milestone 1 and Milestone 2\n
        Grumbel - Original SuperTux art, both from Milestone 1 and Milestone 2\n
        Stephen Groundwater - Original SuperTux art, both from Milestone 1 and Milestone 2\n
        Wansti - Original SuperTux music, both from Milestone 1 and Milestone 2\n
        Lukas Nystrand (Mortimer Twang) - Mortimer's Chipdisko\n
        Mystical - Salcon\n
        Discover Haxeflixel - Book / pdf I used to make the base of this game, HaxeTux\n
        Larry Ewing - Creator of Tux\n
        Press Space to go back to the Main Menu", 12);
        creditsText.setFormat(null, 12, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        creditsText.borderSize = 1.25;
        creditsText.moves = true;
        creditsText.velocity.y = -speed;
        add(creditsText);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(MainMenuState.new); // Switch State
        }
        
        if (FlxG.keys.justPressed.DOWN)
        {
            creditsText.velocity.y -= increaseOrDecreaseSpeed;
        }
        else if (FlxG.keys.justPressed.UP)
        {
            creditsText.velocity.y += increaseOrDecreaseSpeed;
        }
    }
}