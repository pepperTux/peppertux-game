package;

import enemies.BSOD;
import enemies.RightBSOD;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

// TODO: Add a way for the player to NOT fall off the edge of the level.

class PlayState extends FlxState
{
	// You probably shouldn't change these if you're modding.
	var background:FlxBackdrop;
	var bsods:FlxTypedGroup<BSOD>;
	var rightbsods:FlxTypedGroup<RightBSOD>;
	var tux:Tux;
	var bsod:BSOD;
	var bsodRight:RightBSOD;
	var map:FlxOgmo3Loader;
	var levelBounds:FlxGroup; // temporary

	// Changing these is alright if you wanna do something like removing a layer or adding a layer.
	var Foreground:FlxTilemap;
	var Interactive:FlxTilemap;
	var Background:FlxTilemap;
	var PoleTiles:FlxTilemap;

	var levelNameText:FlxText;

	override public function create() // im so tired i cant do this properly today
	{
		super.create();
		createLevel(null, null, null, null);
	}

	function createLevel(levelBackground:String, levelJson:String, song:String, levelName:String)
	{
		super.create();
		
		// used a watermark thing i found in my cancelled fnf psych fork
		// Level Name text.
		levelNameText = new FlxText(0, 0, 640, levelName, 14);
		levelNameText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		levelNameText.scrollFactor.set();
		levelNameText.borderSize = 1.25;
		
		background = new FlxBackdrop(levelBackground, X); // Change this if you want to change the background.
		background.scrollFactor.x = 0.1;
		background.scrollFactor.y = 0.1;

		map = new FlxOgmo3Loader('assets/data/haxetux.ogmo', levelJson);
		Foreground = map.loadTilemap('assets/images/normalTiles.png', 'Foreground');
		Interactive = map.loadTilemap('assets/images/normalTiles.png', 'Interactive');
		Background = map.loadTilemap('assets/images/normalTiles.png', 'Background');
		PoleTiles = map.loadTilemap('assets/images/poleTiles.png', 'PoleTiles');
		Interactive.follow();

		// Only touch if you've added new tiles.
		Interactive.setTileProperties(1, ANY); // Snow Left
		Interactive.setTileProperties(2, ANY); // Snow Middle
		Interactive.setTileProperties(3, ANY); // Snow Right
		Interactive.setTileProperties(4, ANY); // Snow Bottom
		Interactive.setTileProperties(6, ANY); // Darkstone Left
		Interactive.setTileProperties(7, ANY); // Darkstone Middle
		Interactive.setTileProperties(8, ANY); // Darkstone Right
		Interactive.setTileProperties(9, ANY); // Darkstone Bottom

		// Add Background
		add(background);
		
		// Add Tiles, further down on the list means it's visible on top of the others.
		add(PoleTiles);
		add(Background);
		add(Interactive);
		add(Foreground);

		// Add Tux
		tux = new Tux();
		add(tux);

		// Add the stupid groups or something idk
		bsods = new FlxTypedGroup<BSOD>();
		add(bsods);
		rightbsods = new FlxTypedGroup<RightBSOD>();
		add(rightbsods);

		map.loadEntities(placeEntities, "entities");

		// Make camera follow Tux
		FlxG.camera.follow(tux, PLATFORMER, 1);
	
		// Play music
		FlxG.sound.playMusic(song);

		add(levelNameText);
	}

	override public function update(elapsed:Float)
	{
		// If there's any better way to do this, please let me know.

		// Tux
		FlxG.collide(tux, Interactive);
		
		// BSOD
		FlxG.collide(bsods, Interactive);
		FlxG.collide(rightbsods, Interactive);
		FlxG.overlap(bsods, tux, collideEnemies);
		FlxG.overlap(rightbsods, tux, collideEnemiesTwo);

		super.update(elapsed);
	}

	function collideEnemies(bsod:BSOD, tux:Tux)
	{
		bsod.interact(tux);
	}

	function collideEnemiesTwo(rightbsod:RightBSOD, tux:Tux)
	{
		rightbsod.interact(tux);
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "tux":
				tux.setPosition(x, y);
			case "bsod-left":
				bsods.add(new BSOD(x, y));
			case "bsod-right":
				rightbsods.add(new RightBSOD(x, y));
		}
	}
}