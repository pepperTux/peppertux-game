package objects;

import flixel.FlxSprite;

class Fireball extends FlxSprite
{
    var moveSpeed = 440;
    var jumpHeight = 320;
    var gravity = 1000;

    public var direction = -1;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        loadGraphic("assets/images/objects/firebullet.png", false); // REPLACE WITH SPRITESHEET!

        acceleration.y = gravity;
    }

    override public function update(elapsed:Float)
    {
        velocity.x = direction * moveSpeed;

        if (justTouched(FLOOR))
        {
            velocity.y -= jumpHeight;
        }

        if (justTouched(WALL))
        {
            kill();
        }

        super.update(elapsed);
    }
}