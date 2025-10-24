package states;

import LevelLoader;
import creatures.Enemy;
import creatures.Tux;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import objects.Ball;
import objects.BonusBlock;
import objects.BrickBlock;
import objects.Distro;
import objects.Goal;
import objects.Herring;
import objects.PowerUp;
import substates.IntroSubState;

class PlayState extends FlxState
{
	public var map:FlxTilemap;

	public var atiles(default, null):FlxTypedGroup<FlxSprite>;
	public var tux(default, null):Tux;
	public var items(default, null):FlxTypedGroup<FlxSprite>;
	public var blocks(default, null):FlxTypedGroup<FlxSprite>;
	public var bricks(default, null):FlxTypedGroup<FlxSprite>;
	public var enemies(default, null):FlxTypedGroup<Enemy>;

	var hud:HUD;

	var entities:FlxGroup;

	override public function create()
	{
		// Makes sure Global's variable "PS" works
		Global.PS = this;

		// Add stuff part 1
		atiles = new FlxTypedGroup<FlxSprite>();
		entities = new FlxGroup();
		items = new FlxTypedGroup<FlxSprite>();
		bricks = new FlxTypedGroup<FlxSprite>();
		blocks = new FlxTypedGroup<FlxSprite>();
		enemies = new FlxTypedGroup<Enemy>();
		tux = new Tux();
		hud = new HUD();

		var numberOfLevel = Global.levels[Global.currentLevel];

		// Loading the Test Level
		LevelLoader.loadLevel(this, numberOfLevel);

		// Add stuff part 2
		entities.add(items);
		entities.add(bricks);
		entities.add(blocks);
		entities.add(enemies);
		add(atiles);
		add(entities);
		add(tux);
		add(hud);

		// Camera
		FlxG.camera.follow(tux, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

		openSubState(new IntroSubState(FlxColor.BLACK));
		Global.score = 0;
		Global.distros = 0;
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Tux collision
		FlxG.overlap(entities, tux, collideEntities);
		FlxG.collide(tux, blocks, collideEntities);
		FlxG.collide(tux, bricks, collideEntities);
		FlxG.collide(map, tux);

		// Enemy collision
		FlxG.collide(map, entities);
		FlxG.collide(enemies, blocks);
		FlxG.collide(enemies, bricks);
		FlxG.overlap(entities, enemies, function (entity:FlxSprite, enemy:Enemy)
		{
			if (Std.isOfType(entity, Enemy))
			{
				enemy.collideOtherEnemy(cast entity);
			}
			if (Std.isOfType(entity, Ball))
			{
				enemy.collideBall(cast entity);
			}
		} );

		// Item collision
		FlxG.collide(map, items);
		FlxG.collide(items, blocks);
		FlxG.collide(items, bricks);
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

		if (Std.isOfType(entity, EmptyNormalBrickBlock) || Std.isOfType(entity, EmptySnowBrickBlock) || Std.isOfType(entity, CoinSnowBrickBlock) || Std.isOfType(entity, CoinNormalBrickBlock))
		{
			(cast entity).hit(tux);
		}

		if (Std.isOfType(entity, BonusBlock))
		{
			(cast entity).hit(tux);
		}

		if (Std.isOfType(entity, PowerUp))
		{
			(cast entity).collect(tux);
		}

		if (Std.isOfType(entity, Herring))
		{
			(cast entity).collect(tux);
		}

		if (Std.isOfType(entity, Goal))
		{
			(cast entity).reach(tux);
		}
	}
}