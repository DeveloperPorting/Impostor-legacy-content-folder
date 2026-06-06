import funkin.utils.MathUtil;
import funkin.scripting.PluginsManager;

var ext = 'stages/dlc/beach/';
public var maroon:Character;
public var grey:Character;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

public var loBlack:FlxSprite;
public var flashback:FlxSprite;
public var logo:FlxSprite;
var rimlights:Map = new haxe.ds.ObjectMap();
var parasite:Bool = false;

// bg shader
//var sunShader:HeatwaveShader = (ClientPrefs.shaders ? new funkin.game.shaders.HeatwaveShader() : null);
//var seaShader:HeatwaveShader = (ClientPrefs.shaders ? new funkin.game.shaders.HeatwaveShader() : null);

// character shaders
//var boilingShader:HeatwaveShader = (ClientPrefs.shaders ? new funkin.game.shaders.HeatwaveShader() : null); // thats enough boiling shaders bro :heart:
//var chromShader:ChromaticAbberation = (ClientPrefs.shaders ? new funkin.game.shaders.ChromaticAbberation(0) : null);
//var boilingFilter:ShaderFilter = (boilingShader != null ? new openfl.filters.ShaderFilter(boilingShader.shader) : null);
//var chromFilter:ShaderFilter = (chromShader != null ? new openfl.filters.ShaderFilter(chromShader.shader) : null);

function onLoad()
{
	camGame.filters = [];
	
	var bg:FlxSprite = new FlxSprite(-700, -290).loadGraphic(Paths.image(ext + 'sky'));
	add(bg);
	
	var sun:FlxSprite = new FlxSprite(-710, -290).loadGraphic(Paths.image(ext + 'sun'));
	sun.scrollFactor.set(0.98, 0.98);
	sun.blend = BlendMode.ADD;
	add(sun);
	
	FlxTween.tween(bg, {y: -200}, 180, {ease: FlxEase.linear});
	FlxTween.tween(sun, {y: -200}, 180);
	
	var land:FlxSprite = new FlxSprite(-700, -200).loadGraphic(Paths.image(ext + 'land'));
	add(land);
	
	// this is the separated sea sprite
	var sea:FlxSprite = new FlxSprite(-700, -200).loadGraphic(Paths.image(ext + 'sea'));
	add(sea);
	
	if (seaShader != null)
	{
		//sea.shader = seaShader.shader;
		// seaShader.shader.distortTexture.input = Paths.image('stages/dlc/beach/blabla').bitmap; if u wanna change the distort texture -ashley
	}
	//if (sunShader != null) sun.shader = add(sunShader).shader;
	
	//if (boilingShader != null) add(boilingShader);
	//if (chromShader != null) add(chromShader); // i mean this one wont do jackshit but -ashley
}

function onUpdatePost(elapsed:Float)
{
	for (character in rimlights.keys())
	{
		var rimlight = rimlights.get(character);
		
		var uv = character.frame.uv;
		rimlight.setFloatArray('uFrameBounds', [uv.x, uv.y, uv.width, uv.height]);
		rimlight.setFloat('angOffset', character.frame.angle * Math.PI / 180);
	}
	
	/*if (seaShader != null) seaShader.update(elapsed * .5); // updating this one manually so its more slow -ashley
	
	if (chromShader != null) chromShader.amount = MathUtil.fpsLerp(chromShader.amount, 0, .06); // feel FREE to replace this is sample code -ashley*/
}

