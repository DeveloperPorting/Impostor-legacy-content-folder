import funkin.game.shaders.DropShadowShader;
import funkin.states.substates.GameOverSubstate;
import funkin.states.substates.PauseSubState;

var lightoverlay:FlxSprite;
var bodies2:FlxSprite;
var bodies:FlxSprite;
var bodiesfront:FlxSprite;
var old_defeat:FlxSprite;
var defeatthing:FlxSprite;
var subtract:FlxSprite;
var edgeglow1:FlxSprite;
var edgeglow2:FlxSprite;
var glowTween1:FlxTween;
var glowTween2:FlxTween;
var ext:String = 'stages/void/';
var bfSwapChar:String = '';
public var redscreen:FlxSprite;

public var nonDeathSkins:Array<String> = ['redp', 'greenp', 'yellowplayable', 'whitep', 'blackp', 'maroonplayable', 'minigrey', 'pinkplayable',
	'fall-guy', 'amongbf', 'dripbf', 'upboy', 'bf-ghost', 'bf-stick'];
	
public var rimlightExcludedSkins:Array<String> = ['blackp']; // ig we need this now
var bfRim:DropShadowShader;
var petRim:DropShadowShader;

// BF AIRSHIP HAS HIS OWN GAMEOVER APPARENTLY #FUCK
// it dont even matter lowkey

var isRetro:Bool = false;

function onLoad()
{
	healthLoss = 0;
	
	defeatthing = new FlxSprite(-400, -150);
	defeatthing.frames = Paths.getSparrowAtlas(ext + 'defeat');
	defeatthing.animation.addByPrefix('bop', 'defeat', 24, false);
	defeatthing.animation.play('bop');
	defeatthing.setGraphicSize(Std.int(defeatthing.width * 1.3));
	defeatthing.antialiasing = ClientPrefs.globalAntialiasing;
	defeatthing.scrollFactor.set(0.8, 0.8);
	add(defeatthing);
	
	old_defeat = new FlxSprite(250, 125).loadGraphic(Paths.image(ext + 'defeatfnf'));
	old_defeat.antialiasing = ClientPrefs.globalAntialiasing;
	old_defeat.setGraphicSize(Std.int(old_defeat.width * 2));
	old_defeat.alpha = 0.01;
	add(old_defeat);
	
	bodies2 = new FlxSprite(-500, 50).loadGraphic(Paths.image(ext + 'idontknwo'));
	bodies2.antialiasing = ClientPrefs.globalAntialiasing;
	bodies2.setGraphicSize(Std.int(bodies2.width * 1.3));
	bodies2.scrollFactor.set(0.5, 0.5);
	bodies2.alpha = 0.001;
	add(bodies2);
	
	bodies = new FlxSprite(-4800, -900).loadFromSheet(ext + 'props', 'deadBG');
	bodies.scale.set(5, 5);
	bodies.updateHitbox();
	bodies.setGraphicSize(Std.int(bodies.width * 0.26));
	bodies.antialiasing = ClientPrefs.globalAntialiasing;
	bodies.scrollFactor.set(0.9, 0.9);
	bodies.alpha = 0.001;
	add(bodies);
	
	edgeglow1 = new FlxSprite(-1000, -720).loadGraphic(Paths.image(ext + 'edgeglow'));
	edgeglow1.scale.set(1.6, 1.6);
	edgeglow1.updateHitbox();
	edgeglow1.blend = BlendMode.ADD;
	edgeglow1.antialiasing = ClientPrefs.globalAntialiasing;
	edgeglow1.scrollFactor.set(0, 0);
	edgeglow1.zIndex = 4;
	edgeglow1.alpha = 0.001;
	add(edgeglow1);
	
	edgeglow2 = new FlxSprite(-1000, 720).loadGraphic(Paths.image(ext + 'edgeglow'));
	edgeglow2.scale.set(1.6, 1.6);
	edgeglow2.updateHitbox();
	edgeglow2.blend = BlendMode.ADD;
	edgeglow2.antialiasing = ClientPrefs.globalAntialiasing;
	edgeglow2.scrollFactor.set(0, 0);
	edgeglow2.alpha = 0.001;
	edgeglow2.zIndex = 4;
	add(edgeglow2);
	
	subtract = new FlxSprite(-700, -500).loadGraphic(Paths.image(ext + 'subtract'));
	subtract.scale.set(4, 4);
	subtract.updateHitbox();
	subtract.blend = BlendMode.SUBTRACT;
	subtract.antialiasing = ClientPrefs.globalAntialiasing;
	subtract.scrollFactor.set(0, 0);
	subtract.zIndex = 2;
	subtract.alpha = 0.001;
	add(subtract);
	
	redscreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFA90000);
	redscreen.scrollFactor.set();
	redscreen.alpha = 0.001;
	redscreen.cameras = [camHUD];
	add(redscreen);
}

function turnShader(?should = false)
{
	boyfriend.shader = (should && hasBfSkin && !rimlightExcludedSkins.contains(ClientPrefs.bfSkin) ? bfRim : null);
	//pet.shader = (should ? petRim : null);
}

