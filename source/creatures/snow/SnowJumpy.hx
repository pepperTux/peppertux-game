package creatures.snow;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class SnowJumpy extends Enemy
{
    var bounceHeight = 576; // Jumping height
    var jumpyImage = FlxAtlasFrames.fromSparrow("assets/images/characters/snowjumpy.png", "assets/images/characters/snowjumpy.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = jumpyImage;
        animation.addByPrefix('jump', 'jump', 8, false);

        bag = true;
        
        acceleration.y = gravity;

        setSize(33, 42);
        offset.set(7, 6);
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
