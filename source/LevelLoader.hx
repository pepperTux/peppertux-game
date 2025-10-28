package;

import creatures.BouncingSnowball;
import objects.Solid;
import creatures.Smartball;
import creatures.FlyingSnowball;
import creatures.Iceblock;
import creatures.Jumpy;
import objects.Coin;
import creatures.Snowball;
import creatures.Spiky;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxTilemap;
import objects.BonusBlock;
import objects.BrickBlock;
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

        // MAKE SURE TO PUT A SONG, BACKGROUND, LEVEL NAME AND BACKGROUND SPEED IN YOUR LEVEL OR THE GAME MIGHT CRASH!!!!!!!!!! Sorry for not being very professional but I just needed to make it VERY clear. Do NOT remove the custom properties of the base level for your level.
        var song = tiledMap.properties.get("music");
        var bg = tiledMap.properties.get("bg");
        var levelName = tiledMap.properties.get("levelName");

        Global.levelName = levelName;

        // FlxG.sound.playMusic(song, 1.0, true); only add back if there's a problem
        Global.currentSong = song;

        // Background Stuff
        background = new FlxBackdrop(bg, X);
        background.scrollFactor.x = 0.5;
        background.scrollFactor.y = 0.5;
        state.add(background);

        // Furthest Background
        var furthestBackgroundLayer:TiledTileLayer = cast tiledMap.getLayer("Furthest Background");
        
        var furthestBackgroundMap = new FlxTilemap();
        furthestBackgroundMap.loadMapFromArray(furthestBackgroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        furthestBackgroundMap.solid = false;

        // Even Further Background
        var evenFurtherBackgroundLayer:TiledTileLayer = cast tiledMap.getLayer("Even Further Background");
        
        var evenFurtherBackgroundMap = new FlxTilemap();
        evenFurtherBackgroundMap.loadMapFromArray(evenFurtherBackgroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        evenFurtherBackgroundMap.solid = false;

        // Further Background
        var furtherBackgroundLayer:TiledTileLayer = cast tiledMap.getLayer("Further Background");
        
        var furtherBackgroundMap = new FlxTilemap();
        furtherBackgroundMap.loadMapFromArray(furtherBackgroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        furtherBackgroundMap.solid = false;
        
        // Background
        var backgroundLayer:TiledTileLayer = cast tiledMap.getLayer("Background");
        
        var backgroundMap = new FlxTilemap();
        backgroundMap.loadMapFromArray(backgroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        backgroundMap.solid = false;

        // Interactive / Main
        var interactiveLayer:TiledTileLayer = cast tiledMap.getLayer("Main");

        state.map = new FlxTilemap();
        state.map.loadMapFromArray(interactiveLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        state.map.solid = false;

        // Foreground
        var foregroundLayer:TiledTileLayer = cast tiledMap.getLayer("Foreground");
        
        var foregroundMap = new FlxTilemap();
        foregroundMap.loadMapFromArray(foregroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        foregroundMap.solid = false;

        state.add(furthestBackgroundMap);
        state.add(evenFurtherBackgroundMap);
        state.add(furtherBackgroundMap);
        state.add(backgroundMap);
        state.add(state.map);

        // Load collision
        for (solid in getLevelObjects(tiledMap, "Solid"))
        {
            var solidSquare = new Solid(solid.x, solid.y, solid.width, solid.height); // Need this because width and height.
            state.collision.add(solidSquare);
        }

        // Load animated tiles
        for (object in getLevelObjects(tiledMap, "Animated Tiles"))
        {
            switch (object.type)
            {
                default:
                    state.atiles.add(new Water(object.x, object.y - 32));
                case "trans":
                    state.atiles.add(new WaterTrans(object.x, object.y - 32));
                case "flag":
                    state.atiles.add(new Flag(object.x, object.y - 32));
            }
        }

        // Load goal
        for (object in getLevelObjects(tiledMap, "Level"))
        {
            switch (object.type)
            {
                case "goal": // Might add a checkpoint at some point, don't replace this with default!
                    state.items.add(new Goal(object.x, object.y - 32));
            }
        }

        // Load distros
        for (distro in getLevelObjects(tiledMap, "Coins"))
            state.items.add(new Coin(distro.x, distro.y - 32));

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
                case "coin":
                    state.bricks.add(new CoinNormalBrickBlock(brick.x, brick.y - 32));
                case "snowcoin":
                    state.bricks.add(new CoinSnowBrickBlock(brick.x, brick.y - 32));
            }
        }

        // Load enemies
        for (enemy in getLevelObjects(tiledMap, "Enemies"))
            switch(enemy.type)
            {
                default:
                    state.enemies.add(new Snowball(enemy.x, enemy.y - 32));
                case "spiky":
                    state.enemies.add(new Spiky(enemy.x, enemy.y - 33));
                case "jumpy":
                    state.enemies.add(new Jumpy(enemy.x, enemy.y - 37));
                case "rsod":
                    state.enemies.add(new Smartball(enemy.x, enemy.y - 32));
                case "flyingsnowball":
                    state.enemies.add(new FlyingSnowball(enemy.x - 6, enemy.y - 34));
                case "iceblock":
                    state.enemies.add(new Iceblock(enemy.x, enemy.y - 30));
                case "bouncingsnowball":
                    state.enemies.add(new BouncingSnowball(enemy.x, enemy.y - 32));
            }

        // Don't be like me. Don't remove this.
        var tuxPosition:TiledObject = getLevelObjects(tiledMap, "Player")[0];
        state.tux.setPosition(tuxPosition.x, tuxPosition.y - 37);
        
        state.add(foregroundMap);
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