function onCreatePost()
{
	// DWP
	playHUD.timeBar.visible = false;
	playHUD.timeTxt.visible = false;
	
	playHUD.updateIconPos = false;
	iconP1.x = (FlxG.width - iconP1.width) / 2 + 50;
	iconP2.x = (FlxG.width - iconP2.width) / 2 - 50;
	iconP1.visible = false;
	iconP2.visible = false;
	// wait. I'm white!
	
	switch (boyfriend.curCharacter)
	{
		case 'bf-defeat-normal':
			addCharacterToList('bf-defeat-scared', 0);
			bfSwapChar = 'bf';
		case 'bf-ghost':
			bfSwapChar = 'bf-ghost-retro';
	}
	if (bfSwapChar != '') addCharacterToList(bfSwapChar, 0);
	addCharacterToList('blackold', 1);
	
	comboX = 440;
	snapCamToPos(750, 500);
	dadGroup.zIndex = 1;
	boyfriendGroup.zIndex = 0;
	bodiesfront = new FlxSprite(-3770, -250).loadFromSheet(ext + 'props', 'deadFG');
	bodiesfront.scale.set(5, 5);
	bodiesfront.updateHitbox();
	bodiesfront.setGraphicSize(Std.int(bodiesfront.width * 0.3));
	bodiesfront.antialiasing = ClientPrefs.globalAntialiasing;
	bodiesfront.scrollFactor.set(1.5, 1.2);
	bodiesfront.alpha = 0.001;
	bodiesfront.zIndex = 2;
	if (!ClientPrefs.lowQuality) add(bodiesfront);
	
	lightoverlay = new FlxSprite(-500, -200).loadGraphic(Paths.image(ext + 'iluminao omaga'));
	lightoverlay.scale.set(4, 4);
	lightoverlay.updateHitbox();
	lightoverlay.blend = BlendMode.ADD;
	lightoverlay.antialiasing = ClientPrefs.globalAntialiasing;
	lightoverlay.zIndex = 3;
	add(lightoverlay);
	
	redscreen.zIndex = 3;
	
	refreshZ();
	
	if (ClientPrefs.shaders)
	{
		/*if (hasBfSkin && !rimlightExcludedSkins.contains(ClientPrefs.bfSkin))
		{
			bfRim = new DropShadowShader();
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
		}
		
		if (hasPet)
		{
			petRim = new DropShadowShader();
			petRim.setAdjustColor(-60, 25, -9, 3);
			petRim.color = 0xFFff2b2b;
			petRim.angle = 45;
			petRim.distance = 25;
			petRim.threshold = 0.1;
			petRim.attachedSprite = pet;
			pet.animation.onFrameChange.add(function() {
				if (petRim.attachedSprite != null) petRim.updateFrameInfo(pet.frame);
			});
		}*/
		
		turnShader(true);
	}
	
	camSpecialThing([750, 500], [750, 500], defaultCamZoom);
	
	PauseSubState.songName = 'blackPause';
}

function onBeatHit()
{
	if (curBeat % 4 == 0)
	{
		defeatthing.animation.play('bop', true);
		if (edgeglow1.alpha > 0.01)
		{
			if (glowTween1 != null) glowTween1.cancel();
			if (glowTween2 != null) glowTween2.cancel();
			
			edgeglow1.alpha = 1;
			edgeglow2.alpha = 1;
			
			glowTween1 = FlxTween.tween(edgeglow1, {alpha: 0.6}, 0.35, {ease: FlxEase.bounceOut});
			glowTween2 = FlxTween.tween(edgeglow2, {alpha: 0.6}, 0.35, {ease: FlxEase.bounceOut});
		}
	}
}

var playingCutscene:Bool = false;

function onGameOver()
{
	if (playingCutscene) return Function_Continue;
	
	health = 1;
	playingCutscene = true;
	game.startedCountdown = false;
	
	if (startTimer != null) startTimer.cancel();
	
	// Checking for If you don't have a skin or a compatible one
	
	if (!hasBfSkin || hasBfSkin && !nonDeathSkins.contains(ClientPrefs.bfSkin))
	{
		var retroSuffix:String = isRetro ? '-retro' : ''; // If you're on the flashback section use the v3 gameover
		// Random chance for alternate game over
		if (FlxG.random.bool(10))
		{
			boyfriend.gameoverCharacter = 'bf-defeat-dead-balls' + retroSuffix;
			boyfriend.gameoverInitialDeathSound = 'stage/defeat_kill_ballz_sfx' + retroSuffix;
		}
		else if (boyfriend.gameoverCharacter != 'bf-defeat-dead')
		{
			boyfriend.gameoverCharacter = 'bf-defeat-dead' + retroSuffix;
			boyfriend.gameoverInitialDeathSound = 'stage/defeat_kill_sfx' + retroSuffix;
		}
		
		if (!isRetro) blackGameOver();
		else blackGameOverV3();
		// Stop Everything !!
		
		return Function_Stop;
	}
}

function onGameOverStart() if (isRetro) FlxG.camera.bgColor = 0xFF1A182E;

