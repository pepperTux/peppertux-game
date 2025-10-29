package objects;

// Made by Vaesea, fixed by AnatolyStev
// Well actually it came from Discover Haxeflixel but still

// Note from Vaesea: AnatolyStev meant Area2D probably

import creatures.Tux;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class BonusBlock extends FlxSprite
{
    public var content:String;
    public var isEmpty = false;
    var HFraycast2d:FlxSprite; // it's BASICALLY a raycast2d, right??

    var blockImage = FlxAtlasFrames.fromSparrow('assets/images/objects/bonusblock.png', 'assets/images/objects/bonusblock.xml');

    public function new(x:Float, y:Float)
    {
        super(x, y);
        solid = true;
        immovable = true;

        frames = blockImage;
        animation.addByPrefix('full', 'bonusblock full', 12, false); // I messed up and used default settings for the FNF Spritesheet and XML generator.
        animation.addByPrefix('empty', 'bonusblock empty', 12, false);
        animation.play("full");

        HFraycast2d = new FlxSprite(x + 8, y + height);
        HFraycast2d.makeGraphic(Std.int(width) - 16, Std.int(height) + 1, FlxColor.TRANSPARENT); // all this STD is gonna give me a... Nevermind. Forget about it. Std.int is there because width and height need to be ints.
        HFraycast2d.immovable = true;
        HFraycast2d.solid = false;
    }

    public function hit(tux:Tux)
    {
        if (HFraycast2d.overlaps(tux) == false)
        {
            return;
        }

        if (isEmpty == false) // No more TODO :)
        {
            isEmpty = true;
            createItem();
            FlxTween.tween(this, {y: y - 4}, 0.05) .wait(0.05) .then(FlxTween.tween(this, {y: y}, 0.05, {onComplete: empty}));
        }
    }

    function empty(_)
    {
        animation.play("empty");
    }

    function createItem()
    {
        FlxG.sound.play('assets/sounds/brick.wav');
        switch (content)
        {
            default:
                var Coin:Coin = new Coin(Std.int(x), Std.int(y - 32));
                Coin.setFromBlock();
                Global.PS.items.add(Coin);
            
            case "powerup":
                var powerup:PowerUp = new PowerUp(Std.int(x), Std.int(y - 32));
                Global.PS.items.add(powerup);
                FlxG.sound.play('assets/sounds/upgrade.wav');
            
            case "star":
                var herring:Herring = new Herring(Std.int(x), Std.int(y - 32));
                Global.PS.items.add(herring);
                FlxG.sound.play('assets/sounds/upgrade.wav');
        }
    }
}