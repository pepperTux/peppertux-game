package creatures;

import objects.Fireball;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

enum EnemyStates
{
    Alive;
    Dead;
}

class Enemy extends FlxSprite
{
    var fallForce = 128;
    var dieFall = false;

    var damageOthers = false;

    var currentState = Alive;

    var canFireballDamage = true;

    var gravity = 1000;
    var walkSpeed = 80;
    var jumpHeight = 128;
    var scoreAmount = 50;
    var bag = false;
    var tornado = false; // Not sure why I added this?
    public var direction = -1;
    var appeared = false;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        immovable = false;
        acceleration.y = gravity;
    }

    override public function update(elapsed: Float)
    {
        if (!inWorldBounds() && (bag == false || tornado == false))
        {
            exists = false;
        }

        if (isOnScreen() && (bag == false || tornado == false))
        {
            appeared = true;
        }

        if (bag == true)
        {
            exists = true;
            appeared = true;
        }

        if (appeared && alive && (bag == false || tornado == false))
        {
            move();

            if (justTouched(WALL))
            {
                flipDirection();
            }
        }

        if (appeared && alive && (bag == false || tornado == false))
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
        checkIfHerring(tux);

        if (!alive)
        {
            return;
        }

        FlxObject.separateY(this, tux);

        if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false) // Can't just do the simple isTouching UP thing because then if the player hits the corner of the enemy, they take damage. That's not exactly fair.
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
            if (tux.invincible == false)
            {
                tux.takeDamage();
            }
        }
    }

    override public function kill()
    {
        currentState = Dead;
        
        if (dieFall == false)
        {
            FlxG.sound.play('assets/sounds/squish.wav');
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
        else
        {
            FlxG.sound.play("assets/sounds/fall.wav");
            flipY = true;
            acceleration.x = 0;
            velocity.x = fallForce;
            velocity.y = -fallForce;
            solid = false;
        }
    }

    function checkIfHerring(tux:Tux)
    {
        if (tux.invincible == true)
        {
            killFall();
        }
    }

    public function killFall()
    {
        dieFall = true;
        kill();
    }

    public function collideOtherEnemy(otherEnemy:Enemy)
    {
        if (otherEnemy.damageOthers == true)
        {
            killFall();
        }
    }

    public function collideFireball(fireball:Fireball)
    {
        fireball.kill();
        if (canFireballDamage)
        {
            killFall();
        }
    }
}
