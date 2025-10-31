package objects;

// Worldmap support by AnatolyStev

import worldmap.WorldmapState.WorldMapState;
import creatures.Tux;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

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
        if (solid == true) // TODO: Add cutscene (feel free to remove this TODO if cutscenes are NOT being done in the future)
        {
            solid = false;
            Global.tuxState = tux.currentState;

            if (!Global.completedLevels.contains(Global.currentLevel))
            {
                Global.completedLevels.push(Global.currentLevel);
            }

            Global.saveProgress();
            FlxG.switchState(WorldMapState.new);
        }
    }
}