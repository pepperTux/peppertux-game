package creatures;

import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class FlyingSnowball extends Enemy
{
    // Variables for tweening
    var duration = 2;
    var amount = 100;

    var fsImage = FlxAtlasFrames.fromSparrow("assets/images/characters/flyingsnowball.png", "assets/images/characters/flyingsnowball.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = fsImage;
        animation.addByPrefix('fly', 'fly', 12, true);
        animation.addByPrefix('squished', 'squished', 12, false);
        animation.play('fly');

        tornado = true; // Same as setting bag to true. Not sure why I added this?

        moveUp(); // Move up at first

        acceleration.y = 0; // Disable gravity

        setSize(34, 34);
        offset.set(3, 2);
    }

    function moveDown(?tween:FlxTween) // ? means it's optional. Just learned that, hopefully that can help someone else. Anyways, this moves the enemy down.
    {
        if (alive)
        {
            FlxTween.tween(this, {y: y + amount}, duration, {ease: FlxEase.quadInOut, onComplete: moveUp});
        }
    }

    function moveUp(?tween:FlxTween) // Moves the enemy up.
    {
        if (alive)
        {
            FlxTween.tween(this, {y: y - amount}, duration, {ease: FlxEase.quadInOut, onComplete: moveDown});
        }
    }

    override public function kill()
    {
        FlxTween.cancelTweensOf(this);

        currentState = Dead;
        
        if (dieFall == false)
        {
            FlxG.sound.play('assets/sounds/squish.wav');
            alive = false;
            Global.score += scoreAmount;
            velocity.x = 0;
            acceleration.x = 0;
            immovable = true;
            animation.play("squished");

            new FlxTimer().start(2.0, function(_)
            {
                exists = false;
                visible = false;
            }, 1);
        }
        else
        {
            FlxG.sound.play("assets/sounds/fall.wav");
            flipY = true;
            acceleration.x = 0;
            velocity.x = fallForce;
            velocity.y = -fallForce;
            solid = false;
        }
    }
}