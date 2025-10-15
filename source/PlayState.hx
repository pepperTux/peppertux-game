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
import objects.Distro;

// TODO: Add a way for the player to NOT fall off the edge of the level.
// Also, sorry that there are comments that try to seem funny. It's actually just me going crazy.

class PlayState extends FlxState
{
	// You probably shouldn't change these if you're modding.
	var background:FlxBackdrop;
	var distros:FlxTypedGroup<Distro>;
	var bsods:FlxTypedGroup<BSOD>;
	var rightbsods:FlxTypedGroup<RightBSOD>;
	var distro:Distro;
	var tux:Tux;
	var bsod:BSOD;
	var bsodRight:RightBSOD;
	var map:FlxOgmo3Loader;

	// Changing these is alright if you wanna do something like removing a layer or adding a layer.
	var Foreground:FlxTilemap;
	var Interactive:FlxTilemap;
	var Background:FlxTilemap;
	var PoleTiles:FlxTilemap;

	// GUI
	var levelNameText:FlxText;
	var distroText:FlxText;

	override public function create() // im so tired i cant do this properly today
	{
		super.create();
		createLevel(null, null, null, null);
	}

	function createLevel(levelBackground:String, levelJson:String, song:String, levelName:String)
	{
		super.create();

		// so apparently i had to move the "something = new something();" up to fix a really annoying bug. why is haxeflixel like this?
		tux = new Tux();
		bsods = new FlxTypedGroup<BSOD>();
		rightbsods = new FlxTypedGroup<RightBSOD>();
		
		// used a watermark thing i found in my cancelled fnf psych fork for both of these UI things
		// Level Name text
		levelNameText = new FlxText(0, 4, 640, levelName, 14);
		levelNameText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		levelNameText.scrollFactor.set();
		levelNameText.borderSize = 1.25;

		// Distro text.
		distroText = new FlxText(5, 4, 0, "Distros: " + tux.totalDistros, 14);
		distroText.setFormat(null, 14, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		distroText.scrollFactor.set();
		distroText.borderSize = 1.25;
		
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

		// Add distros
		distros = new FlxTypedGroup<Distro>();
		add(distros);

		// Add Tux
		add(tux);

		// Add the BSODs
		add(bsods);
		add(rightbsods);

		map.loadEntities(placeEntities, "entities");

		// Make camera follow Tux
		FlxG.camera.follow(tux, PLATFORMER, 1);
	
		// Play music
		FlxG.sound.playMusic(song);

		// Add GUI
		add(levelNameText);
		add(distroText);
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
		
		// Distros
		FlxG.overlap(distros, tux, collideDistros); // thank haxeflixel god i dont have to put 2 of these!

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

	function collideDistros(distro:Distro, tux:Tux)
	{
		if (distro.alive) // If the distro is alive, Tux collects it and it increases the total distros.
		{
			distro.collect(tux);
			tux.totalDistros += 1;
			distroText.text = "Distros: " + tux.totalDistros;
		}
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
			case "distro":
				distros.add(new Distro(x, y));
		}
	}
}