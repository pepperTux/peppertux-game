package creatures.tropical;

import flixel.graphics.frames.FlxAtlasFrames;

class Snake extends Enemy
{
    var snakeImage = FlxAtlasFrames.fromSparrow("assets/images/characters/snake.png", "assets/images/characters/snake.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = snakeImage;
        animation.addByPrefix('walk', 'walk', 10, true);
        animation.addByPrefix('squished', 'squished', 10, false);
        animation.play('walk');

        setSize(52, 8);
        offset.set(4, 17);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }
}
