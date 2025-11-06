package creatures;

// There's alot of Enemy.hx functions here because this extends Enemy and I don't want certain things happening.
// This uses the bonus block player detection stuff.

import objects.Fireball;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;

class IceStalactite extends Enemy
{
    // Shaking
    var shakeDuration = 0.5;
    var shakeIntensity = 0.1;
    var isShaking = false;

    // Falling
    var isBroken = false; // TODO: Replace with a state at some point?

    // Image
    var iceStalactiteImage = FlxAtlasFrames.fromSparrow("assets/images/characters/icestalactite.png", "assets/images/characters/icestalactite.xml");

    var playerDetection:FlxSprite;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        acceleration.y = 0;
        
        // Image
        frames = iceStalactiteImage;
        animation.addByPrefix("normal", "normal", 12, false);
        animation.addByPrefix("broken", "broken", 12, false);
        animation.play("normal");

        // Hitbox
        setSize(28, 42);
        offset.set(2, 0);

        immovable = true; // Set immovable to true

        playerDetection = new FlxSprite(this.x - 40, this.y);
        playerDetection.makeGraphic(Std.int(width) + 80, FlxG.height, FlxColor.TRANSPARENT);
        playerDetection.alpha = 0.5;
        playerDetection.immovable = true;
        playerDetection.solid = true;
        Global.PS.add(playerDetection);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (playerDetection.overlaps(Global.PS.tux) && !isShaking) // You don't really need to put "true" or "false" sometimes.
        {
            isShaking = true;
            immovable = false;
            damageOthers = true;
            FlxTween.shake(this, shakeIntensity, shakeDuration, X, {onComplete: fall});
        }

        playerDetection.x = x - 40;
        playerDetection.y = y;
    }

    public function fall(_)
    {
        acceleration.y = gravity;
    }

    override public function interact(tux:Tux)
    {
        if (!tux.invincible || !isBroken)
        {
            tux.takeDamage();
        }

        if (tux.invincible || isBroken) // Works fine without isBroken here, but just trying to make sure it works...
        {
            return;
        }
    }

    override private function move()
    {
        if (isBroken) // Here because super.update(elapsed); makes it so the code for hitting the floor has to be here.
        {
            animation.play("broken");
            setSize(32, 14);
            offset.set(0, 34);
            velocity.y = 2000; // Make it instantly go to the floor. I once did -2000 and it tried going to space, so don't do that.
            damageOthers = false;
            new FlxTimer().start(2.0, function(_)
            {
                kill();
            }, 1);
        }

        if (isTouching(FLOOR)) // Same comment as the one on line 104.
        {
            isBroken = true;
        }
    }

    override public function kill()
    {
        exists = false;
        alive = false;
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
        if (damageOthers == true)
        {
            otherEnemy.killFall();
        }
    }

    override public function collideFireball(fireball:Fireball)
    {
        fireball.kill();

        if (playerDetection.overlaps(Global.PS.tux) && !isShaking)
        {
            isShaking = true;
            immovable = false;
            FlxTween.shake(this, shakeIntensity, shakeDuration, X, {onComplete: fall});
        }
    }
}