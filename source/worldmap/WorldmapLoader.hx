package worldmap;

// Made by AnatolyStev, loads Worldmap.

import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledObject;
import objects.Solid;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledMap;
import worldmap.WorldmapState;
import flixel.FlxState;
import worldmap.LevelDot;
import worldmap.HardLevelDot;

class WorldmapLoader extends FlxState
{
    public static function loadWorldmap(state:WorldMapState, worldmap:String)
    {
        var tiledMap = new TiledMap("assets/data/worldmaps/" + worldmap + ".tmx");

        var song = tiledMap.properties.get("music");
        var worldmapName = tiledMap.properties.get("worldmapName");
        var worldmapCreator = tiledMap.properties.get("worldmapCreator");

        Global.worldmapName = worldmapName;
        Global.worldmapCreator = worldmapCreator;
        Global.currentSong = song;

        // Background
        var backgroundLayer:TiledTileLayer = cast tiledMap.getLayer("Background");
        
        var backgroundMap = new FlxTilemap();
        backgroundMap.loadMapFromArray(backgroundLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        backgroundMap.solid = false;

        // Background 2
        var backgroundTwoLayer:TiledTileLayer = cast tiledMap.getLayer("Background 2");
        
        var backgroundTwoMap = new FlxTilemap();
        backgroundTwoMap.loadMapFromArray(backgroundTwoLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        backgroundTwoMap.solid = false;

        // Main
        var mainLayer:TiledTileLayer = cast tiledMap.getLayer("Main");

        state.map = new FlxTilemap();
        state.map.loadMapFromArray(mainLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        state.map.solid = false;

        // Foreground 1
        var foregroundOneLayer:TiledTileLayer = cast tiledMap.getLayer("Foreground 1");
        
        var foregroundOneMap = new FlxTilemap();
        foregroundOneMap.loadMapFromArray(foregroundOneLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        foregroundOneMap.solid = false;

        // Foreground 2
        var foregroundTwoLayer:TiledTileLayer = cast tiledMap.getLayer("Foreground 2");
        
        var foregroundTwoMap = new FlxTilemap();
        foregroundTwoMap.loadMapFromArray(foregroundTwoLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        foregroundTwoMap.solid = false;

        // Foreground 3
        var foregroundThreeLayer:TiledTileLayer = cast tiledMap.getLayer("Foreground 3");
        
        var foregroundThreeMap = new FlxTilemap();
        foregroundThreeMap.loadMapFromArray(foregroundThreeLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        foregroundThreeMap.solid = false;

        // Foreground 4
        var foregroundFourLayer:TiledTileLayer = cast tiledMap.getLayer("Foreground 4");
        
        var foregroundFourMap = new FlxTilemap();
        foregroundFourMap.loadMapFromArray(foregroundFourLayer.tileArray, tiledMap.width, tiledMap.height, "assets/images/normalTiles.png", 32, 32, 1);
        foregroundFourMap.solid = false;
        
        state.add(backgroundMap);
        state.add(backgroundTwoMap);
        state.add(state.map);
        state.add(foregroundOneMap);
        state.add(foregroundTwoMap);
        state.add(foregroundThreeMap);
        state.add(foregroundFourMap);

        for (solid in getLevelObjects(tiledMap, "Solid"))
        {
            var solidSquare = new Solid(solid.x, solid.y, solid.width, solid.height); // Need this because width and height.
            state.collision.add(solidSquare);
        }

        for (object in getLevelObjects(tiledMap, "Levels"))
        {
            var levelPath = object.properties.get("levelPath");
            var section = object.properties.get("section");
            var displayName = object.properties.get("displayName");

            switch (object.type)
            {
                default:
                    var levelDot = new LevelDot(object.x, object.y - 32);
                    levelDot.setup(levelPath, section, displayName);
                    state.levels.add(levelDot);
                
                case "hard":
                    var hardLevelDot = new HardLevelDot(object.x, object.y - 32);
                    hardLevelDot.setup(levelPath, section, displayName);
                    state.levels.add(hardLevelDot);
            }
        }

        for (object in getLevelObjects(tiledMap, "Rocks"))
        {
            var section = object.properties.get("section");
            var positionType = object.properties.get("positionType");
            
            var rock = new Rock(object.x, object.y - 32);
            rock.theRock(section, positionType);
            state.rocks.add(rock);
        }

        var tuxPosition:TiledObject = getLevelObjects(tiledMap, "Player")[0];
        if (Global.tuxWorldmapX == 0 && Global.tuxWorldmapY == 0)
        {
            state.tux.setPosition(tuxPosition.x, tuxPosition.y - 6);
        }
        else
        {
            state.tux.setPosition(Global.tuxWorldmapX, Global.tuxWorldmapY);
        }
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