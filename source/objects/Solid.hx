package objects;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Solid extends FlxSprite
{
    public function new(x:Float, y:Float, width:Int, height:Int)
    {
        super(x, y);
        makeGraphic(width, height, FlxColor.TRANSPARENT);
        solid = true;
        immovable = true;
    }
}