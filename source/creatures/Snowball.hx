package creatures;

import flixel.graphics.frames.FlxAtlasFrames;

class Snowball extends Enemy
{
    var snowballImage = FlxAtlasFrames.fromSparrow("assets/images/characters/snowball.png", "assets/images/characters/snowball.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = snowballImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.addByPrefix('squished', 'squished', 10, false);
        animation.play('walk');

        setSize(30, 32);
        offset.set(4, 4);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }
}
