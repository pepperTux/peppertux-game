package objects;

import creatures.Tux;
import flixel.FlxG;
import flixel.FlxSprite;

class PowerUp extends FlxSprite
{
    var moveSpeed = 115;
    var moving = false;

    var mints = true;
    var coffee = false;

    var scoreAmount = 75;

    var gravity = 1000;

    var direction = 1;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        
        if (Global.PS.tux.currentState == Small)
        {
            mints = true;
            coffee = false;
            loadGraphic('assets/images/objects/mints.png', false);
        }
        else
        {
            coffee = true;
            mints = false;
            loadGraphic('assets/images/objects/coffee.png', false);
        }

        setSize(30, 16);
        offset.set(1, 16);

        solid = true;

        acceleration.y = gravity;
    }

    override public function update(elapsed:Float)
    {
        if (mints)
        {
            velocity.x = direction * moveSpeed;
        }
        
        if (coffee)
        {
            velocity.x = 0;
        }

        if (justTouched(WALL))
        {
            direction = -direction;
        }

        super.update(elapsed);
    }

    public function collect(tux:Tux)
    {
        if (mints)
        {
            FlxG.sound.play('assets/sounds/excellent.wav');
            kill();
            tux.bigTux();
            Global.score += scoreAmount;
        }
        if (coffee)
        {
            FlxG.sound.play('assets/sounds/coffee.wav');
            kill();
            tux.fireTux();
            Global.score += scoreAmount;
        }
    }
}