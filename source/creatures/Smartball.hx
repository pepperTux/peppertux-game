package creatures;

// made by AnatolyStev
// edited by AnatolyStev (11/4/25) (to make it detect solid squares since this game uses solid squares for collision!!)

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class Smartball extends Enemy
{
    var smartballImage = FlxAtlasFrames.fromSparrow("assets/images/characters/smartball.png", "assets/images/characters/smartball.xml");

    var point:FlxSprite;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = smartballImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.addByPrefix('squished', 'squished', 8, false);
        animation.play('walk');

        point = new FlxSprite();
        point.makeGraphic(1, 1, FlxColor.TRANSPARENT);
        Global.PS.add(point);

        setSize(30, 32);
        offset.set(4, 4);
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
        if (FlxG.overlap(point, Global.PS.blocks) || FlxG.overlap(point, Global.PS.bricks) || FlxG.overlap(point, Global.PS.collision))
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
