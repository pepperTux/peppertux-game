package states;

// Saving / loading by AnatolyStev
// Worldmap by AnatolyStev

import openfl.system.System;
import worldmap.WorldmapState.WorldMapState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MainMenuState extends FlxState
{
    var playButton:FlxButton;
    var eraseSaveButton:FlxButton;

    override public function create()
    {
        super.create();

        if (FlxG.sound.music != null) // Check if song is playing, if it is, stop song. This if statement is here just to avoid a really weird crash.
        {
            FlxG.sound.music.stop();
        }

        Global.initSave();
        Global.loadProgress();

        if (Global.saveFile.data == null)
        {
            Global.lives = 3;
            Global.score = 0;
            Global.coins = 0;
            Global.saveProgress();
        }

        if (Global.lives < 1)
        {
            Global.lives = 3;
        }

        // Adding Title Screen background
        var bg = new FlxSprite();
        bg.loadGraphic("assets/images/menu/title.png", false);
        add(bg);

        // Adding button, will probably be replaced by an image?
        playButton = new FlxButton(0, 300, "Play Game", clickPlay);
        playButton.screenCenter(X);
        add(playButton);

        // Adding erase save data button
        eraseSaveButton = new FlxButton(0, 350, "Erase Save Data", clickEraseSave);
        eraseSaveButton.screenCenter(X);
        add(eraseSaveButton);
    }

    function clickPlay()
    {
        remove(playButton, true); // Remove button, may not be needed?
        FlxG.switchState(WorldMapState.new); // Switch State
    }

    function clickEraseSave()
    {
        remove(eraseSaveButton, true);
        remove(playButton, true);
        Global.eraseSave();
        System.exit(0);
    }
}