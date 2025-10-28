package creatures;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class Jumpy extends Enemy
{
    var bounceHeight = 576; // Jumping height
    var jumpyImage = FlxAtlasFrames.fromSparrow("assets/images/characters/jumpy.png", "assets/images/characters/jumpy.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = jumpyImage;
        animation.addByPrefix('jump', 'jump', 8, false);
        
        acceleration.y = gravity;

        setSize(31, 37);
        offset.set(8, 9);
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
