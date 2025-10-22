package creatures;

// made by AnatolyStev (vs stev referenc in year 2025)

import flixel.graphics.frames.FlxAtlasFrames;

class RSOD extends Enemy
{
    var rsodImage = FlxAtlasFrames.fromSparrow("assets/images/characters/rsod.png", "assets/images/characters/rsod.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = rsodImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.addByPrefix('fall', 'fall', 8, false);
        animation.addByPrefix('squished', 'squished', 8, false);
        animation.play('walk');

        setSize(28, 28);
        offset.set(2, 4);
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
        if (map.getTileIndex(tileX, tileY) == 0) // This is why there needs to be Std.int
        {
            flipDirection();
        }

        // Walk
        velocity.x = direction * walkSpeed;
    }
}
