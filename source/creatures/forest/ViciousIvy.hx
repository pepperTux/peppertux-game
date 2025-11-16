package creatures.forest;

import flixel.graphics.frames.FlxAtlasFrames;

class ViciousIvy extends Enemy
{
    var viciousIvyImage = FlxAtlasFrames.fromSparrow("assets/images/characters/vicious_ivy.png", "assets/images/characters/vicious_ivy.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = viciousIvyImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.addByPrefix('squished', 'squished', 10, false);
        animation.play('walk');

        setSize(26, 19);
        offset.set(4, 20); // This isn't meant to be funny.
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }
}
