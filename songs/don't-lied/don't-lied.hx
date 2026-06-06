import funkin.backend.FunkinShader.FunkinRuntimeShader;
var darkshader:FunkinRuntimeShader;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

function onLoad()
{
    videoCutscene('dontlied');

	darkshader = newShader('lights');
	darkshader.setFloat('lowerBound', 0.01);
	darkshader.setFloat('upperBound', 0.15);
	darkshader.setBool('invert', true);
}

function onStepHit() //a way to do events in the song script instead of events.json
{
	switch (curStep)
	{
		case 18:
	    	FlxTween.tween(camGame, {zoom: 0.75}, 1, {ease: FlxEase.quadInOut});
		case 80:
	    	FlxTween.tween(camGame, {zoom: 0.78}, 1, {ease: FlxEase.quadInOut});
		case 132:
	    	FlxTween.tween(camGame, {zoom: 0.75}, 0.5, {ease: FlxEase.quadInOut});
		case 140:
	    	FlxTween.tween(camGame, {zoom: 0.78}, 0.5, {ease: FlxEase.quadOut});
		case 144:
	    	FlxTween.tween(camGame, {zoom: 0.79}, 0.5, {ease: FlxEase.quadOut});
		case 208:
	    	FlxTween.tween(camGame, {zoom: 0.8}, 0.5, {ease: FlxEase.quadOut});
		case 224:
	    	FlxTween.tween(camGame, {zoom: 0.79}, 0.5, {ease: FlxEase.quadOut});
		case 272:
	    	FlxTween.tween(camGame, {zoom: 0.7}, 2, {ease: FlxEase.quadOut});
		case 408:
	    	FlxTween.tween(camGame, {zoom: 0.85}, 1, {ease: FlxEase.quadInOut});
		case 416:
	    	FlxTween.tween(camGame, {zoom: 0.7}, 2, {ease: FlxEase.quadOut});
		case 612:
	    	FlxTween.tween(camGame, {zoom: 0.75}, 0.2, {ease: FlxEase.quadOut});
        case 654:
	    	FlxTween.tween(camGame, {zoom: 0.68}, 0.5, {ease: FlxEase.quadOut});
        case 662:
	    	FlxTween.tween(camGame, {zoom: 0.75}, 1, {ease: FlxEase.quadOut});
		case 672:
	    	FlxTween.tween(camGame, {zoom: 0.78}, 0.2, {ease: FlxEase.quadOut});
        case 676:
	    	FlxTween.tween(camGame, {zoom: 0.8}, 0.2, {ease: FlxEase.quadOut});
        case 678:
	    	FlxTween.tween(camGame, {zoom: 0.73}, 2, {ease: FlxEase.quadInOut});
        case 736:
	    	FlxTween.tween(camGame, {zoom: 0.70}, 1, {ease: FlxEase.quadOut});
        case 800:
	    	FlxTween.tween(camGame, {zoom: 0.75}, 1, {ease: FlxEase.quadOut});
        case 928:
	    	FlxTween.tween(camGame, {zoom: 0.7}, 1, {ease: FlxEase.quadOut});
        case 1056:
	    	FlxTween.tween(camGame, {zoom: 0.73}, 0.5, {ease: FlxEase.quadOut});
        case 1180:
	    	FlxTween.tween(camGame, {zoom: 0.70}, 0.5, {ease: FlxEase.quadOut});
		case 1184:
	    	triggerEventNote('Lights out', '', '');
	    	camSpecialThing([640, 450], [980, 480]);
            FlxTween.tween(camGame, {zoom: 0.9}, 20, {ease: FlxEase.quadInOut});
		case 1232:
	    	dad.x = 680;
		case 1376:
	    	triggerEventNote('Lights on', '', '');
			camSpecialThing([640, 450], [810, 450]);
        case 1394:
            FlxTween.tween(camGame, {zoom: 0.85}, 1, {ease: FlxEase.quadInOut});
		case 1396:
	    	blooodfuckkk.alpha = 0.8;
            camSpecialThing([640, 450], [810, 470]);
	    	FlxTween.tween(blooodfuckkk, {alpha: 0.2}, 2, {ease: FlxEase.quadInOut});
	    	if (boyfriend.curCharacter == 'bfweird')
	    	PlayState.instance.triggerEventNote("Change Character", "bf", "bfweird-stabbed");
	    	FlxTween.tween(dad, {x: dad.x - 150}, 6, {ease: FlxEase.quadInOut});
		case 1408:
            FlxTween.tween(camGame, {zoom: 0.9}, 20);
		    FlxTween.tween(loBlack2, {alpha: 1}, 20);
	}
}
function onEvent(name, v1, v2)
{
	switch (name)
	{
		case 'Lights out':
        	camGame.flash(ClientPrefs.flashing ? FlxColor.WHITE : FlxColor.BLACK, 0.5); //checks if user has photosensitive mode on
			gf.alpha = 0.001;
			//pet.alpha = 0.001;
			playHUD.iconP1.shader = darkshader;
			playHUD.iconP2.alpha = 0.001;
			if (boyfriend.curCharacter == 'bfweird') triggerEventNote('Change Character', '0', 'bf-dark');
			else boyfriend.shader = darkshader;
            dad.shader = null;
			dad.alpha = 0.001;
            loBlack.alpha = 1;
            guy2.alpha = 0.001;
            guy3.alpha = 0.001;
		case 'Lights on':
            loBlack.alpha = 0.001;
			if (boyfriend.curCharacter == 'bf-dark') triggerEventNote('Change Character', '0', 'bfweird');
			else boyfriend.shader = null;
			dad.alpha = 1;
			gf.alpha = 1;
			//pet.alpha = 1;
			playHUD.iconP1.shader = null;
			playHUD.iconP2.alpha = 1;
			camGame.flash(FlxColor.BLACK, 0.35);
            guy2.alpha = 1;
            guy3.alpha = 1;
	}
}


function opponentNoteHit(note)
{	
	if (health > 0.2) health -= 0.02;
}
