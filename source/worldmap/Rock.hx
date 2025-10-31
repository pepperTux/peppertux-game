package worldmap;

// Added by AnatolyStev

import flixel.FlxSprite;

class Rock extends FlxSprite
{
    public var rockSection = "";
    public var rockPosition = ""; // You SHOULD put beforeHardLevel or afterHardLevel
    public var isGone = false;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic("assets/images/worldmap/rock.png", false, 32, 32);

        solid = true;
        immovable = true;
    }

    public function theRock(section:String, positionType:String)
    {
        rockSection = section;
        rockPosition = positionType;
    }
    
    public function removeRock()
    {
        if (isGone == true)
        {
            return;
        }

        isGone = true;
        kill();
    }
}