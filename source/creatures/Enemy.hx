package creatures;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;

class Enemy extends FlxSprite
{
    var gravity = 1000;
    var walkSpeed = 115;
    var jumpHeight = 128;
    var scoreAmount = 50;
    var bag = false;
    var direction = -1;
    var appeared = false;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        immovable = false;
        acceleration.y = gravity;
    }

    override public function update(elapsed: Float)
    {
        if (!inWorldBounds() && bag == false)
        {
            exists = false;
        }

        if (isOnScreen() && bag == false)
        {
            appeared = true;
        }

        if (bag == true)
        {
            exists = true;
            appeared = true;
        }

        if (appeared && alive && bag == false)
        {
            move();

            if (justTouched(WALL))
            {
                flipDirection();
            }
        }

        if (appeared && alive && bag == true)
        {
            move();
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
    }

    public function interact(tux:Tux)
    {
        if (!alive)
        {
            return;
        }

        FlxObject.separateY(this, tux);

        if ((tux.velocity.y > 0) && tux.y + tux.height < y + 10) // Can't just do the simple isTouching UP thing because then if the player hits the corner of the enemy, they take damage. That's not exactly fair.
        {
            if (FlxG.keys.anyPressed([SPACE, UP, W]))
            {
                tux.velocity.y -= tux.maxJumpHeight;
            }
            else
            {
                tux.velocity.y -= tux.minJumpHeight;
            }

            kill();
        }
        else
        {
            tux.takeDamage();
        }
    }

    override public function kill()
    {
        alive = false;
        Global.score += scoreAmount;
        velocity.x = 0;
        acceleration.x = 0;
        immovable = true;
        animation.play("squished");

        new FlxTimer().start(2.0, function(_)
        {
            exists = false;
            visible = false;
        }, 1);
    }
}
