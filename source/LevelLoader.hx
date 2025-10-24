package;

import creatures.BSOD;
import creatures.Bag;
import creatures.Laptop;
import creatures.RSOD;
import creatures.Tornado;
import creatures.WalkingTree;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxTilemap;
import objects.BonusBlock;
import objects.BrickBlock.EmptyNormalBrickBlock;
import objects.BrickBlock.EmptySnowBrickBlock;
import objects.Distro;
import objects.Goal;
import states.PlayState;
import tiles.AnimatedTiles;

class LevelLoader extends FlxState
{
    // You really shouldn't touch anything here if you're modding...
    private static var background:FlxBackdrop;

    public static function loadLevel(state:PlayState, level:String)
    {
        var tiledMap = new TiledMap("assets/data/levels/" + level + ".tmx");

        // MAKE SURE TO PUT A SONG, BACKGROUND AND LEVEL NAME IN YOUR LEVEL OR THE GAME MIGHT CRASH!!!!!!!!!! Sorry for not being very professional but I just needed to make it VERY clear. Do NOT remove the custom properties of the base level for your level.
        var song = tiledMap.properties.get("music");
        var bg = tiledMap.properties.get("bg");
        var levelName = tiledMap.properties.get("levelName");

        Global.levelName = levelName;

        // FlxG.sound.playMusic(song, 1.0, true); only add back if there's a problem
        Global.currentSong = song;

        // Background Stuff
        background = new FlxBackdrop(bg, X);
        background.scrollFactor.x = 0.05;
        background.scrollFactor.y = 0.05; // should be unused
        state.add(background);

        var backgroundLayer:TiledTileLayer = cast tiledMap.getLayer("Background");
        
        var backgroundMap = new FlxTilemap();
        backgroundMap.loadMapFromArray(backgroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        backgroundMap.solid = false;

        var interactiveLayer:TiledTileLayer = cast tiledMap.getLayer("Interactive");

        // I made a mistake here before.
        state.map = new FlxTilemap();
        state.map.loadMapFromArray(interactiveLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);

        var foregroundLayer:TiledTileLayer = cast tiledMap.getLayer("Foreground");
        
        var foregroundMap = new FlxTilemap();
        foregroundMap.loadMapFromArray(foregroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        foregroundMap.solid = false;

        state.add(backgroundMap);
        state.add(state.map);
        state.add(foregroundMap);

        // Load animated tiles

        for (object in getLevelObjects(tiledMap, "Animated Tiles"))
        {
            switch (object.type)
            {
                default:
                    state.atiles.add(new Water(object.x, object.y - 32));
                case "lava":
                    state.atiles.add(new Lava(object.x, object.y - 32));
                case "flag":
                    state.atiles.add(new Flag(object.x, object.y - 32));
            }
        }

        // Load goal
        for (object in getLevelObjects(tiledMap, "Level"))
        {
            switch (object.type)
            {
                case "goal": // Might add a checkpoint at some point, keep this!
                    state.items.add(new Goal(object.x, object.y - 32));
            }
        }

        // Load distros
        for (distro in getLevelObjects(tiledMap, "Distros"))
            state.items.add(new Distro(distro.x, distro.y - 32));

        // Load blocks
        for (block in getLevelObjects(tiledMap, "Blocks"))
        {
            var blockToAdd = new BonusBlock(block.x, block.y - 32);
            blockToAdd.content = block.type;
            state.blocks.add(blockToAdd);
        }

        // Load bricks
        for (brick in getLevelObjects(tiledMap, "Bricks"))
        {
            switch(brick.type)
            {
                default:
                    state.bricks.add(new EmptyNormalBrickBlock(brick.x, brick.y - 32));
                case "snow":
                    state.bricks.add(new EmptySnowBrickBlock(brick.x, brick.y - 32));
            }
        }

        // Load enemies
        for (enemy in getLevelObjects(tiledMap, "Enemies"))
            switch(enemy.type)
            {
                default:
                    state.enemies.add(new BSOD(enemy.x, enemy.y - 32));
                case "tree":
                    state.enemies.add(new WalkingTree(enemy.x, enemy.y - 66));
                case "bag":
                    state.enemies.add(new Bag(enemy.x, enemy.y - 32));
                case "rsod":
                    state.enemies.add(new RSOD(enemy.x, enemy.y - 32));
                case "tornado":
                    state.enemies.add(new Tornado(enemy.x - 6, enemy.y - 36));
                case "laptop":
                    state.enemies.add(new Laptop(enemy.x, enemy.y - 32));
            }

        // Don't be like me. Don't remove this.
        var tuxPosition:TiledObject = getLevelObjects(tiledMap, "Player")[0];
        state.tux.setPosition(tuxPosition.x, tuxPosition.y - 32);
    }

    public static function getLevelObjects(map:TiledMap, layer:String):Array<TiledObject>
    {
        if ((map != null) && (map.getLayer(layer) != null))
        {
            var objLayer:TiledObjectLayer = cast map.getLayer(layer);
            return objLayer.objects;
        }
        else
        {
            trace("Object layer " + layer + " not found! Also credits to Discover Haxeflixel.");
            return [];
        }
    }
}