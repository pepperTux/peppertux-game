package objects;

import creatures.Tux;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class SolidHurt extends FlxSprite
{
    public function new(x:Float, y:Float, width:Int, height:Int)
    {
        super(x, y);
        makeGraphic(width, height, FlxColor.TRANSPARENT);
        solid = true;
        immovable = true;
    }
}