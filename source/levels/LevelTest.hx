package levels;

// Before someone says it, I KNOW this is probably the worst way to add this. I'm tired, it's 3:27 AM where I live right now. If you know how to do this stuff better, PLEASE tell me how or make a pull request.

import PlayState; // Playstate loads levels. Again, if you know how to do this stuff better, please tell me how or make a pull request. I'm tired.

class LevelTest extends PlayState
{
    override public function createLevel(levelBackground:String, levelJson:String, song:String, levelName:String)
    {
        super.createLevel('assets/images/backgrounds/arctis.png', 'assets/data/levels/test.json', 'assets/music/antarctica/mortimers_chipdisko.ogg', 'Test Level');
    }
}