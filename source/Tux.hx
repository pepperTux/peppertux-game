package;

// Tutorials Used:
// https://www.youtube.com/watch?v=Qdq-vXt-NOE
// https://www.youtube.com/watch?v=aQazVHDztsg and yes i know this is for godot but it was actually helpful for this

// I added lots of comments just in case someone wanted to do make a mod of this recreation but doesn't know how to code.

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxDirectionFlags;

enum States
{
    Small;
    Big;
    Fire;
}

class Tux extends FlxSprite
{
    // Current State
    var currentState = States.Small;

    // Whether Tux can take damage or not
    var canTakeDamage = true;

    // Speed
    var walkSpeed = 230;
    var speed = 0; // DON'T CHANGE THIS UNLESS YOU KNOW WHAT YOU'RE DOING. You should only change walkSpeed and runSpeed.
    var runSpeed = 320;

    // Jump stuff and Gravity
    public var minJumpHeight = 512; // Jump Height (Minimum)
    public var maxJumpHeight = 544; // Jump Height (Maximum)
    var gravity = 1000; // Gravity, I don't recommend changing this but you can if you want low gravity or high gravity.
    var decelerateOnJumpRelease = 0.5; // thanks godot tutorial that i used. also dont change this

    // Coin Stuff
	public var totalDistros = 0;

    // Image, if replaced, make sure the replacement image has the same animations!
    var tuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/smalltux.png", "assets/images/characters/tux/smalltux.xml");

    // You probably shouldn't change any of the below if you're making a mod.
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);
        
        drag.x = 2400; // Add Deceleration
        acceleration.y = gravity; // Add Gravity

        // XML Spritesheet stuff, thanks Friday Night Funkin'
        frames = tuxImage;
        animation.addByPrefix('stand', 'stand', 12, false);
        animation.addByPrefix('walk', 'walk', 12, true);
        animation.play('stand');
    }

	override public function update(elapsed:Float)
	{
        // these will have to be changed if options are added that would allow the player to change keybinds or whatever it's called
        // Left + A = Go Left, Right + D = Go Right, Control = Run, Down + S = Duck (NOT ADDED YET!!!), Space + Up + W = Jump
        // i was gonna use the official haxeflixel way of doing variable jumping (using elapsed:float stuff) so that's why movement stuff is here. might still use it if the godot tutorial method turns out to not work that well for this, so don't move any of this stuff yet!

        // Animation Stuff
        if (velocity.x == 0)
        {
            animation.play('stand');
        }
        if (velocity.x != 0 && touching != WALL)
        {
            animation.play('walk');
        }
        if (velocity.x > 0)
        {
            flipX = false;
        }
        else if (velocity.x < 0)
        {
            flipX = true;
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

    public function take_damage() //  Makes Tux take damage.
    {
        if (canTakeDamage == true)
        {
            if (currentState == States.Fire) // If current state is fire, make him go down to just being big.
            {
                currentState = States.Big;
            }
            else if (currentState == States.Big) // If current state is big, make him go down to just being small.
            {
                currentState = States.Small;
            }
            else if (currentState == States.Small) // If current state is small, kill him.
            {
                die();
            }
        }
    }
    
    public function die() // Tux dies. This will be changed to not just do this.
    {
        FlxG.resetState();
    }
}