package creatures.tropical;

import flixel.graphics.frames.FlxAtlasFrames;

class Crab extends Enemy
{
    var crabImage = FlxAtlasFrames.fromSparrow("assets/images/characters/crab.png", "assets/images/characters/crab.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = crabImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.addByPrefix('squished', 'squished', 10, false);
        animation.play('walk');

        setSize(39, 35);
        offset.set(19, 7);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }
}
