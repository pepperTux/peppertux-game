package creatures.tropical;

import flixel.graphics.frames.FlxAtlasFrames;

class Grab extends Enemy
{
    var grabImage = FlxAtlasFrames.fromSparrow("assets/images/characters/grab.png", "assets/images/characters/grab.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = grabImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.addByPrefix('squished', 'squished', 10, false);
        animation.play('walk');

        walkSpeed = 115;

        setSize(39, 35);
        offset.set(19, 7);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }
}