function onCreatePost()
{
	maroon = new Character(-600, 430, 'maroonthreat');
	PluginsManager.callPluginFunc('PlayStateLegacy', 'startCharacterPos', [maroon]);
	add(maroon);
	maroon.danceEveryNumBeats = 1;
	maroon.alpha = 0.0001;
	
	maroonParasite = new Character(-450, 240, 'maroonParasite');
	PluginsManager.callPluginFunc('PlayStateLegacy', 'startCharacterPos', [maroonParasite]);
	add(maroonParasite);
	maroonParasite.alpha = 0.0001;
	
	grey = new Character(-700, 380, 'greythreat');
	PluginsManager.callPluginFunc('PlayStateLegacy', 'startCharacterPos', [grey]);
	add(grey);
	grey.danceEveryNumBeats = 1;
	grey.alpha = 0.0001;
	
	var subtract:FlxSprite = new FlxSprite(-700, -200).loadGraphic(Paths.image(ext + 'subtract'));
	subtract.blend = BlendMode.SUBTRACT;
	subtract.alpha = 0.6;
	add(subtract);
	FlxTween.tween(subtract, {alpha: 1}, 180, {ease: FlxEase.linear});
	
	if (ClientPrefs.shaders)
	{
		for (character in [boyfriend, gf, dad, grey, maroon, maroonParasite])
		{
			var rimlight = newShader('rimlight1');
			
			rimlight.setFloatArray('dropColor', [236, 136, 0]);
			
			rimlight.setBool('useMask', false);
			rimlight.setFloat('AA_STAGES', 100); // antialiasing detail (use wiht care)
			rimlight.setFloat('thr', 0.05); // sprites lihgter than this point (from 0 to 1) will suffer th effects of rim light
			
			rimlight.setFloat('hue', 0);
			rimlight.setFloat('saturation', -20);
			rimlight.setFloat('brightness', 0);
			
			rimlight.setFloat('str', 1); // strength
			rimlight.setFloat('dist', 14); // distance
			rimlight.setFloat('ang', (character == boyfriend ? 135 : 45) * Math.PI / 180); // angle (radians)
			
			character.useRenderTexture = true;
			
			rimlights.set(character, rimlight);
		}
		
		boyfriend.shader = rimlights.get(boyfriend);
		dad.shader = rimlights.get(dad);
		gf.shader = rimlights.get(gf);
		
		rimlights.get(gf).setFloat('ang', Math.PI / 2);
		rimlights.get(dad).setFloat('dist', 20);
	}
	
	intro = new FunkinVideoSprite();
	intro.cameras = [camOther];
	
	intro.onFormat(() -> {
		intro.setGraphicSize(FlxG.width);
		intro.screenCenter();
		add(intro);
	});
	intro.onEnd(() -> {
		camGame.alpha = 1;
		camHUD.alpha = 1;
		camGame.flash(0xFFFFFFFF, 0.35);
		intro.kill();
	});
	intro.antialiasing = ClientPrefs.globalAntialiasing;
	intro.load(Paths.video('tthreat'), [FunkinVideoSprite.muted]);
	
	intro.play();
	intro.pause();
	intro.tiedToGame = false;
	
	loBlack = new FlxSprite(-700, -200).makeGraphic(3284, 1492, FlxColor.BLACK);
	loBlack.alpha = 0.001;
	loBlack.screenCenter();
	add(loBlack);
	
	snapCamToPos(1100, 550);
	camSpecialThing([950, 550], [950, 550]);
	
	flashback = new FlxSprite(1420, -100);
	flashback.frames = Paths.getSparrowAtlas(ext + 'flashbacks');
	flashback.animation.addByPrefix('1', 's0001', 1, false);
	flashback.animation.addByPrefix('2', 's0002', 1, false);
	flashback.animation.addByPrefix('3', 's0003', 1, false);
	flashback.animation.addByPrefix('4', 's0004', 1, false);
	flashback.animation.addByPrefix('5', 's0005', 1, false);
	flashback.animation.addByPrefix('6', 's0006', 1, false);
	flashback.animation.addByPrefix('7', 's0007', 1, false);
	flashback.animation.addByPrefix('8', 's0008', 1, false);
	flashback.animation.addByPrefix('9', 's0009', 1, false);
	flashback.alpha = 0.001;
	add(flashback);
	
	logo = new FlxSprite(1320, -190).loadGraphic(Paths.image(ext + 'triplethreat'));
	logo.scale.set(0.8, 0.8);
	logo.alpha = 0.001;
	add(logo);
}

function opponentNoteHitPre(note)
{
	if (note.noteType == 'Opponent 2 Sing')
	{
		note.owner = maroon;
	}
	if (note.noteType == 'Opponent 3 Sing')
	{
		note.owner = grey;
	}
	if (note.noteType == 'Opponent 4 Sing')
	{
		note.owner = maroonParasite;
	}
	if (note.noteType == 'Hey!')
	{
		note.owner = maroon;
		maroon.animation.play('hey', true);
		maroon.specialAnim = true;
	}
}

function onEvent(n, v1, v2)
{
	switch (n)
	{
		case 'Legacy':
			switch (v1)
			{
				case 'forcecamtarget':
					switch (v2)
					{
						case 'grey':
							camCurTarget = grey;
						case 'maroon':
							camCurTarget = parasite ? maroonParasite : maroon;
						default:
							camCurTarget = null;
					}
			}
	}
}

