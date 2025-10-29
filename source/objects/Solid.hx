package objects;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Solid extends FlxSprite
{
    public function new(x:Float, y:Float, width:Int, height:Int)
    {
        super(x, y);
        makeGraphic(width, height, FlxColor.TRANSPARENT); // We need Std.int because it reads width / height as floats for some reason without it? Or at least I think that's what is happening.
        solid = true;
        immovable = true;
    }
}