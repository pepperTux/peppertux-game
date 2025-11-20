package objects.movingplatforms;

class SmallIcefloe extends FloatingPlatform
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic("assets/images/objects/platforms/icefloe_small.png", false);
    }
}