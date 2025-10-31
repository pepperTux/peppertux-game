package creatures;

import flixel.util.FlxTimer;
import creatures.Explosion;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;

enum BombStates
{
    Normal;
    Exploding;
    Dead;
}

class Bomb extends Enemy
{
    var explodeTimer = 1.0;

    var currentBombState = Normal;

    var bombImage = FlxAtlasFrames.fromSparrow("assets/images/characters/mrbomb.png", "assets/images/characters/mrbomb.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = bombImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.addByPrefix('exploding', 'exploding', 2, true);
        animation.play('walk');
        
        acceleration.y = gravity;

        setSize(28, 35);
        offset.set(4, 10);
    }

    override private function move()
    {
        // Ground Detectors
        var groundDetectorX = if (direction == 1) { x + this.width + 1; } else { x + 1; }
        var groundDetectorY = y + this.height + 1;

        // Use PlayState's Map
        var map = Global.PS.map;

        // Things
        var tileX = Std.int(groundDetectorX / map.tileWidth);
        var tileY = Std.int(groundDetectorY / map.tileHeight);

        // Check for no tiles
        if (map.getTileIndex(tileX, tileY) == 0 && currentState == Alive) // This is why there needs to be Std.int
        {
            flipDirection();
        }

        if (currentBombState == Normal)
        {
            velocity.x = direction * walkSpeed;
        }
        else
        {
            velocity.x = 0;
        }
    }

    override public function interact(tux:Tux)
    {
        checkIfHerring(tux);

        if (!alive || currentBombState == Exploding)
        {
            return;
        }

        FlxObject.separateY(tux, this);

        if (tux.velocity.y > 0 && tux.y + tux.height < y + 10 && tux.invincible == false) // Can't just do the simple isTouching UP thing because then if the player hits the corner of the enemy, they take damage. That's not exactly fair.
        {
            if (FlxG.keys.anyPressed([SPACE, UP, W]))
            {
                tux.velocity.y = -tux.maxJumpHeight;
            }
            else
            {
                tux.velocity.y = -tux.minJumpHeight / 2;
            }

            startExploding();
        }
        else
        {
            if (tux.invincible == false)
            {
                tux.takeDamage();
            }
        }
    }

    function startExploding()
    {
        animation.play('exploding');
        currentBombState = Exploding;
        currentState = Dead;
        new FlxTimer().start(1.0, function(_)
            {
                var explosion:Explosion = new Explosion(this.x - 20, this.y - 9);
                Global.PS.enemies.add(explosion);
                FlxG.sound.play('assets/sounds/explode.wav');
                alive = false;
                exists = false;
            }, 1);
    }
}