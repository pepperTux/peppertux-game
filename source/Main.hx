package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.util.FlxColor;
import levels.LevelTest;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, LevelTest));
		FlxG.autoPause = false;
	}
}
