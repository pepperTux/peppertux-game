package creatures;

import flixel.graphics.frames.FlxAtlasFrames;

class BouncingSnowball extends Enemy
{
    var bouncingSnowballImage = FlxAtlasFrames.fromSparrow("assets/images/characters/snowball.png", "assets/images/characters/snowball.xml");

    var bounceHeight = 512;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = bouncingSnowballImage;
        animation.addByPrefix('bounce', 'bounce', 12, true);
        animation.addByPrefix('squished', 'squished', 12, false);
        animation.play('walk');

        walkSpeed = 115;

        acceleration.y = gravity;

        setSize(30, 32);
        offset.set(4, 4);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
        
        if (justTouched(FLOOR))
        {
            velocity.y = -bounceHeight;
        }
    }
}