package objects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Distro extends FlxSprite
{
    var scoreAmount = 25;

    var distroImage = FlxAtlasFrames.fromSparrow('assets/images/objects/distro.png', 'assets/images/objects/distro.xml');

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
        Global.distros += 1;
        if (Global.distros >= 99)
        {
            Global.lives += 1;
            Global.distros = 0;
        }
        FlxG.sound.play('assets/sounds/distro.wav');
        FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill}); // thanks official haxeflixel tutorial
    }

    function finishKill(_)
    {
        kill();
    }
}