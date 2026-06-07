import funkin.data.ClientPrefs;

import flixel.FlxSprite;

var ext = 'stages/skeld/monotone/';
var introTween:FlxTween;
var black:FlxSprite;
var yapsesh:FlxSprite;
var bgblue:FlxSprite;
var blueRoom:FlxSpriteGroup;
var redRoom:FlxSpriteGroup;
var greenRoom:FlxSpriteGroup;
var bggreen:FlxSprite;
var tower:FlxSprite;
var defeatthing:FlxSprite;
var bggreen:FlxSprite;
var greentower:FlxSprite;
var platform:FlxSprite;
var speedlines:FlxBackdrop;
var funTime:Float;
var blackImage:FlxSprite;
var lightoverlay:FlxSprite;
var lightoverlay2:FlxSprite;
var hsv1:HSLColorSwap = (ClientPrefs.shaders ? new funkin.game.shaders.HSLColorSwap() : null);
var spinPet = false;
var pet2:FlxSprite = new FlxSprite(50, 1060);
var allmonotones = ["monotone", "red", "greenEjected", "blackdk"];

function onDestroy()
{
	FlxG.camera.bgColor = 0xFF000000;
}

function onLoad()
{
	FlxG.camera.bgColor = 0xFF201F34;
	blueRoom = new FlxSpriteGroup();
	redRoom = new FlxSpriteGroup();
	greenRoom = new FlxSpriteGroup();
	redRoom.alpha = 0.0001;
	greenRoom.alpha = 0.0001;
	
	pet.origin.set(pet.width / 2, pet.height - 50);
	
	// kino.lua
	// awesome reference ty
	var bars:FlxSpriteGroup = new FlxSpriteGroup();
	bars.cameras = [camHUD];
	add(bars);
	
	for (i in 0...2) // maybe this is doin too much idk
	{
		var bar = new FlxSprite().makeGraphic(FlxG.width + 3, 90, FlxColor.BLACK);
		bar.y = i == 1 ? 630 : 0;
		bars.add(bar);
	}
	
	// var bgref:FlxSprite = new FlxSprite().loadGraphic(Paths.image(ext + 'SkeldBack'));
	// bgref.setGraphicSize(Std.int(bgref.width * 2));
	// add(bgref);
	
	var bbg:FlxSprite = new FlxSprite(50, 531).loadGraphic(Paths.image(ext + 'back'));
	bbg.setGraphicSize(Std.int(bbg.width * 2));
	bbg.updateHitbox();
	// bbg.alpha = 0.5;
	add(bbg);
	
	bgblue = new FlxSprite(0, 25).loadGraphic(Paths.image(ext + 'backthings'));
	bgblue.setGraphicSize(Std.int(bgblue.width * 2));
	blueRoom.add(bgblue);
	
	floor = new FlxSprite(0, 1150).loadGraphic(Paths.image(ext + 'Floor'));
	floor.setGraphicSize(Std.int(floor.width * 2));
	blueRoom.add(floor);
	
	bgred = new FlxSprite(0, 25).loadGraphic(Paths.image(ext + 'backthingsred'));
	bgred.setGraphicSize(Std.int(bgred.width * 2));
	redRoom.add(bgred);
	
	floor = new FlxSprite(0, 1150).loadGraphic(Paths.image(ext + 'Floor'));
	floor.setGraphicSize(Std.int(floor.width * 2));
	redRoom.add(floor);
	
	// DEFEAT!
	defeatthing = new FlxSprite(0, 0);
	defeatthing.frames = Paths.getSparrowAtlas('stages/void/defeat');
	defeatthing.animation.addByPrefix('bop', 'defeat', 24, false);
	defeatthing.animation.play('bop');
	defeatthing.setGraphicSize(Std.int(defeatthing.width * 3));
	defeatthing.alpha = 0.0001;
	add(defeatthing);
	
	// THIS THING
	bgblue2 = new FlxSprite(570, -150).loadGraphic(Paths.image(ext + 'Reactor'));
	bgblue2.setGraphicSize(Std.int(bgblue2.width * 2));
	blueRoom.add(bgblue2);
	
	bgred2 = new FlxSprite(570, -150).loadGraphic(Paths.image(ext + 'ReactorRed'));
	bgred2.setGraphicSize(Std.int(bgred2.width * 2));
	redRoom.add(bgred2);
	
	// LIGHTS
	bgblue3 = new FlxSprite(350, 460).loadGraphic(Paths.image(ext + 'Reactorlight'));
	bgblue3.setGraphicSize(Std.int(bgblue3.width * 2));
	bgblue3.blend = BlendMode.ADD;
	blueRoom.add(bgblue3);
	
	bgred3 = new FlxSprite(350, 460).loadGraphic(Paths.image(ext + 'ReactorLightRed'));
	bgred3.setGraphicSize(Std.int(bgred3.width * 2));
	bgred3.blend = BlendMode.ADD;
	redRoom.add(bgred3);
	
	add(blueRoom);
	add(redRoom);
	
	wires = new FlxSprite(0, -100).loadGraphic(Paths.image(ext + 'wires1'));
	wires.updateHitbox();
	add(wires);
	
	bggreen = new FlxSprite(-200, -1600).loadGraphic(Paths.image(ext + 'evilejected'));
	bggreen.scrollFactor.set(0, 0);
	bggreen.setGraphicSize(Std.int(bggreen.width * 2));
	add(bggreen);
	
	greentower = new FlxSprite(550, 0).loadGraphic(Paths.image(ext + 'brombom'));
	greentower.setGraphicSize(Std.int(greentower.width * 1.5));
	greentower.scrollFactor.set(0.1, 0.1);
	greentower.updateHitbox();
	add(greentower);
	
	bggreen.alpha = 0;
	greentower.alpha = 0;
	
	platform = new FlxSprite(1390, 1100);
	platform.frames = Paths.getSparrowAtlas('stages/common/platform');
	platform.animation.addByPrefix('bop', 'floating', 24, true);
	platform.animation.play('bop');
	platform.alpha = 0.00001;
	
	add(platform);
	
	blackImage = new FlxSprite(0, 0).makeGraphic(1920, 1080, 0xff000000);
	blackImage.scale.set(2, 2);
	add(blackImage);
	blackImage.alpha = 0.0001;
	
	// pet 2
	pet2.frames = pet.frames;
	pet2.animation.addByPrefix('idle', 'idle', 24, true);
	pet2.scale.x = -1 * pet2.scale.x;
	pet2.setColorTransform(1, 1, 1, 1, -64, -64, -64, 0);
}

