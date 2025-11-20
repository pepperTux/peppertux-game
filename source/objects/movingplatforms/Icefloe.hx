package objects.movingplatforms;

class Icefloe extends FloatingPlatform
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic("assets/images/objects/platforms/icefloe.png", false);
    }
}