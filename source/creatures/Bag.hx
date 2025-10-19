package creatures;

import flixel.graphics.frames.FlxAtlasFrames;

class Bag extends Enemy
{
    var bounceHeight = 512;
    var bagImage = FlxAtlasFrames.fromSparrow("assets/images/characters/bag.png", "assets/images/characters/bag.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = bagImage;
        animation.addByPrefix('jump', 'jump', 8, false);

        immovable = false;
        acceleration.y = gravity;

        alive = true;
    }

    override private function move()
    {
        if (isTouching(FLOOR))
        {
            velocity.y = -bounceHeight;
            animation.play('jump');
        }
    }

    override public function interact(tux:Tux)
    {
        if (alive)
        {
            tux.takeDamage();
        }
    }
}