function onGameOverStart()
{
	FlxG.camera.bgColor = FlxColor.BLACK;
}

function onCreatePost()
{
	if (Paths.fileExists('scripts/vent.hx')) initScript('scripts/vent');
	if (hasPet)
	{
		add(pet2);
	}
	// cache characters
	if (!hasBfSkin) addCharacterToList('bf-fall', 0);
	
	addCharacterToList('greenEjected', 1);
	addCharacterToList('monotone', 1);
	addCharacterToList('red', 1);
	addCharacterToList('blackdk', 1);
	
	if (hasBfSkin && game.boyfriend.curCharacter != 'bf-ghost')
	{
		triggerEventNote('Change Character', 'dad', game.boyfriend.curCharacter == 'yellowplayable' ? 'yellow' : game.boyfriend.curCharacter);
		dad.baseFlipX = game.boyfriend.curCharacter == 'yellowplayable' ? dad.baseFlipX : !dad.baseFlipX;
	}
	
	camHUD.alpha = 0; // doy
	
	snapCamToPos(950, 700); // fr
	camSpecialThing([950, 700], [950, 700]); // camera
	
	lightoverlay = new FlxSprite(500, 275).loadGraphic(Paths.image(ext + 'overlay'));
	lightoverlay.setGraphicSize(Std.int(lightoverlay.width * 4));
	lightoverlay.blend = BlendMode.SUBTRACT;
	if (ClientPrefs.shaders) lightoverlay.shader = hsv1.shader;
	if (!ClientPrefs.lowQuality) add(lightoverlay);
	
	lightoverlay2 = new FlxSprite(500, 275).loadGraphic(Paths.image(ext + 'overlay2'));
	lightoverlay2.blend = BlendMode.ADD;
	lightoverlay2.setGraphicSize(Std.int(lightoverlay2.width * 4));
	if (ClientPrefs.shaders) lightoverlay2.shader = hsv1.shader;
	if (!ClientPrefs.lowQuality) add(lightoverlay2);
	
	// black screen sprite
	black = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xff000000);
	black.camera = camOther;
	add(black);
	black.visible = true;
	
	// count your seconds i will tickle you! okay maybe not
	// Loggo. No other comment
	yapsesh = new FlxSprite(0, 0);
	yapsesh.frames = Paths.getSparrowAtlas(ext + 'dialogue');
	yapsesh.animation.addByPrefix('bop', 'dialogue', 24, false);
	yapsesh.camera = camOther;
	yapsesh.zIndex = 12;
	yapsesh.screenCenter();
	yapsesh.setGraphicSize(Std.int(yapsesh.width * 0.6));
	yapsesh.alpha = 0.0001;
	add(yapsesh);
	
	speedlines = new FlxBackdrop().loadGraphic(Paths.image(ext + 'speedlines'));
	speedlines.scale.set(3, 3);
	speedlines.updateHitbox();
	speedlines.scrollFactor.set(.3, .3);
	speedlines.alpha = 0.00001;
	add(speedlines);
	
	pauseOverwrite = 'monotone';
}

