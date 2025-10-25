# HaxeTux New
Recreation of SuperTux 0.0.6 using HaxeFlixel. If the license is wrong, please let me know! (I don't know whether I'm supposed to use GPL V2 or GPL V3 for this)

## Things that won't be recreated here
* Saving
* All the text and stuff on screen (Although there will still be some stuff from there, they wont be in the same positions or font)
* The exact same brick breaking effect of the original SuperTux 0.0.6
* Main Menu (There'll just be a basic main menu with options to view the credits and play the game)
* Level Editor (Use the latest version of Tiled instead)
* Holding the Laptop Enemy (I don't know how to add that) (If someone could add this, that would be amazing!)
* The BSOD enemy jumping when it detects the edge of a platform or something like that

## Credits
* Vaesea - The recreation
* Everyone who worked on SuperTux 0.0.0 to 0.0.6 - All the assets from SuperTux 0.0.6 that were used for this recreation. Classic / Ji Turn is also from before 0.0.6 (As far as I know, it might've actually come from SuperTux 0.0.x versions?)
* Lukas Nystrand (Mortimer Twang) - Mortimer's Chipdisko
* Larry Ewing - Creator of Tux
* Discover HaxeFlixel (Book) + Scribd - This recreation's code will likely look like the code in that book quite a lot since I'm following that tutorial
* ZhayTee - Ice Music (A song in the files for sky levels) (It's from SuperTux)
* Wansti - Factory (SuperTux Milestone 1 Song (Although I don't think it was actually in Milestone 1?)) (It's from the SuperTux Media Repository)
* Bart + OpenGameArt - Airship Song (A song in the files for airship levels) (You can find the song and the licenses here: https://opengameart.org/content/airship-song)
* Tarush Singhal + OpenGameArt - Sahara Desert Theme / desertv2 (A song in the files for desert levels) (You can find the song and the license here: https://opengameart.org/content/sahara-desert-mario-level)

## More Info
I don't know who made salcon, the credits in SuperTux 0.0.6 doesn't say who made it I think.

## How To Compile
* Make sure you have the latest version of Haxe (4.3.7) installed.
* Make sure you have the latest version of HaxeFlixel and Flixel-Addons installed.
* Make sure you have the latest version of Lime installed.
* I think you also need the latest version of hxcpp? I'm not sure.
* I also think you need the latest version of openfl? I'm not sure.
* Go to the folder where the game's Project.xml is in a terminal and type "lime test windows -debug" if you're on Windows, "lime test mac -debug" if you're on Mac or "lime test linux -debug" if you're on Linux.

## How To Make A Level
### This tutorial assumes you know how to use Tiled.
* Make sure you have the latest version of Tiled installed.
* Make sure you have the source code and you can compile it. (You need to be able to test the level)
* Open base.tmx
* Save your level. (For example, you can save it as: newlevel.tmx)
* Read the text in the level then delete it (I'm not sure whether keeping it in would crash the game or not)
* Remember the text when creating your level.
* Make sure to save it when you're making it and after you're done with it!
* Edit the source code to change the test level to your new level. (Or you can add a new level)
* Test your level, make sure everything looks good, make sure the Trees aren't BSODs.

## Why does this exist?
I don't really know, but at least you'll be able to (sort of) play SuperTux 0.0.6 on Windows or Mac? without using a virtual machine. I mean, it's not really the same since there's not gonna be a level editor and it'll obviously be slightly different than the real SuperTux 0.0.6. Don't worry, this will be available on Linux too.
