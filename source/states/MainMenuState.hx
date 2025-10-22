package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MainMenuState extends FlxState
{
    var playButton:FlxButton;

    override public function create()
    {
        super.create();

        Global.lives = 3;
        Global.score = 0;
        Global.distros = 0;

        // Adding Title Screen background
        var bg = new FlxSprite();
        bg.loadGraphic("assets/images/menu/title.png", false);
        add(bg);

        // Adding button, will probably be replaced by an image?
        playButton = new FlxButton(0, 300, "Play Game", clickPlay);
        playButton.screenCenter(X);
        add(playButton);
    }

    function clickPlay()
    {
        remove(playButton, true); // Remove button, may not be needed?
        FlxG.switchState(PlayState.new); // Switch State
    }
}