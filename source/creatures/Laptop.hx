package creatures;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;

enum LaptopStates
{
    Normal;
    Squished;
    MovingSquished;
    Held; // Here just in case someone wants to add it.
}

class Laptop extends Enemy
{
    var laptopImage = FlxAtlasFrames.fromSparrow("assets/images/characters/laptop.png", "assets/images/characters/laptop.xml");

    public var currentLaptopState = Normal;

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
        if (currentLaptopState == MovingSquished)
        {
            velocity.x = direction * walkSpeed * 3.5;
        }
        else if (currentLaptopState == Squished || currentLaptopState == Held)
        {
            velocity.x = 0;
        }
        else
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

        if (currentLaptopState == MovingSquished)
        {
            damageOthers = true;
        }

        checkIfHerring(tux);

        FlxObject.separateY(this, tux);

        if (currentLaptopState == MovingSquished)
        {
            if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false)
            {
                waitToCollide = 0.25;
                currentLaptopState = Squished;
                Global.score += scoreAmount;
                animation.play("squished");
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
        else if (currentLaptopState == Squished)
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
            currentLaptopState = MovingSquished;
            damageOthers = true;
        }
        else
        {
            if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false)
            {
                waitToCollide = 0.25;
                Global.score += scoreAmount;
                animation.play("squished");
                currentLaptopState = Squished;
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