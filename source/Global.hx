package;

import states.PlayState;

class Global
{
    public static var score = 0;
    public static var distros = 0;
    public static var lives = 3;
    public static var PS:PlayState;
    public static var checkpointReached = false;

    public static var levels:Array<String> = ["test", "antarctica1", "antarctica2", "mondo", "skytake1"];
    public static var currentLevel = 0;
    public static var levelName:String;

    public static var currentSong:String;
}