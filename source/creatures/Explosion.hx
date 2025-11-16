package creatures;

import objects.Fireball;
import flixel.util.FlxTimer;
import creatures.Enemy;
import creatures.Tux;
import flixel.graphics.frames.FlxAtlasFrames;

class Explosion extends Enemy
{
    var explosionImage = FlxAtlasFrames.fromSparrow("assets/images/objects/explosion.png", "assets/images/objects/explosion.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = explosionImage;
        animation.addByPrefix('explosion', 'explosion', 6, true);
        animation.play('explosion');

        damageOthers = true;

        setSize(75, 44);
        offset.set(17, 20);

        new FlxTimer().start(1.0, function(_)
            {
                alive = false;
                exists = false;
            }, 1);
    }

    override public function interact(tux:Tux)
    {
        if (!alive || tux.invincible)
        {
            return;
        }
        
        if (overlaps(tux))
        {
            tux.takeDamage();
        }
    }

    override public function kill()
    {
        return;
    }

    override private function checkIfHerring(tux:Tux)
    {
        return;
    }

    override public function killFall()
    {
        return;
    }

    override public function collideOtherEnemy(otherEnemy:Enemy)
    {
        return;
    }

    override public function collideFireball(fireball:Fireball)
    {
        fireball.kill();
    }
}