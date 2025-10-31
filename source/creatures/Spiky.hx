package creatures;

// Ground detecting stuff by AnatolyStev, it's taken from the Smartball.hx file.

import flixel.graphics.frames.FlxAtlasFrames;

class Spiky extends Enemy
{
    var spikyImage = FlxAtlasFrames.fromSparrow("assets/images/characters/spiky.png", "assets/images/characters/spiky.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = spikyImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.play('walk');

        setSize(33, 33);
        offset.set(5, 9);
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

    override public function interact(tux:Tux)
    {
        if (alive && tux.invincible == false)
        {
            tux.takeDamage();
        }

        if (tux.invincible == true)
        {
            killFall();
        }
    }
}
