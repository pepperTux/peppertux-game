package tiles;

import flixel.FlxSprite;

class Water extends FlxSprite
{
    var framesPS = 12;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic("assets/images/animatedtiles/waves.png", true, 32, 32);
        animation.add("normal", [0, 1, 2], framesPS, true);
        animation.play("normal");
    }
}

class Lava extends FlxSprite
{
    var framesPS = 12;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic("assets/images/animatedtiles/lavawaves.png", true, 32, 32);
        animation.add("normal", [0, 1, 2], framesPS, true);
        animation.play("normal");
    }
}