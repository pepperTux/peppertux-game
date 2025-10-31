package worldmap;

// Made by AnatolyStev

import flixel.FlxG;
import flixel.FlxSprite;

enum WorldmapTuxStates
{
    Small;
    Big;
    Fire;
}

class TuxWorldmap extends FlxSprite
{
    var walkSpeed = 128;
    var deceleration = 1600;

    public function new()
    {
        super();
        loadGraphic("assets/images/worldmap/bigtux.png", false, 32, 32);
        drag.set(deceleration, deceleration);
        setSize(15, 6);
        offset.set(8, 22);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.anyPressed([LEFT, A]))
        {
            velocity.x = -walkSpeed;
        }
        else if (FlxG.keys.anyPressed([RIGHT, D]))
        {
            velocity.x = walkSpeed;
        }
        
        if (FlxG.keys.anyPressed([DOWN, S]))
        {
            velocity.y = walkSpeed;
        }
        else if (FlxG.keys.anyPressed([UP, W]))
        {
            velocity.y = -walkSpeed;
        }
    }
}