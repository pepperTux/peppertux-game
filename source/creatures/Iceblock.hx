package creatures;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;

enum IceblockStates
{
    Normal;
    Squished;
    MovingSquished;
    Held; // Here just in case someone wants to add it.
}

class Iceblock extends Enemy
{
    var iceblockImage = FlxAtlasFrames.fromSparrow("assets/images/characters/iceblock.png", "assets/images/characters/iceblock.xml");

    public var currentIceblockState = Normal;

    var waitToCollide:Float = 0;

    public function new (x:Float, y:Float)
    {
        super(x, y);

        frames = iceblockImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.addByPrefix('flat', 'flat', 10, false);
        animation.play('walk');

        setSize(29, 30);
        offset.set(3, 8);
    }

    override private function move()
    {
        if (currentIceblockState == MovingSquished)
        {
            velocity.x = direction * walkSpeed * 4;
        }
        else if (currentIceblockState == Squished || currentIceblockState == Held)
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

        if (justTouched(WALL) && isOnScreen() && currentIceblockState == MovingSquished) // Doesn't work. I put a trace here just to help anybody who wants to make this work.
        {
            trace('Hit Wall!');
            FlxG.sound.play("assets/sounds/ricochet.wav", 1.0, false);
        }
    }

    override public function interact(tux:Tux)
    {
        if (!alive || waitToCollide > 0)
        {
            return;
        }

        if (currentIceblockState == MovingSquished)
        {
            damageOthers = true;
        }

        checkIfHerring(tux);

        FlxObject.separateY(this, tux);

        if (currentIceblockState == MovingSquished)
        {
            if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false)
            {
                waitToCollide = 0.25;
                currentIceblockState = Squished;
                Global.score += scoreAmount;
                animation.play("flat");
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
        else if (currentIceblockState == Squished)
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
            flipX = !tux.flipX;
            currentIceblockState = MovingSquished;
            damageOthers = true;
        }
        else
        {
            if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false)
            {
                waitToCollide = 0.25;
                Global.score += scoreAmount;
                animation.play("flat");
                currentIceblockState = Squished;
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