function blackGameOver()
{
	for (note in notes)
	{
		note.ignoreNote = true;
		note.visible = false;
	}
	
	startingSong = true;
	startedCountdown = false;
	
	boyfriend.stunned = boyfriend.skipDance = true;
	isCameraOnForcedPos = true;
	inCutscene = true;
	canPause = false;
	camZooming = false;
	
	audio.playerVolume = 0;
	audio.opponentVolume = 0;
	FlxTween.tween(audio.inst, {volume: 0}, 1.5, {ease: FlxEase.expoOut});
	
	camFollow.setPosition(550, 500);
	FlxTween.tween(camHUD, {alpha: 0}, .7, {ease: FlxEase.quadInOut});
	FlxTween.tween(FlxG.camera, {zoom: 0.65}, 1, {ease: FlxEase.quadInOut});
	
	dad.playAnim('kill', true);
	dad.specialAnim = true;
	dad.animation.onFinish.add((animName) -> {
		if (animName == 'kill')
		{
			// I don't know why this was split into two anims but its whatever
			dad.animation.play('kill2', true);
			dad.specialAnim = true;
		}
		else if (animName == 'kill2')
		{
			playingCutscene = true;
			doDeathCheck(true);
		}
	});
	dad.animation.onFrameChange.add((animName, frameNumber, frameIndex) -> {
		if (animName == 'kill' && frameNumber == 6)
		{
			// Delay so the sound lines up better with the mic dropping/landing
			FlxG.sound.play(Paths.sound('stage/defeat_prekill_sfx'));
		}
	});
}

function blackGameOverV3() // For if you die during the flashback section
{
	for (note in notes)
	{
		note.ignoreNote = true;
		note.visible = false;
	}
	
	startingSong = true;
	startedCountdown = false;
	
	isCameraOnForcedPos = true;
	inCutscene = true;
	boyfriend.stunned = boyfriend.skipDance = true;
	canPause = false;
	camZooming = false;
	audio.playerVolume = 0;
	audio.opponentVolume = 0;
	audio.inst.volume = 0;
	
	camFollow.setPosition(550, 500);
	FlxTween.tween(camHUD, {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
	FlxTween.tween(FlxG.camera, {zoom: 1.2}, 1.5, {ease: FlxEase.circOut});
	FlxG.sound.play(Paths.sound('stage/defeat_prekill_sfx_v3'));
	
	dad.playAnim('death', true);
	dad.specialAnim = true;
	dad.animation.onFinish.add((animName) -> {
		if (animName == 'death')
		{
			snapCamToPos(boyfriend.getGraphicMidpoint().x - 23, boyfriend.getGraphicMidpoint().y - 20, false); // this was a pain in the ass
			playingCutscene = true;
			doDeathCheck(true);
		}
	});
}

var prevAfterimages:Bool;
var prevScoreColor:FlxColor;

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Defeat Retro':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;
			
			switch (charType)
			{
				case 0:
					prevAfterimages = boyfriend.ghostsEnabled;
					prevScoreColor = scoreTxt.color;
					
					if (bfSwapChar != '') changeCharacter(bfSwapChar, 0);
					
					boyfriend.ghostsEnabled = false;
					
					for (i in [bodies, bodies2, bodiesfront, lightoverlay, subtract, edgeglow2, edgeglow1, iconP1, iconP2])
					{
						i.alpha = 0.001;
					}
					
					old_defeat.alpha = 1;
					defeatthing.alpha = 0.001;
					turnShader(false);
					scoreTxt.size = 16;
					scoreTxt.color = FlxColor.WHITE;
					if (hasPet) pet.visible = false;
					isRetro = true;
				case 1:
					changeCharacter(hasBfSkin ? ClientPrefs.bfSkin : 'bf-defeat-scared', 0);
					changeCharacter('black', 1);
					
					boyfriend.ghostsEnabled = prevAfterimages;
					
					for (i in [bodies, bodies2, bodiesfront, lightoverlay, subtract, edgeglow2, edgeglow1,])
					{
						i.alpha = 1;
					}
					
					old_defeat.alpha = 0.001;
					defeatthing.alpha = 1;
					scoreTxt.color = prevScoreColor;
					scoreTxt.size = 20;
					turnShader(true);
					if (hasPet) pet.visible = true;
					isRetro = false;
			}
		case 'Defeat Fade':
			var charType:Int = Std.parseInt(value1);
			if (Math.isNaN(charType)) charType = 0;
			
			switch (charType)
			{
				case 0:
					if (boyfriend.curCharacter == 'bf-defeat-normal') triggerEventNote('Change Character', '0', 'bf-defeat-scared');
					FlxTween.tween(bodies, {alpha: 1}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(bodies2, {alpha: 1}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(bodiesfront, {alpha: 1}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(edgeglow1, {alpha: 0.5}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(edgeglow2, {alpha: 0.5}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(subtract, {alpha: 1}, 0.7, {ease: FlxEase.quadInOut});
				case 1:
					FlxTween.tween(bodies, {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(bodies2, {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(bodiesfront, {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(edgeglow1, {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(edgeglow2, {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
					FlxTween.tween(subtract, {alpha: 0}, 0.7, {ease: FlxEase.quadInOut});
			}
	}
}
