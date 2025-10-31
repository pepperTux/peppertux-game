package creatures;

// made by AnatolyStev (vs stev referenc in year 2025)

import flixel.graphics.frames.FlxAtlasFrames;

class Smartball extends Enemy
{
    var smartballImage = FlxAtlasFrames.fromSparrow("assets/images/characters/smartball.png", "assets/images/characters/smartball.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = smartballImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.addByPrefix('squished', 'squished', 8, false);
        animation.play('walk');

        setSize(30, 32);
        offset.set(4, 4);
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

        // Walk
        velocity.x = direction * walkSpeed;
    }
}
