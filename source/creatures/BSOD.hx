package creatures;

import flixel.graphics.frames.FlxAtlasFrames;

class BSOD extends Enemy
{
    var bsodImage = FlxAtlasFrames.fromSparrow("assets/images/characters/bsod.png", "assets/images/characters/bsod.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = bsodImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.addByPrefix('fall', 'fall', 8, false);
        animation.addByPrefix('squished', 'squished', 8, false);
        animation.play('walk');

        setSize(28, 28);
        offset.set(2, 4);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }
}
