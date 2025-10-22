package objects;

import creatures.Tux;
import flixel.FlxG;
import flixel.FlxSprite;

class Mints extends FlxSprite
{
    var moveSpeed = 115;
    var moving = false;

    var scoreAmount = 75;

    var gravity = 1000;

    var direction = 1;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic('assets/images/objects/mints.png', false);

        setSize(30, 16);
        offset.set(1, 16);

        solid = true;

        acceleration.y = gravity;
    }

    override public function update(elapsed:Float)
    {
        velocity.x = direction * moveSpeed;

        if (justTouched(WALL))
        {
            direction = -direction;
        }

        super.update(elapsed);
    }

    public function collect(tux:Tux)
    {
        FlxG.sound.play('assets/sounds/excellent.wav');
        kill();
        tux.bigTux();
        Global.score += scoreAmount;
    }
}