package worldmap;

// Made by AnatolyStev

class HardLevelDot extends LevelDot
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        
        loadGraphic("assets/images/worldmap/leveldot.png", true, 32, 32);
        animation.add("white", [2], 1.0, true);
        animation.add("green", [1], 1.0, true);
        animation.play("white");
    }

    override public function update(elapsed:Float)
    {
        if (isCompleted == true)
        {
            animation.play("green");
        }
        else
        {
            animation.play("white");
        }
    }
}