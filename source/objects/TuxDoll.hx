package objects;

import flixel.FlxG;
import creatures.Tux;
import flixel.FlxSprite;

class TuxDoll extends FlxSprite
{
    var scoreAmount = 2500; // 25 (Coin score amount) x 100 (Coin 1-up amount) = 2500
    var moveSpeed = 115;
    var gravity = 1000;
    var jumpHeight = 512;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic("assets/images/objects/1up.png");

        acceleration.y = gravity;
        velocity.y = -jumpHeight;

        solid = true;
    }

    override public function update(elapsed:Float)
    {
        velocity.x = moveSpeed;
        
        super.update(elapsed);
    }

    public function collect(tux:Tux)
    {
        FlxG.sound.play("assets/sounds/lifeup.wav", 1.0, false);
        kill();
        Global.lives += 1;
        Global.score += scoreAmount;
    }
}