package states;

// Saving / loading by AnatolyStev
// Worldmap by AnatolyStev

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MainMenuState extends FlxState
{
    var playButton:FlxButton;
    var creditsButton:FlxButton;
    var eraseSaveButton:FlxButton;

    var tweenDuration = 1;
    var tweenAmount = 10;

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

        FlxG.sound.play("assets/sounds/lifeup.wav", 1.0, false); // Test, but a nice change anyways.

        FlxG.sound.playMusic("assets/music/theme.ogg", 1.0, true);

        // Adding Title Screen background
        var bg = new FlxSprite();
        bg.loadGraphic("assets/images/menu/title.png", false);
        add(bg);

        var logo = new FlxSprite(0, 25);
        logo.loadGraphic("assets/images/menu/logo.png");
        logo.screenCenter(X);
        add(logo);

        FlxTween.tween(logo, {y: logo.y + tweenAmount}, tweenDuration, {ease: FlxEase.quadInOut, type: PINGPONG});

        // Adding button, will probably be replaced by an image?
        playButton = new FlxButton(0, 300, "Play Game", clickPlay);
        playButton.screenCenter(X);
        add(playButton);

        creditsButton = new FlxButton(0, 325, "Credits Menu", clickCredits);
        creditsButton.screenCenter(X);
        add(creditsButton);

        // Adding erase save data button
        eraseSaveButton = new FlxButton(0, 350, "Erase Save", clickEraseSave);
        eraseSaveButton.screenCenter(X);
        add(eraseSaveButton);
    }

    function clickPlay()
    {
        remove(playButton, true); // Remove button, may not be needed?
        FlxG.switchState(IntroState.new); // Switch State. TODO: Make it so if the game detects no levels completed, only play the intro then. Otherwise, go to WorldmapState.
    }

    function clickEraseSave()
    {
        remove(eraseSaveButton, true); // Remove erase save button so player can't click it twice
        remove(playButton, true); // Remove play button so player can't play after deleting save
        Global.eraseSave(); // Erase save
        System.exit(0); // Exit game so the save is fully erased
    }

    function clickCredits()
    {
        remove(creditsButton, true); // Remove button, may not be needed?
        FlxG.switchState(CreditsState.new); // Switch State
        
    }
}