package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Coin extends FlxSprite
{
    var scoreAmount = 25;
    var speedFromBlock = -128;
    var distroImage = FlxAtlasFrames.fromSparrow('assets/images/objects/coin.png', 'assets/images/objects/coin.xml');

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = distroImage;
        animation.addByPrefix('idle', 'idle', 12, true);
        animation.play('idle');
    }

    public function collect()
    {
        alive = false;
        solid = false;
        Global.score += scoreAmount;
        Global.coins += 1;
        if (Global.coins >= 99)
        {
            Global.lives += 1;
            Global.coins = 0;
        }
        FlxG.sound.play('assets/sounds/coin.wav');
        FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill}); // thanks official haxeflixel tutorial
    }

    function finishKill(_)
    {
        kill();
    }

    public function setFromBlock()
    {
        solid = false;
        acceleration.y = 420;
        velocity.y = speedFromBlock;
        new FlxTimer().start(0.3, function(_) {collect();}, 1);
    }
}