package creatures;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class Bag extends Enemy
{
    var bounceHeight = 512; // Jumping height
    var bagImage = FlxAtlasFrames.fromSparrow("assets/images/characters/bag.png", "assets/images/characters/bag.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = bagImage;
        animation.addByPrefix('jump', 'jump', 8, false);
        
        acceleration.y = gravity;

        setSize(22, 27);
        offset.set(6, 3);
    }

    override private function move()
    {
        if (isTouching(FLOOR)) // When touching floor, jump!
        {
            velocity.y = -bounceHeight;
            animation.play('jump');
        }
    }

    override public function interact(tux:Tux)
    {
        if (alive && tux.invincible == false)
        {
            tux.takeDamage();
        }

        if (tux.invincible == true)
        {
            killFall();
        }
    }

    override public function killFall()
    {
        FlxG.sound.play("assets/sounds/fall.wav");
        alive = false;
        flipY = true;
        acceleration.x = 0;
        velocity.x = fallForce;
        velocity.y = -fallForce;
        solid = false;
    }
}
