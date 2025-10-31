package worldmap;

// This and HardLevelDot created by AnatolyStev

import flixel.FlxSprite;

class LevelDot extends FlxSprite
{
    public var ldLevelPath:String;
    public var ldSection:String;
    public var isCompleted = false;
    public var ldDisplayName:String;
    public var ldLevelID:String;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        
        loadGraphic("assets/images/worldmap/leveldot.png", true, 32, 32);
        animation.add("red", [0], 1.0, true);
        animation.add("green", [1], 1.0, true);
    }

    public function setup(levelPath:String, section:String, displayName:String)
    {
        ldLevelPath = levelPath;
        ldSection = section;
        ldDisplayName = displayName;
    }

    public function completeLevel()
    {
        isCompleted = true;
        animation.play("green");
    }

    override public function update(elapsed:Float)
    {
        if (isCompleted == true)
        {
            animation.play("green");
        }
        else
        {
            animation.play("red");
        }
    }
}