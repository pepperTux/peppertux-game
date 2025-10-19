package;

import creatures.BSOD;
import creatures.Bag;
import creatures.RSOD;
import creatures.Tornado;
import creatures.WalkingTree;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxTilemap;
import objects.Distro;
import states.PlayState;

class LevelLoader extends FlxState
{
    // You really shouldn't touch anything here if you're modding...
    private static var background:FlxBackdrop;

    public static function loadLevel(state:PlayState, level:String, levelBackground:String, song:String)
    {
        FlxG.sound.playMusic(song, 1.0, true);

        // Background Stuff
        background = new FlxBackdrop(levelBackground, X);
        background.scrollFactor.x = 0.05;
        background.scrollFactor.y = 0.05; // should be unused
        state.add(background);

        var tiledMap = new TiledMap("assets/data/levels/" + level + ".tmx");

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

        for (distro in getLevelObjects(tiledMap, "Distros"))
            state.items.add(new Distro(distro.x, distro.y - 32));

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
            }
        
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