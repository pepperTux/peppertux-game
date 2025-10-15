package objects;

// This is kinda copied from the "Discover Haxeflixel" book.

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Distro extends FlxSprite
{
    var distroImage = FlxAtlasFrames.fromSparrow('assets/images/objects/distro.png', 'assets/images/objects/distro.xml');

    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);

        frames = distroImage;
        animation.addByPrefix('idle', 'idle', 12, true);
        animation.play('idle');
    }

    public function collect(tux:Tux)
    {
        FlxG.sound.play('assets/sounds/distro.wav');
        alive = false;
        FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill}); // thanks official haxeflixel tutorial
    }
    
    function finishKill(_)
    {
        exists = false;
    }
}