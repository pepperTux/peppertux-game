package objects;

import creatures.Tux;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import states.MainMenuState;
import states.PlayState;

class Goal extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        solid = true;
        immovable = true;
        makeGraphic(2, FlxG.height * 24, FlxColor.TRANSPARENT);
    }

    public function reach(tux:Tux)
    {
        if (solid == true)
        {
            solid = false;
            Global.currentLevel += 1;
        }

        if (Global.currentLevel >= Global.levels.length)
        {
            FlxG.switchState(MainMenuState.new);
        }
        else
        {
            FlxG.switchState(PlayState.new);
        }
    }
}