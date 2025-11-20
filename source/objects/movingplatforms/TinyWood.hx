package objects.movingplatforms;

class TinyWood extends FloatingPlatform
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic("assets/images/objects/platforms/wood-tiny.png", false);
    }
}