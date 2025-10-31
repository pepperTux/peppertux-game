package;

// Saving / loading by AnatolyStev

import flixel.FlxGame;
import openfl.display.Sprite;
import states.MainMenuState;

class Main extends Sprite
{
	public function new()
	{
		super();

		Global.initSave();
		Global.loadProgress();
		
		Global.loadWorldmaps();
		addChild(new FlxGame(0, 0, MainMenuState));
	}
}
