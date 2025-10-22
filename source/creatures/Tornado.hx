package creatures;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Tornado extends Enemy
{
    // Variables for tweening
    var duration = 2;
    var amount = 100;

    var tornadoImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tornado.png", "assets/images/characters/tornado.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = tornadoImage;
        animation.addByPrefix('idle', 'idle', 8, true);
        animation.play('idle');

        tornado = true; // Same as setting bag to true. Not sure why I added this?

        moveUp(); // Move up at first

        acceleration.y = 0; // Disable gravity

        setSize(30, 34);
        offset.set(4, 2);
    }

    function moveDown(?tween:FlxTween) // ? means it's optional. Just learned that, hopefully that can help someone else. Anyways, this moves the enemy down.
    {
        FlxTween.tween(this, {y: y + amount}, duration, {ease: FlxEase.quadInOut, onComplete: moveUp});
    }

    function moveUp(?tween:FlxTween) // Moves the enemy up.
    {
        FlxTween.tween(this, {y: y - amount}, duration, {ease: FlxEase.quadInOut, onComplete: moveDown});
    }

    override public function interact(tux:Tux)
    {
        if (alive)
        {
            tux.takeDamage();
        }
    }
}