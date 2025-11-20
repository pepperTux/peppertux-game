package creatures.forest;

// Smartball made by AnatolyStev
// Smartball edited by AnatolyStev (11/4/25) (to make it detect solid squares since this game uses solid squares for collision!!)

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class WalkingLeaf extends Enemy
{
    var walkingLeafImage = FlxAtlasFrames.fromSparrow("assets/images/characters/walking-leaf.png", "assets/images/characters/walking-leaf.xml");

    var point:FlxSprite;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = walkingLeafImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.addByPrefix('squished', 'squshed', 8, false);
        animation.play('walk');

        point = new FlxSprite();
        point.makeGraphic(1, 1, FlxColor.TRANSPARENT);
        Global.PS.add(point);

        walkSpeed = 60;

        setSize(26, 19);
        offset.set(4, 20); // This isn't meant to be funny.
    }

    override private function move()
    {
        // Ground Detectors
        var groundDetectorX = if (direction == 1) { x + this.width + 1; } else { x - 1; }
        var groundDetectorY = y + this.height + offset.y + 1;

        point.setPosition(groundDetectorX, groundDetectorY);

        // Things
        var hasGround = false;

        // Check for no solid objects
        if (FlxG.overlap(point, Global.PS.blocks) || FlxG.overlap(point, Global.PS.bricks) || FlxG.overlap(point, Global.PS.collision) || FlxG.overlap(point, Global.PS.platforms))
        {
            hasGround = true;
        }

        if (!hasGround && currentState == Alive)
        {
            flipDirection();
        }

        // Walk
        velocity.x = direction * walkSpeed;
    }
}