function onCountdownTick()
{
	if (curBeat % 2 == 0)
	{
		maroon.onBeatHit(curBeat);
		grey.onBeatHit(curBeat);
	}
}

function onBeatHit():Void
{
	// feel FREE to replace this is also sample code -ashley
	/*if (chromShader != null && curBeat % 2 == 0) chromShader.amount = 1;
	if (curBeat % 2 == 0)
	{
		maroon.onBeatHit(curBeat);
		grey.onBeatHit(curBeat);
	}*/
}

function onStepHit()
{ //                               MAIN EVENTS
	if (curStep == 240)
	{
		maroon.alpha = 1;
		maroon.shader = rimlights.get(maroon);
		FlxTween.tween(maroon, {x: dad.x - 150}, 1, {ease: FlxEase.quadOut});
		dad.animation.play('wow', true);
		dad.specialAnim = true;
		FlxTween.tween(dad, {x: dad.x + 150}, 1, {ease: FlxEase.quadOut});
		camSpecialThing([850, 550], [950, 550]);
	}
	if (curStep == 260)
	{
		iconP2.changeIcon('tt1');
	}
	if (curStep == 680)
	{
		camGame.alpha = camHUD.alpha = 0;
		taskGroup.visible = false;
		intro.play();
		intro.tiedToGame = true;
	}
	if (curStep == 690)
	{
		camSpecialThing([600, 550], [950, 550]);
		grey.alpha = 1;
		FlxTween.tween(dad, {x: dad.x + 75}, 1, {ease: FlxEase.quadOut});
		maroon.x = -60;
		maroon.y = 405;
		grey.shader = rimlights.get(grey);
	}
	if (curStep == 808)
	{
		triggerEventNote('Alt Idle Animation', 'Dad', '-alt');
		iconP2.changeIcon('tt2');
		camGame.flash(ClientPrefs.flashing ? FlxColor.WHITE : FlxColor.BLACK, 0.5);
		grey.animation.play('idle', true);
		if (chromFilter != null) camGame.filters.push(chromFilter);
	}
	if (curStep == 1192)
	{
		camGame.filters.remove(chromFilter);
	}
	if (curStep == 1300)
	{
		maroon.animation.play('shift', true);
		maroon.specialAnim = true;
		maroon.y = maroon.y - 57;
	}
	if (curStep == 1320)
	{
		camGame.flash(ClientPrefs.flashing ? FlxColor.RED : FlxColor.ORANGE, 2);
		iconP2.changeIcon('tt3');
		maroon.shader = null;
		maroon.alpha = 0.0001;
		parasite = true;
		maroonParasite.alpha = 1;
		maroonParasite.useRenderTexture = true;
		maroonParasite.shader = rimlights.get(maroonParasite);
		FlxTween.tween(dad, {x: dad.x + 160}, 1, {ease: FlxEase.quadOut});
		FlxTween.tween(maroonParasite, {x: maroonParasite.x + 50}, 1, {ease: FlxEase.quadOut});
		camSpecialThing([700, 550], [1000, 550]);
		if (boilingFilter != null) camGame.filters.push(boilingFilter);
	}
	if (curStep == 1576)
	{
		camGame.filters.remove(boilingFilter);
	}
	if (curStep == 1640)
	{
		if (chromFilter != null) camGame.filters.push(chromFilter);
	}
	if (curStep == 1672)
	{
		if (boilingFilter != null) camGame.filters.push(boilingFilter);
	}
	if (curStep == 1704)
	{
		camGame.filters.remove(boilingFilter);
		camGame.filters.remove(chromFilter);
	}
	if (curStep == 1712)
	{
		if (boilingFilter != null) camGame.filters.push(boilingFilter);
	}
	if (curStep == 1728)
	{
		camGame.filters.remove(boilingFilter);
	}
	if (curStep == 1744)
	{
		if (chromFilter != null) camGame.filters.push(chromFilter);
	}
	if (curStep == 1768)
	{
		camGame.filters.remove(chromFilter);
	}
}

// if (boilingFilter != null) camGame.filters.push(boilingFilter); //adds boiling shader
// camGame.filters.remove(boilingFilter); // removes boiling shader
// if (chromFilter != null) camGame.filters.push(chromFilter);
// camGame.filters.remove(chromFilter);
