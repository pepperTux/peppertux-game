package;

// Softcoded Level support by AnatolyStev
// Original Global.hx from Vaesea and Discover Haxeflixel

import lime.utils.Assets;
import states.PlayState;

class Global
{
    public static var score = 0;
    public static var coins = 0;
    public static var lives = 3;
    public static var PS:PlayState;

    // No longer hardcoded :)
    public static var levels:Array<String> = [];

    public static var currentLevel = 0;
    public static var levelName:String;

    public static var currentSong:String;

    public static function loadLevels()
    {
        levels = Assets.getText("assets/data/levels.txt").split("\n").map(StringTools.trim).filter(function(l) return l != ""); // Unfortunately I HAVE to do this stuff in 2 lines
    }
}