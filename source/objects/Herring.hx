package objects;

import creatures.Tux;
import flixel.FlxG;
import flixel.FlxSprite;

class Herring extends FlxSprite
{
    var scoreAmount = 100;
    var moveSpeed = 160;
    var gravity = 1000;
    var jumpHeight = 320;

    var direction = 1;

    public function new (x:Float, y:Float)
    {
        super(x, y);
        loadGraphic("assets/images/objects/golden-herring.png", false);

        setSize(30, 12);
        offset.set(1, 10);
        
        acceleration.y = gravity;
    }

    override public function update(elapsed:Float)
    {
        velocity.x = direction * moveSpeed;

        if (justTouched(FLOOR))
        {
            velocity.y = -jumpHeight;
        }

        if (justTouched(WALL))
        {
            direction = -direction;
        }

        super.update(elapsed);
    }

    public function collect(tux:Tux)
    {
        FlxG.sound.play('assets/sounds/herring.wav');
        kill();
        tux.herringTux();
        Global.score += scoreAmount;
    }
}