package enemies;

// Tutorials Used:
// Discover HaxeFlixel (It's a book)

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class RightBSOD extends FlxSprite
{
    // Gravity
    var gravity = 1000;
    
    // Speed
    var walkSpeed = 130;
    var speed = 0; // Don't change this!

    // Direction (-1 = Left, 1 = Right)
    var direction = 1;

    // Whether the enemy has appeared on screen or not
    var appeared = false;

    // Enemy Image
    var enemyImageRight = FlxAtlasFrames.fromSparrow("assets/images/characters/bsod.png", "assets/images/characters/bsod.xml");

    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        flipX = !flipX;

        // Add gravity
        acceleration.y = gravity;

        // Add frames and stuff idk
        frames = enemyImageRight;
        animation.addByPrefix('walk', 'walk', 12, true);
        animation.addByPrefix('fall', 'fall', 12, false);
        animation.addByPrefix('squished', 'squished', 12, false);
        animation.play('walk');
    }
    
    override public function update(elapsed:Float)
    {
        if (!inWorldBounds()) // if NOT in world bounds
        {
            exists = false;
        }
        if (isOnScreen())
        {
            appeared = true;
        }
        if (appeared && alive)
        {
            move();

            if (justTouched(WALL))
            {
                flipDirection();
            }
        }

        super.update(elapsed);
    }

    function flipDirection()
    {
        flipX = !flipX;
        direction = -direction;
    }

    function move()
    {
        velocity.x = direction * walkSpeed;
    }

    public function interact(tux:Tux)
    {
        if (!alive)
        {
            return;
        }

        FlxObject.separateY(this, tux);

        if ((tux.velocity.y > 0) && (isTouching(UP)))
        {
            animation.play('squished');
            acceleration.y = 0;
            velocity.y = 0;
            offset.y = -24;
            velocity.x = 0;
            alive = false;
            var timer = new haxe.Timer(2000);
            timer.run = function() { kill(); }
            if (FlxG.keys.anyPressed([SPACE, UP, W]))
            {
                tux.velocity.y = -tux.maxJumpHeight;
            }
            else
            {
                tux.velocity.y = -tux.minJumpHeight / 2;
            }
        }
        else
        {
            tux.take_damage();
        }
    }
}