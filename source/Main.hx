package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.MainMenuState;

class Main extends Sprite
{
	public function new()
	{
		super();
		Global.loadLevels();
		addChild(new FlxGame(0, 0, MainMenuState));
	}
}
