package worldmap;

// Made by AnatolyStev, worldmap PlayState.

import states.PlayState;
import flixel.FlxG;
import worldmap.HardLevelDot;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.FlxState;

class WorldMapState extends FlxState
{
    public var map:FlxTilemap;

	public var collision(default, null):FlxTypedGroup<FlxSprite>;
	public var tux(default, null):TuxWorldmap;
	public var levels(default, null):FlxTypedGroup<LevelDot>;
    public var rocks(default, null):FlxTypedGroup<Rock>;

    var hud:WorldmapHUD;

    override public function create()
    {
        if (FlxG.sound.music != null) // Check if song is playing, if it is, stop song. This if statement is here just to avoid a really weird crash.
        {
            FlxG.sound.music.stop();
        }

        Global.WMS = this;

        // Add things part 1
        collision = new FlxTypedGroup<FlxSprite>();
        levels = new FlxTypedGroup<LevelDot>();
        rocks = new FlxTypedGroup<Rock>();
        tux = new TuxWorldmap();
        
        var numberOfWorldmap = Global.worldmaps[Global.currentWorldmap];

        WorldmapLoader.loadWorldmap(this, numberOfWorldmap);
        checkRockUnlocks();

        // Add things part 2
        hud = new WorldmapHUD();
        add(collision);
        add(levels);
        add(rocks);
        add(tux);
        add(hud);

        if (Global.tuxWorldmapX != 0 || Global.tuxWorldmapY != 0)
        {
            tux.x = Global.tuxWorldmapX;
            tux.y = Global.tuxWorldmapY;
        }

        FlxG.camera.follow(tux, TOPDOWN, 1.0);
        FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

        if (Global.currentSong != null) // If it's null and this isn't done, the game will crash.
        {
            FlxG.sound.playMusic(Global.currentSong, 1.0, true);
        }
    }

    public function checkRockUnlocks()
    {
        for (rock in rocks)
        {
            if (rock.isGone) continue;

            if (rock.rockPosition == "beforeHardLevel" && sectionCompleted(rock.rockSection))
            {
                rock.removeRock();
            }

            else if (rock.rockPosition == "afterHardLevel" && sectionCompleted(rock.rockSection))
            {
                rock.removeRock();
            }
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        // Tux collision
        FlxG.collide(collision, tux);
        FlxG.collide(rocks, tux);
        FlxG.overlap(tux, levels, overlapLevelDots);

        for (dot in levels)
        {
            if (Global.completedLevels.contains(dot.ldLevelPath))
            {
                dot.completeLevel();
            }
        }

        for (rock in rocks)
        {
            if (rock.isGone)
            {
                continue;
            }

            switch (rock.rockPosition)
            {
                case "beforeHardLevel":
                    if (sectionCompleted(rock.rockSection))
                    {
                        rock.removeRock();
                    }
            }
        }
    }

    function overlapLevelDots(tux:TuxWorldmap, dot:FlxSprite)
    {
        if (Std.isOfType(dot, LevelDot))
        {
            var levelDot:LevelDot = cast dot; // I did a REALLY complicated thing here and I'm NOT even sure if it's needed

            Global.dotLevelName = levelDot.ldDisplayName;

            if (FlxG.keys.anyJustPressed([SPACE, ENTER])) // Hahahahahahaha... time to COPY AND PASTE...
            {
                Global.tuxWorldmapX = tux.x;
                Global.tuxWorldmapY = tux.y;
                Global.saveProgress();

                Global.currentLevel = levelDot.ldLevelPath;
                Global.currentSection = levelDot.ldSection;

                FlxG.switchState(PlayState.new);
            }
        }

        if (Std.isOfType(dot, HardLevelDot))
        {
            var hardLevelDot:HardLevelDot = cast dot; // I did a REALLY complicated thing here and I'm NOT even sure if it's needed

            Global.dotLevelName = hardLevelDot.ldDisplayName;

            if (FlxG.keys.anyJustPressed([SPACE, ENTER])) // Hahahahahahaha... time to COPY AND PASTE...
            {
                Global.tuxWorldmapX = tux.x;
                Global.tuxWorldmapY = tux.y;
                Global.saveProgress();

                Global.currentLevel = hardLevelDot.ldLevelPath;
                Global.currentSection = hardLevelDot.ldSection;

                FlxG.switchState(PlayState.new);
            }
        }
    }

    function sectionCompleted(section:String)
    {
        for (dot in levels)
        {
            if (dot.ldSection == section && !Global.completedLevels.contains(dot.ldLevelPath))
            {
                return false;
            }
        }
        return true;
    }

    override public function destroy() 
    {
        Global.saveProgress();
        super.destroy();
    }
}