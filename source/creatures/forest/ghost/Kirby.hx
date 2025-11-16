package creatures.forest.ghost;

import flixel.graphics.frames.FlxAtlasFrames;

class Kirby extends Enemy
{
    var kirbyImage = FlxAtlasFrames.fromSparrow("assets/images/characters/kirby.png", "assets/images/characters/kirby.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = kirbyImage;
        animation.addByPrefix('walk', 'walk', 20, true);
        animation.addByPrefix('squished', 'squished', 10, false);
        animation.play('walk');

        setSize(34, 38);
        offset.set(9, 15); // This isn't meant to be funny.
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }
}
