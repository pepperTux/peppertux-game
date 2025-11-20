package objects.movingplatforms;

class Big extends FloatingPlatform
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic("assets/images/objects/platforms/big.png", false);
    }
}