function onSongStart()
{
	if (hasBfSkin) game.unlockAchievementPopup('double_trouble');
}

function onEvent(n, v1, v2)
{
	switch (n)
	{
		case 'Legacy': // handle all of this shit boy im lowkey editing the events in the chart editor AND visual studio
			if (v1 == 'red' || v1 == 'green' || v1 == 'monotone' || v1 == 'black')
			{
				if (v1 == 'green')
				{
					if (!hasBfSkin) triggerEventNote('Change Character', 'BF', 'bf-fall');
				}
				else if (!hasBfSkin) triggerEventNote('Change Character', 'BF', 'bf');
				defeatthing.alpha = 0;
				if (hasBfSkin && game.boyfriend.curCharacter != 'bf-ghost') platform.alpha = 0;
				bggreen.alpha = 0;
				lightoverlay2.alpha = 1;
				speedlines.alpha = 0;
				greentower.alpha = 0;
				redRoom.alpha = 0;
				greenRoom.alpha = 0;
				blueRoom.alpha = 0;
				// we can set alphas to 0
				// but i dont WANT TO! slams food off my desk
			}
			switch (v1)
			{
				case 'crisis_line': // blah blah!
					yapsesh.alpha = 1;
					yapsesh.animation.play('bop');
				case 'red': // RED'S TURN BOY
					redRoom.alpha = 1;
					if (ClientPrefs.shaders)
					{
						hsv1.hue = -118 / 255;
					}
					else
					{
						lightoverlay.setColorTransform(.2, .2, .2, 1, 0, 128, 20);
						lightoverlay2.setColorTransform(0, 0, 0, 1, 255, 0, 20);
					}
					triggerEventNote('Change Character', 'dad', 'red');
					spinPet = false; // im sorry im sorry im sorry
				case 'monotone': // MONTONE'S TURN BOY
					triggerEventNote('Change Character', 'dad', 'monotone');
					blueRoom.alpha = 1;
					if (ClientPrefs.shaders)
					{
						hsv1.hue = 0;
					}
					else
					{
						lightoverlay.setColorTransform();
						lightoverlay2.setColorTransform();
					}
					dad.originalFlipX = dad.originalFlipX;
					spinPet = false;
				case 'green':
					triggerEventNote('Change Character', 'dad', 'greenEjected');
					bggreen.alpha = 1;
					lightoverlay2.alpha = 0;
					greentower.alpha = 1;
					speedlines.alpha = 0.5;
					if (hasBfSkin && game.boyfriend.curCharacter != 'bf-ghost') platform.alpha = 1;
					spinPet = true;
					greentower.y = 0;
					FlxTween.tween(greentower, {y: -300}, 20);
				case 'black':
					triggerEventNote('Change Character', 'dad', 'blackdk');
					defeatthing.alpha = 1;
					lightoverlay2.alpha = 0;
					spinPet = false;
				case 'ending':
					FlxTween.tween(lightoverlay2, {alpha: 0}, 10);
					FlxTween.tween(blackImage, {alpha: 1}, 12);
					FlxTween.tween(dad, {alpha: 0}, 10);
				case 'off':
					triggerEventNote('flash', '2', '');
				case 'on':
					triggerEventNote('flash', '3', '');
			}
		case 'flash':
			if (v1 == '2')
			{
				black.visible = true;
				black.alpha = 1;
			}
			if (v1 == '3')
			{
				black.visible = false;
				yapsesh.visible = false;
			}
	}
}

