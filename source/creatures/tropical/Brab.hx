package creatures.tropical;

// Smartball made by AnatolyStev
// Smartball edited by AnatolyStev (11/4/25) (to make it detect solid squares since this game uses solid squares for collision!!)

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;

class Brab extends Enemy
{
    var brabImage = FlxAtlasFrames.fromSparrow("assets/images/characters/brab.png", "assets/images/characters/brab.xml");

    var point:FlxSprite;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = brabImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.addByPrefix('squished', 'squished', 8, false);
        animation.play('walk');

        point = new FlxSprite();
        point.makeGraphic(1, 1, FlxColor.TRANSPARENT);
        Global.PS.add(point);

        setSize(39, 35);
        offset.set(19, 7);
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
