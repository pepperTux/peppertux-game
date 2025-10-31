package;

// Softcoded Level support by AnatolyStev
// Carrying over Tux's state support by AnatolyStev
// Worldmap support by AnatolyStev
// Saving and Loading support by AnatolyStev
// Original Global.hx from Vaesea and Discover Haxeflixel

import flixel.util.FlxSave;
import worldmap.WorldmapState.WorldMapState;
import creatures.Tux.TuxStates;
import lime.utils.Assets;
import states.PlayState;

class Global
{
    public static var score = 0;
    public static var coins = 0;
    public static var lives = 3;
    public static var tuxState:TuxStates = Small;

    public static var PS:PlayState;
    public static var WMS:WorldMapState;

    public static var currentLevel:String;
    public static var levelName:String;
    public static var creatorOfLevel:String;
    public static var dotLevelName:String;

    public static var worldmaps:Array<String> = [];

    public static var currentWorldmap = 0;
    public static var worldmapName:String;
    public static var worldmapCreator:String;
    public static var currentSection:String;
    public static var tuxWorldmapX:Float = 0; // NEED to make it clear that these are floats.
    public static var tuxWorldmapY:Float = 0; // NEED to make it clear that these are floats.

    public static var completedLevels:Array<String> = [];
    public static var completedSections:Array<String> = [];

    public static var currentSong:String;

    public static var saveVersion = 1;
    public static var saveFile:FlxSave = new FlxSave();
    public static var saveName = "pepperTuxSave";

    public static function initSave()
    {
        saveFile.bind(saveName);
    }

    public static function saveProgress()
    {
        if (!saveFile.bind(saveName))
        {
            return;
        }

        if (saveFile.data != null)
        {
            saveFile.data.saveVersion = saveVersion;
            saveFile.data.completedLevels = completedLevels;
            saveFile.data.currentWorldmap = currentWorldmap;
            saveFile.data.tuxWorldmapX = tuxWorldmapX;
            saveFile.data.tuxWorldmapY = tuxWorldmapY;
            saveFile.data.score = score;
            saveFile.data.coins = coins;
            saveFile.data.lives = lives;
            saveFile.data.tuxState = tuxState;

            saveFile.flush();
        }
    }

    public static function loadProgress()
    {
        if (saveFile.data != null)
        {
            if (Reflect.hasField(saveFile.data, "completedLevels"))
            {
                completedLevels = saveFile.data.completedLevels;
            }
            
            if (Reflect.hasField(saveFile.data, "currentWorldmap"))
            {
                currentWorldmap = saveFile.data.currentWorldmap;
            }

            if (Reflect.hasField(saveFile.data, "tuxWorldmapX"))
            {
                tuxWorldmapX = saveFile.data.tuxWorldmapX;
            }

            if (Reflect.hasField(saveFile.data, "tuxWorldmapY"))
            {
                tuxWorldmapY = saveFile.data.tuxWorldmapY;
            }

            if (Reflect.hasField(saveFile.data, "score"))
            {
                score = saveFile.data.score;
            }

            if (Reflect.hasField(saveFile.data, "coins"))
            {
                coins = saveFile.data.coins;
            }

            if (Reflect.hasField(saveFile.data, "lives"))
            {
                lives = saveFile.data.lives;
            }

            if (Reflect.hasField(saveFile.data, "tuxState"))
            {
                tuxState = saveFile.data.tuxState;
            }

            if (!Reflect.hasField(saveFile.data, "saveVersion"))
            {
                saveFile.data.saveVersion = saveVersion;
            }
        }
    }

    public static function eraseSave()
    {
        saveFile.erase();
        saveFile.flush();
        saveFile.bind(saveName);
        Global.completedLevels = [];
        Global.score = 0;
        Global.coins = 0;
        Global.lives = 3;
        Global.currentWorldmap = 0;
    }

    public static function loadWorldmaps()
    {
        worldmaps = Assets.getText("assets/data/worldmaps.txt").split("\n").map(StringTools.trim).filter(function(l) return l != "");
    }
}