function onUpdate(elapsed:Float):Void
{
	if (!allmonotones.contains(game.dad.curCharacter))
	{
		pet2.alpha = 1;
	}
	else
	{
		pet2.alpha = 0;
	}
	var musicTime:Float = Conductor.songPosition;
	funTime = musicTime;
	if (speedlines != null) speedlines.y = -(funTime * 2 * (ClientPrefs.flashing ? 1.75 : .75));
	if (spinPet)
	{
		pet.angle += 900 * elapsed;
		pet.x = 1900;
		pet.y = 800;
		pet.scrollFactor.set(1.2, 1.2);
		pet.setColorTransform(1, 1, 1, 1, 0, 0, 0, -128);
	}
	else
	{
		pet.angle = 0;
		pet.x = 1760;
		pet.y = 1050;
		pet.scrollFactor.set(1, 1);
		pet.setColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
	}
	if (ClientPrefs.inDevMode)
	{
		if (FlxG.keys.justPressed.Z)
		{
			triggerEventNote('Legacy', 'red');
		}
		if (FlxG.keys.justPressed.X)
		{
			triggerEventNote('Legacy', 'black');
		}
		if (FlxG.keys.justPressed.C)
		{
			triggerEventNote('Legacy', 'green');
		}
		if (FlxG.keys.justPressed.V)
		{
			triggerEventNote('Legacy', 'monotone');
		}
	}
}

function onBeatHit()
{
	if (curBeat % 4 == 0)
	{
		defeatthing.animation.play('bop', true);
	}
	
	if (curBeat % 2 == 0)
	{
		pet2.animation.play('idle');
	}
	
	switch (curBeat)
	{
		case 6:
			FlxTween.tween(black, {alpha: 0}, 15);
			introTween = FlxTween.tween(camGame, {zoom: 0.4}, 20);
		case 32:
			// i dont care
			
		case 64:
			camSpecialThing([950, 750], [950, 750], 0.4);
		case 81:
			camSpecialThing([850, 750], [1050, 750], 0.45);
		case 88:
			camSpecialThing([700, 800], [700, 800], 0.8);
		case 95:
			camSpecialThing([850, 750], [1050, 750], 0.5);
		case 112:
			camSpecialThing([950, 750], [950, 750], 0.5);
		case 128:
			camSpecialThing([850, 750], [1050, 750], 0.6);
		case 192:
			camSpecialThing([950, 750], [950, 750], 0.5);
		case 208:
			camSpecialThing([850, 750], [1050, 750], 0.6);
		case 224:
			camSpecialThing([950, 700], [950, 700], 0.5);
		case 254:
			camSpecialThing([1300, 800], [1300, 800], 0.6);
		case 262:
			camSpecialThing([1400, 800], [1400, 800], 0.7);
		case 270:
			camSpecialThing([1450, 800], [1450, 800], 0.8);
		case 278:
			camSpecialThing([1500, 800], [1500, 800], 0.9);
		case 294:
			camSpecialThing([850, 700], [850, 700], 0.4);
		case 312:
			camSpecialThing([850, 750], [1050, 750], 0.45);
		case 328:
			camSpecialThing([650, 750], [650, 750], 0.55);
		case 334:
			camSpecialThing([650, 750], [650, 750], 0.45);
		case 344:
			camSpecialThing([1400, 800], [1300, 800], 0.7);
		case 360:
			camSpecialThing([950, 700], [950, 700], 0.5);
		case 456:
			camSpecialThing([850, 750], [1050, 750], 0.6);
	}
}
