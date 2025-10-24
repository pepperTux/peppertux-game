package creatures;

// Tutorials Used:
// https://www.youtube.com/watch?v=Qdq-vXt-NOE
// https://www.youtube.com/watch?v=aQazVHDztsg and yes i know this is for godot but it was actually helpful for this

// I added lots of comments just in case someone wanted to do make a mod of this recreation but doesn't know how to code.

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxDirectionFlags;
import flixel.util.FlxTimer;
import objects.Ball;

enum TuxStates
{
    Small;
    Big;
    Fire;
}

class Tux extends FlxSprite
{
    // Current State
    public var currentState = Small;

    // Coffee Ball Stuff
    var canShoot = true;
    var shootCooldown = 0.3;

    // Invicibility Power-Up (Herring)
    var herringDuration = 10.0;
    public var invincible = false;
    var smallCape:FlxSprite;
    var bigCape:FlxSprite;

    // Whether Tux can take damage or not
    var canTakeDamage = true;

    // Speed
    var walkSpeed = 230;
    var speed = 0; // DON'T CHANGE THIS UNLESS YOU KNOW WHAT YOU'RE DOING. You should only change walkSpeed and runSpeed.
    var runSpeed = 320;

    // Direction
    public var direction = 1;

    // Jump stuff and Gravity
    public var minJumpHeight = 512; // Jump Height (Minimum)
    public var maxJumpHeight = 576; // Jump Height (Maximum)
    var gravity = 1000; // Gravity, I don't recommend changing this but you can if you want low gravity or high gravity.
    var decelerateOnJumpRelease = 0.5; // thanks godot tutorial that i used. also dont change this

    // Coin Stuff
	public var totalDistros = 0;

    // Invincibility Frames
    var invFrames = 1.0;

    // Images, if replaced, make sure the replacement image has the same animations!
    var smallTuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/smalltux.png", "assets/images/characters/tux/smalltux.xml");
    var bigTuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/tux.png", "assets/images/characters/tux/tux.xml");
    var fireTuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/firetux.png", "assets/images/characters/tux/firetux.xml");

    // You probably shouldn't change any of the below if you're making a mod.
    public function new()
    {
        super();

        smallTuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/smalltux.png", "assets/images/characters/tux/smalltux.xml");
        bigTuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/tux.png", "assets/images/characters/tux/tux.xml");
        fireTuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/firetux.png", "assets/images/characters/tux/firetux.xml");
        
        drag.x = 4800; // Add Deceleration
        acceleration.y = gravity; // Add Gravity

        switch(currentState)
        {
            case Small:
                frames = smallTuxImage;
            case Big:
                frames = bigTuxImage;
            case Fire:
                frames = fireTuxImage;
        }

        // I doubt some of this is actually needed, like the solid = false stuff, but I'm adding it anyways! What could possibly go wrong?
        smallCape = new FlxSprite(this.x, this.y);
        bigCape = new FlxSprite(this.x, this.y);
        smallCape.loadGraphic("assets/images/characters/tux/cape.png", true, 32, 32);
        bigCape.loadGraphic("assets/images/characters/tux/bigcape.png", true, 64, 64);
        smallCape.animation.add("normal", [0, 1], 16, true);
        bigCape.animation.add("alsonormal", [0, 1], 16, true); // Just trying to prevent flickering between the 2 capes!
        smallCape.setSize(32, 32);
        bigCape.setSize(32, 32);
        smallCape.solid = false;
        bigCape.solid = false;
        smallCape.visible = false;
        bigCape.visible = false;

        reloadGraphics();
    }

	override public function update(elapsed:Float)
	{
        // these will have to be changed if options are added that would allow the player to change keybinds or whatever it's called
        // Left + A = Go Left, Right + D = Go Right, Control = Run, Down + S = Duck (NOT ADDED YET!!!), Space + Up + W = Jump
        // i was gonna use the official haxeflixel way of doing variable jumping (using elapsed:float stuff) so that's why movement stuff is here. might still use it if the godot tutorial method turns out to not work that well for this, so don't move any of this stuff yet!

        #if debug
        if (FlxG.keys.justPressed.ONE)
        {
            currentState = Small;
            reloadGraphics();
        }
        else if (FlxG.keys.justPressed.TWO)
        {
            currentState = Big;
            reloadGraphics();
        }
        else if (FlxG.keys.justPressed.THREE)
        {
            currentState = Fire;
            reloadGraphics();
        }
        else if (FlxG.keys.justPressed.FOUR)
        {
            invincible = true;
        }
        #end

        // Make sure Tux cant escape the level through the left side of the screen
        if (x < 0)
        {
            x = 0;
        }

        // If Tux is below level, kill him
        if (y > Global.PS.map.height - height)
        {
            die();
        }

        // Tux animation stuff
        if (velocity.x != 0)
        {
            animation.play('walk');
        }
        else if (velocity.x == 0)
        {
            animation.play('stand');
        }
        if (velocity.x > 0)
        {
            direction = 1;
            flipX = false;
            smallCape.flipX = true;
            bigCape.flipX = true;
            smallCape.offset.x = 6;
            bigCape.offset.x = 28;
        }
        else if (velocity.x < 0)
        {
            direction = -1;
            flipX = true;
            smallCape.flipX = false;
            bigCape.flipX = false;
            smallCape.offset.x = 4;
            bigCape.offset.x = 4;
        }
        if ((velocity.y > 0 || velocity.y < 0) && currentState != Small)
        {
            animation.play('jump');
        }

        // Stuff to move Tux
        if (FlxG.keys.anyPressed([CONTROL])) // Running
        {
            speed = runSpeed;
        }
        else 
        {
            speed = walkSpeed;
        }
        if (FlxG.keys.anyPressed([LEFT, A]) && !FlxG.keys.anyPressed([RIGHT, D])) // Moving Left
        {
            velocity.x = -speed;
        }
        if (FlxG.keys.anyPressed([RIGHT, D]) && !FlxG.keys.anyPressed([LEFT, A])) // Moving Right
        {
            velocity.x = speed;
        }
        if (FlxG.keys.anyPressed([SPACE, UP, W]) && isTouching(FlxDirectionFlags.FLOOR)) // Jumping
        {
            if (velocity.x == 320 || velocity.x == -320)
            {
                velocity.y = -maxJumpHeight;
            }
            else
            {
                velocity.y = -minJumpHeight;
            }

            if (currentState == Small) // Play small Tux jump sound
            {
                FlxG.sound.play('assets/sounds/jump.wav');
            }
            else if (currentState == Big || currentState == Fire) // Play big Tux jump sound (It seems to be the exact same?)
            {
                FlxG.sound.play('assets/sounds/bigjump.wav');
            }
        }
        if (FlxG.keys.anyJustReleased([SPACE, UP, W]) && velocity.y < 0) // Variable Jump Height Stuff
        {
            velocity.y = decelerateOnJumpRelease;
        }

        if (invincible)
        {
            smallCape.x = this.x;
            smallCape.y = this.y;
            bigCape.x = this.x;
            bigCape.y = this.y;
            smallCape.animation.play("normal");
            bigCape.animation.play("alsonormal");

            if (currentState == Small)
            {
                smallCape.visible = true;
                Global.PS.items.add(smallCape); // Is this what they call a hack? Feel like capes should be in their own group.
            }
            else
            {
                smallCape.visible = false;
            }

            if (currentState == Big || currentState == Fire)
            {
                bigCape.visible = true;
                Global.PS.items.add(bigCape);
            }
            else
            {
                bigCape.visible = false;
            }
        }
        else
        {
            smallCape.visible = false;
            bigCape.visible = false;
        }

        shootBall();

		super.update(elapsed); // Put this after the movement code, should probably also be after everything else in update.
	}

