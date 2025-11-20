package creatures.forest.ghost;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;

// Made by Vaesea and AnatolyStev (A fix for hitting the thing)

class FatBat extends Enemy
{
    var fatBatImage = FlxAtlasFrames.fromSparrow("assets/images/characters/fatbat.png", "assets/images/characters/fatbat.xml");

    var bounceHeight = 512;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = fatBatImage;
        animation.addByPrefix('bounce', 'bounce', 12, true);
        animation.addByPrefix('squished', 'squished', 12, false);
        animation.play('bounce');

        acceleration.y = gravity;

        setSize(32, 36);
        offset.set(15, 6);
    }

    override public function update(elapsed:Float)
    {   
        if (justTouched(FLOOR))
        {
            velocity.y = -bounceHeight;
        }

        super.update(elapsed);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }

    override public function interact(tux:Tux)
    {
        checkIfHerring(tux);

        if (!alive)
        {
            return;
        }

        FlxObject.separateY(tux, this);

        if (tux.y + tux.height <= y + 8 && !tux.invincible) // Thought that when adding holding to Iceblock I'd fix THIS thing too.
        {
            if (FlxG.keys.anyPressed([SPACE, UP, W]))
            {
                tux.velocity.y = -tux.maxJumpHeight;
            }
            else
            {
                tux.velocity.y = -tux.minJumpHeight / 2;
            }

            kill();
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