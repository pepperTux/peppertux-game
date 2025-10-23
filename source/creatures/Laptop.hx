package creatures;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;

class Laptop extends Enemy
{
    var laptopImage = FlxAtlasFrames.fromSparrow("assets/images/characters/laptop.png", "assets/images/characters/laptop.xml");

    var isSquished = false;
    var isMovingSquished = false;
    var waitToCollide:Float = 0;

    public function new (x:Float, y:Float)
    {
        super(x, y);

        frames = laptopImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.addByPrefix('fall', 'fall', 8, false);
        animation.addByPrefix('squished', 'squished', 8, false);
        animation.play('walk');

        setSize(20, 28);
        offset.set(7, 4);
    }

    override private function move()
    {
        if (isMovingSquished)
        {
            velocity.x = direction * walkSpeed * 3;
        }
        else if (!isSquished)
        {
            velocity.x = direction * walkSpeed;
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (waitToCollide > 0)
        {
            waitToCollide -= elapsed;
        }
    }

    override public function interact(tux:Tux)
    {
        if (!alive || waitToCollide > 0)
        {
            return;
        }

        if (isMovingSquished)
        {
            damageOthers = true;
        }

        checkIfHerring(tux);

        FlxObject.separateY(this, tux);

        if (isMovingSquished)
        {
            if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false)
            {
                waitToCollide = 0.25;
                isMovingSquished = false;
                Global.score += scoreAmount;
                animation.play("squished");
                isSquished = true;
                velocity.x = 0;
                if (FlxG.keys.anyPressed([SPACE, UP, W]))
                {
                    tux.velocity.y -= tux.maxJumpHeight;
                }
                else
                {
                    tux.velocity.y -= tux.minJumpHeight;
                }
            }
            else
            {
                if (tux.invincible == false)
                {
                    tux.takeDamage();
                }
            }
        }
        else if (isSquished)
        {
            if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false)
            {
                if (FlxG.keys.anyPressed([SPACE, UP, W]))
                {
                    tux.velocity.y -= tux.maxJumpHeight;
                }
                else
                {
                    tux.velocity.y -= tux.minJumpHeight;
                }
            }

            waitToCollide = 0.25;

            direction = tux.direction;
            isMovingSquished = true;
            damageOthers = true;
        }
        else
        {
            if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false)
            {
                waitToCollide = 0.25;
                Global.score += scoreAmount;
                animation.play("squished");
                isSquished = true;
                velocity.x = 0;
                if (FlxG.keys.anyPressed([SPACE, UP, W]))
                {
                    tux.velocity.y -= tux.maxJumpHeight;
                }
                else
                {
                    tux.velocity.y -= tux.minJumpHeight;
                }
            }
            else
            {
                if (tux.invincible == false)
                {
                    tux.takeDamage();
                }
            }
        }
    }
}