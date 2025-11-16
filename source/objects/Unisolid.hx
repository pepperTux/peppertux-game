package objects;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Unisolid extends FlxSprite
{
    public function new(x:Float, y:Float, width:Int, height:Int)
    {
        super(x, y);
        makeGraphic(width, height, FlxColor.TRANSPARENT);
        allowCollisions = UP;
        immovable = true;
    }
}