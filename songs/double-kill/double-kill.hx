public var rimlightExcludedSkins:Array<String> = ['blackp']; // ig we need this now
var cargoDarkFG:FlxSprite;
var cargoDarken:Bool = false;
var cargoAirship:FlxSprite;
var showDlowDK:Bool = false;
var defeatDKoverlay:FlxSprite;
var testMode:Bool = false;

function onCreatePost()
{
	if (!hasBfSkin) addCharacterToList('bf-defeat-normal', 0);
	reactorFade = 1;
	cargoAirsip = new FlxSprite(2200, 800).loadGraphic(Paths.image('stages/airship/double-kill/airshipFlashback'));
	cargoAirsip.antialiasing = true;
	cargoAirsip.updateHitbox();
	cargoAirsip.scrollFactor.set(1, 1);
	cargoAirsip.setGraphicSize(Std.int(cargoAirsip.width * 1.3));
	cargoAirsip.alpha = 0.001;
	add(cargoAirsip);
	
	camHUD.visible = false;
	cargoDarkFG = new FlxSprite(-640, -360).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
	cargoDarkFG.scrollFactor.set(0, 0);
	
	defeatDKoverlay = new FlxSprite(900, 350).loadGraphic(Paths.image('stages/void/iluminao omaga'));
	defeatDKoverlay.blend = BlendMode.ADD;
	defeatDKoverlay.alpha = 0.001;
	defeatDKoverlay.scale.set(4, 4);
	defeatDKoverlay.updateHitbox();
	add(defeatDKoverlay);
	add(cargoDarkFG);
	if (testMode) cargoDarkFG.alpha = 0;
	
	camSpecialThing([2000, 1050], [2300, 1050], -1);
}

function onUpdate(elapsed)
{
	// i want to know who did this bullshit in source.
	if (Conductor.songPosition >= 0 && Conductor.songPosition < 1200)
	{
		cargoDarkFG.alpha -= elapsed / 5;
		FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 1, FlxMath.bound(elapsed * 3, 0, 1));
	}
	if (cargoDarken)
	{
		cargoDark.alpha = FlxMath.lerp(cargoDark.alpha, 1, FlxMath.bound(elapsed * 1.4, 0, 1));
		dad.alpha = FlxMath.lerp(dad.alpha, 0.001, FlxMath.bound(elapsed * 1.4, 0, 1));
		gf.alpha = FlxMath.lerp(gf.alpha, 0.001, FlxMath.bound(elapsed * 1.4, 0, 1));
		// pet.alpha = FlxMath.lerp(pet.alpha, 0.001, FlxMath.bound(elapsed * 1.4, 0, 1));
		mainoverlayDK.alpha = FlxMath.lerp(mainoverlayDK.alpha, 0.001, FlxMath.bound(elapsed * 1.4, 0, 1));
		lightoverlayDK.alpha = FlxMath.lerp(lightoverlayDK.alpha, 0.001, FlxMath.bound(elapsed * 1.4, 0, 1));
	}
	if (showDlowDK)
	{
		cargoAirsip.alpha = FlxMath.lerp(cargoAirsip.alpha, 0.45, FlxMath.bound(elapsed * 0.1, 0, 1));
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'flash':
			cargoDarkFG.alpha = 0;
			camHUD.visible = true;
		case 'Legacy':
			switch (value1)
			{
				case 'wmc': // weird mid cam
					camSpecialThing([2150, 1050], [2150, 1050]);
				case 'nc': // normal cam
					camSpecialThing([2000, 1050], [2300, 1050]);
				case 'ncy': // normal cam
					camSpecialThing([2000, 1050], [isBfGhost ? 2600 : 2300, 1050]);
				case '356':
					camSpecialThing(-1, [2750, 1150], 1.1);
				case '420':
					camSpecialThing(-1, [2300, 1050], 0.8);
				case '552':
					camSpecialThing([1650, 1180], -1, 1.2);
					if (isBfGhost) FlxTween.tween(yellow, {alpha: 1}, Conductor.stepCrotchet / 1000);
				case '556':
					camSpecialThing([2000, 1050], isBfGhost ? [2600, 1050] : -1, 0.8);
				case 'darken':
					cargoDarken = true;
					camGame.flash(FlxColor.BLACK, 0.55);
				case 'airship':
					showDlowDK = true;
				case 'brighten':
					showDlowDK = false;
					cargoDarken = false;
					cargoAirsip.alpha = 0.001;
					cargoDark.alpha = 0.001;
					dad.alpha = 1;
					gf.alpha = 1;
					// pet.alpha = 1;
					lightoverlayDK.alpha = 0.51;
					mainoverlayDK.alpha = 0.6;
				case 'readykill':
					if (!hasBfSkin) triggerEventNote('Change Character', '0', 'bf-defeat-normal');
					
					if (yellow != null) yellow.kill();
					if (ClientPrefs.downScroll) playHUD.scoreTxt.y = FlxG.height * 0.06;
					defeatDKoverlay.alpha = 1;
					lightoverlayDK.alpha = 0;
					mainoverlayDK.alpha = 0;
					cargoDark.alpha = 1;
					dad.alpha = 0;
					playHUD.timeBar.alpha = 0;
					playHUD.timeTxt.alpha = 0;
					playHUD.healthBar.alpha = 0;
					playHUD.iconP1.alpha = 0;
					playHUD.iconP2.alpha = 0;
					cargoDarkFG.alpha = 1;
					FlxTween.tween(cargoDarkFG, {alpha: 0}, 2.75);
					
					defeatness();
				case 'kill':
					camGame.flash(FlxColor.RED, 2.75);
					gf.kill();
					//pet.kill();
					boyfriend.kill();
					camHUD.visible = false;
					defeatDKoverlay.alpha = 0;
			}
	}
}

function defeatness():Void
{
	if (!ClientPrefs.shaders) return;
	
	/*if (hasBfSkin && !rimlightExcludedSkins.contains(ClientPrefs.bfSkin))
	{
		var bfRim:DropShadowShader = new funkin.game.shaders.DropShadowShader();
		bfRim.setAdjustColor(-60, 25, -9, -9);
		bfRim.color = 0xFFff2b2b;
		bfRim.angle = 45;
		bfRim.distance = 25;
		bfRim.threshold = 0.07;
		bfRim.attachedSprite = boyfriend;
		boyfriend.animation.onFrameChange.add(function() {
			if (bfRim.attachedSprite != null) bfRim.updateFrameInfo(boyfriend.frame);
		});
		boyfriend.useRenderTexture = true;
		boyfriend.shader = bfRim;
	}
	
	if (hasPet)
	{
		var petRim:DropShadowShader = new funkin.game.shaders.DropShadowShader();
		petRim.setAdjustColor(-60, 25, -9, 3);
		petRim.color = 0xFFff2b2b;
		petRim.angle = 45;
		petRim.distance = 25;
		petRim.threshold = 0.1;
		petRim.attachedSprite = pet;
		pet.animation.onFrameChange.add(function() {
			if (petRim.attachedSprite != null) petRim.updateFrameInfo(pet.frame);
		});
		pet.shader = petRim;
	}*/
}
