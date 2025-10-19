package states;

import LevelLoader;
import creatures.Enemy;
import creatures.Tux;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import objects.Distro;

class PlayState extends FlxState
{
	public var map:FlxTilemap;
	public var tux(default, null):Tux;
	public var items(default, null):FlxTypedGroup<FlxSprite>;
	public var enemies(default, null):FlxTypedGroup<Enemy>;
	var hud:HUD;
	var entities:FlxGroup;

	override public function create()
	{
		// Makes sure Global's variable "PS" works
		Global.PS = this;

		// Add stuff part 1
		entities = new FlxGroup();
		items = new FlxTypedGroup<FlxSprite>();
		enemies = new FlxTypedGroup<Enemy>();
		tux = new Tux();
		hud = new HUD();

		// Loading the Test Level
		LevelLoader.loadLevel(this, "test", "assets/images/backgrounds/arctis.png", "assets/music/mortimers_chipdisko.ogg");

		// Add stuff part 2
		entities.add(items);
		entities.add(enemies);
		add(entities);
		add(tux);
		add(hud);

		// Camera
		FlxG.camera.follow(tux, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Tux collision
		FlxG.collide(map, tux);
		FlxG.overlap(entities, tux, collideEntities);

		// Enemy collision
		FlxG.collide(map, entities);
		FlxG.collide(enemies, enemies);
	}

	function collideEntities(entity:FlxSprite, tux:Tux)
	{
		if (Std.isOfType(entity, Distro))
		{
			(cast entity).collect();
		}

		if (Std.isOfType(entity, Enemy))
		{
			(cast entity).interact(tux);
		}
	}
}