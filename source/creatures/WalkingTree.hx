package creatures;

import flixel.graphics.frames.FlxAtlasFrames;

class WalkingTree extends Enemy
{
    var treeImage = FlxAtlasFrames.fromSparrow("assets/images/characters/walkingtree.png", "assets/images/characters/walkingtree.xml");

    public function new(x:Float, y:Float)
    {
        super(x, y);

        frames = treeImage;
        animation.addByPrefix('walk', 'walk', 8, true);
        animation.play('walk');

        setSize(44, 53);
        offset.set(11, 13);
    }

    override private function move()
    {
        velocity.x = direction * walkSpeed;
    }

    override public function interact(tux:Tux)
    {
        if (alive)
        {
            tux.takeDamage();
        }
    }
}
