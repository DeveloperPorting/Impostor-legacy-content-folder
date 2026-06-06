import funkin.backend.FunkinShader.FunkinRuntimeShader;
import openfl.filters.ShaderFilter;

var lightsShader:FunkinRuntimeShader;
public var darkShader:FunkinRuntimeShader;
public var gfBlacklist:Array<String> = ['gf-tuesday', 'upgirl', 'gf-ghost', 'gfpolus']; // Gf polus is only here because of the snow

public var vignette:Bool = false;

function onLoad()
{
	//readDialogue();
	// Just preloading this in onLoad() instead of onPush()
	addCharacterToList('bf-dark', 0);
	addCharacterToList('green-dark', 1);
	
	// if (ClientPrefs.shaders)
	//{
		lightsShader = newShader('lights');
		lightsShader.setFloat('lowerBound', 0.01);
		lightsShader.setFloat('upperBound', 0.15);
		lightsShader.setBool('invert', true);
	//}
	darkShader = newShader('Nightmare/AdjustColor');
}

function onCreatePost()
{
	/*if (!hasBfSkin) bfvent.alpha = 0.001;
	if (!gfBlacklist.contains(ClientPrefs.gfSkin)) ldSpeaker.alpha = 0.001;*/
}

function setVignette(yea:Bool):Void
{
	vignette = yea;
	
	//boyfriend.shader = dad.shader = gf.shader = /*pet.shader = */bg.shader = fg.shader = tn.shader = darkShader;
	FlxG.camera.filters = [new ShaderFilter(darkShader)];
	
	if (darkShader == null) return;
	
	FlxTween.num(ClientPrefs.flashing ? .5 : 0, 1, .5, {ease: ClientPrefs.flashing ? FlxEase.elasticOut : FlxEase.sineOut}, function(n) {
		if (!yea) n = (1 - n);

		darkShader.setFloat('brightness', n * -80.0);
		darkShader.setFloat('contrast', n * -20.0);
		darkShader.setFloat('saturation', n * -50.0);
		darkShader.setFloat('hue', n * 20.0);
	});
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy':
			switch (value1)
			{
				case 'Vignette On':
					setVignette(true);
				case 'Vignette Off':
					setVignette(false);
				case 'ending':
					setVignette(false);
					triggerEventNote('Lights on', '', '');
					boyfriend.visible = false;
					gf.visible = false;
					triggerEventNote('HUD Fade', '0', '');
					triggerEventNote('Play Animation', 'liveReaction', 'dad');
					//if (!hasBfSkin)
					//{
						bfvent.alpha = 1;
						bfvent.animation.play('vent', true);
					//}
					if (!gfBlacklist.contains(ClientPrefs.gfSkin))
					{
						ldSpeaker.animation.play('boom', true);
						ldSpeaker.alpha = 1;
					}
				case 'bye':
					camGame.alpha = 0;
			}
		case 'Lights out':
			if (value1 == '2')
			{
				// FlxTween.tween(global.get('dark'), {lightness: -0.8, saturation: -0.7}, 2, {ease: (ClientPrefs.flashing ? FlxEase.bounceOut : FlxEase.linear)});
				return;
			}
			if (value1 == '1' && !ClientPrefs.flashing) return;
			// My favorite VS IMPOSTOR moment is when we loaded the dad shader despite this never being used outside of this song/character.
			camGame.flash(ClientPrefs.flashing ? FlxColor.WHITE : FlxColor.BLACK, 0.35);
			gf.alpha = 0;
			FlxG.camera.filters = null;
			//pet.alpha = 0;
			loBlack.alpha = 1;
			playHUD.iconP1.shader = lightsShader;
			playHUD.iconP2.shader = lightsShader;
			
			triggerEventNote('Change Character', '1', 'green-dark');
			dad.shader = null;
			
			playHUD.healthBar.bg.setColorTransform(0, 0, 0, 1, 255, 255, 255);
			
			if (boyfriend.curCharacter == 'bf' || boyfriend.curCharacter == 'bf-dark')
			{
				triggerEventNote('Change Character', '0', 'bf-dark');
				boyfriend.shader = null;
			}
			else
			{
				boyfriend.shader = lightsShader;
				
				// if (!ClientPrefs.shaders)
				// 	boyfriend.setColorTransform(-255, -255, -255, 1, 255, 255, 255);
			}
			
			/* if (!ClientPrefs.shaders)
			{
				playHUD.iconP1.setColorTransform(-255, -255, -255, 1, 255, 255, 255);
				playHUD.iconP2.setColorTransform(-255, -255, -255, 1, 255, 255, 255);
			} */
			
			playHUD.healthBar.setColors(FlxColor.BLACK, FlxColor.WHITE);
		case 'Lights on':
			if (value1 == '1' && !ClientPrefs.flashing) return;
			gf.alpha = 1;
			FlxG.camera.filters = [new ShaderFilter(darkShader)];
			//pet.alpha = 1;
			playHUD.iconP1.shader = null;
			playHUD.iconP2.shader = null;
			// global.get('dark').lightness = -0.8;
			// global.get('dark').saturation = -0.7;
			camGame.flash(FlxColor.BLACK, 0.35);
			loBlack.alpha = 0;
			
			playHUD.healthBar.bg.setColorTransform();
			
			if (boyfriend.curCharacter == 'bf-dark') triggerEventNote('Change Character', '0', PlayState.SONG.player1);
			
			/* boyfriend.setColorTransform();
			playHUD.iconP1.setColorTransform();
			playHUD.iconP2.setColorTransform(); */
			
			setVignette(vignette);
			
			triggerEventNote('Change Character', '1', PlayState.SONG.player2);
	}
}
