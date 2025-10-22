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

enum States
{
    Small;
    Big;
    Fire;
}

class Tux extends FlxSprite
{
    // Current State
    public var currentState = States.Small;

    // Whether Tux can take damage or not
    var canTakeDamage = true;

    // Speed
    var walkSpeed = 230;
    var speed = 0; // DON'T CHANGE THIS UNLESS YOU KNOW WHAT YOU'RE DOING. You should only change walkSpeed and runSpeed.
    var runSpeed = 320;

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
            flipX = false;
        }
        else if (velocity.x < 0)
        {
            flipX = true;
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

            if (currentState == States.Small) // Play small Tux jump sound
            {
                FlxG.sound.play('assets/sounds/jump.wav');
            }
            else if (currentState == States.Big || currentState == States.Fire) // Play big Tux jump sound (It seems to be the exact same?)
            {
                FlxG.sound.play('assets/sounds/bigjump.wav');
            }
        }
        if (FlxG.keys.anyJustReleased([SPACE, UP, W]) && velocity.y < 0) // Variable Jump Height Stuff
        {
            velocity.y = decelerateOnJumpRelease;
        }

		super.update(elapsed); // Put this after the movement code, should probably also be after everything else in update.
	}

    public function takeDamage() //  Makes Tux take damage.
    {
        if (canTakeDamage == true)
        {
            canTakeDamage = false;
            new FlxTimer().start(invFrames, function(_) {canTakeDamage = true;}, 1);
            FlxG.sound.play('assets/sounds/hurt.wav');
            
            if (currentState == States.Fire) // If current state is fire, make him go down to just being big.
            {
                currentState = States.Big;
                reloadGraphics();
            }
            else if (currentState == States.Big) // If current state is big, make him go down to just being small.
            {
                currentState = States.Small;
                reloadGraphics();
            }
            else if (currentState == States.Small) // If current state is small, kill him.
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
}