    public function takeDamage() //  Makes Tux take damage.
    {
        if (canTakeDamage == true)
        {
            canTakeDamage = false;
            new FlxTimer().start(invFrames, function(_) {canTakeDamage = true;}, 1);
            FlxG.sound.play('assets/sounds/hurt.wav');
            
            if (currentState == Fire) // If current state is fire, make him go down to just being big.
            {
                currentState = Big;
                reloadGraphics();
            }
            else if (currentState == Big) // If current state is big, make him go down to just being small.
            {
                currentState = Small;
                reloadGraphics();
            }
            else if (currentState == Small) // If current state is small, kill him.
            {
                die();
            }
        }
    }
    
    public function die() // Tux dies. This will be changed to not just do this.
    {
        canTakeDamage = false;
        Global.lives -= 1;
        Global.distros = 0;
        FlxG.resetState();
    }

    function reloadGraphics()
    {
        animation.reset();

        switch(currentState)
        {
            case Small:    
                var fixedMaybeOne = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/smalltux.png", "assets/images/characters/tux/smalltux.xml");
                frames = fixedMaybeOne;

                animation.addByPrefix('stand', 'stand', 10, false);
                animation.addByPrefix('walk', 'walk', 10, true);
                animation.play('stand');

                setSize(20, 30);
                offset.set(6, 2);
            case Big:
                var fixedMaybeTwo = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/tux.png", "assets/images/characters/tux/tux.xml");
                frames = fixedMaybeTwo;
                animation.addByPrefix('stand', 'stand', 10, false);
                animation.addByPrefix('walk', 'walk', 10, true);
                animation.addByPrefix('jump', 'jump', 10, false);
                animation.addByPrefix('duck', 'duck', 10, false);
                animation.play('stand');
                setSize(32, 60);
                offset.set(8, 4);
            case Fire:
                var fixedMaybeThree = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/firetux.png", "assets/images/characters/tux/firetux.xml");
                frames = fixedMaybeThree;
                animation.addByPrefix('stand', 'stand', 10, false);
                animation.addByPrefix('walk', 'walk', 10, true);
                animation.addByPrefix('jump', 'jump', 10, false);
                animation.addByPrefix('duck', 'duck', 10, false);
                animation.play('stand');
                setSize(32, 60);
                offset.set(8, 4);
        }
    }

    public function bigTux()
    {
        if (currentState == Small)
        {
            var smallHeight = height;
            currentState = Big;
            reloadGraphics();
            y -= height - smallHeight;
        }
    }

    public function fireTux()
    {
        if (currentState == Small)
        {
            var smallHeight = height;
            currentState = Fire;
            reloadGraphics();
            y -= height - smallHeight;
        }
        else
        {
            currentState = Fire;
            reloadGraphics();
        }
    }

    public function herringTux()
    {
        var previousSong = Global.currentSong;

        FlxG.sound.playMusic("assets/music/salcon.ogg", 1, true);

        invincible = true;

        new FlxTimer().start(herringDuration, function(_)
        {
            FlxG.sound.playMusic(previousSong, 1.0, true);
            invincible = false;
        });
    }

    function shootBall()
    {
        if (currentState != Fire)
        {
            return;
        }

        if (FlxG.keys.justPressed.CONTROL && canShoot)
        {
            var ball:Ball = new Ball(x + 16, y + 16);
            ball.direction = direction;
            Global.PS.items.add(ball);
            FlxG.sound.play("assets/sounds/shoot.wav");

            canShoot = false;
            new FlxTimer().start(shootCooldown, function(_) canShoot = true);
        }
    }
}