var farCloudBg:FlxSprite;
var airFarClouds:FlxBackdrop;
var airMidClouds:FlxBackdrop;
var airCloseClouds:FlxBackdrop;
var airshipPlatform:FlxBackdrop;
var airSpeedlines:FlxBackdrop;
var airBigCloud:FlxSprite;
var platform2:FlxSprite;
var platform3:FlxSprite;
var platform4:FlxSprite;
var platform5:FlxSprite;
var airshipskyflash:FlxSprite;

// character legs
public var dadLegs:Character;
var blackScream:Bool = false;
var legPosY = [13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13];

// other vars
var bgspeed:Float = 9; // background scroll speed
var bigCloudSpeed:Float = 10;
var dadAnchorPoint:Array<Float> = [0, 0];

function onLoad()
{
	game.camGame.height = FlxG.height + 200;
	game.camGame.y -= 100;
	
	dadLegs = new Character(0, 0, 'black-legs', false);
	game.dadGroup.add(dadLegs);
	
	var sky:FlxSprite = new FlxSprite(-1500, -897.55).loadGraphic(Paths.image('stages/airship/danger/sky'));
	sky.setGraphicSize(5000, sky.height * 1.5 * 4);
	sky.updateHitbox();
	sky.scrollFactor.set(0, 0);
	add(sky);
	
	farCloudBg = new FlxSprite(-1500).makeGraphic(50, 50, 0xffc0dbff);
	farCloudBg.setGraphicSize(3000, 1200);
	farCloudBg.scrollFactor.set(.1, .1);
	farCloudBg.antialiasing = false;
	farCloudBg.updateHitbox();
	add(farCloudBg);
	
	airFarClouds = new FlxBackdrop(Paths.image('stages/airship/danger/farthestClouds'), FlxAxes.X, -2);
	airFarClouds.setPosition(3385.95, -142.2);
	airFarClouds.scrollFactor.set(0.1, 0.1);
	airFarClouds.scale.set(2, 2);
	airFarClouds.updateHitbox();
	add(airFarClouds);
	
	farCloudBg.y = (airFarClouds.y + airFarClouds.height - 1);
	
	airMidClouds = new FlxBackdrop(Paths.image('stages/airship/danger/backClouds'), FlxAxes.X, -2, 299, 0);
	airMidClouds.setPosition(3352.4, 76.55);
	airMidClouds.scrollFactor.set(0.2, 0.2);
	airMidClouds.scale.set(2, 2);
	airMidClouds.updateHitbox();
	add(airMidClouds);
	
	var airship:FlxSprite = new FlxSprite(1114.75, -873.05).loadGraphic(Paths.image('stages/airship/danger/airship'));
	airship.scrollFactor.set(0.25, 0.25);
	airship.scale.set(2, 2);
	airship.updateHitbox();
	add(airship);
	
	var fan:FlxSprite = new FlxSprite(2285.4, 102);
	fan.frames = Paths.getSparrowAtlas('stages/airship/danger/airshipFan');
	fan.animation.addByPrefix('idle', 'ala avion instance 1', 24, true);
	fan.animation.play('idle');
	fan.scrollFactor.set(0.27, 0.27);
	add(fan);
	
	airBigCloud = new FlxSprite(3507.15, -744.2).loadGraphic(Paths.image('stages/airship/danger/bigCloud'));
	airBigCloud.scrollFactor.set(0.4, 0.4);
	airBigCloud.scale.set(2, 2);
	airBigCloud.updateHitbox();
	add(airBigCloud);
	
	airCloseClouds = new FlxBackdrop(Paths.image('stages/airship/danger/frontClouds'), FlxAxes.X, -3, 808, 0);
	airCloseClouds.setPosition(6092.2, 422.15);
	airCloseClouds.scrollFactor.set(0.3, 0.3);
	airCloseClouds.scale.set(2, 2);
	airCloseClouds.updateHitbox();
	add(airCloseClouds);
	
	airshipskyflash = new FlxSprite(0, -200);
	airshipskyflash.frames = Paths.getSparrowAtlas('stages/airship/danger/screamsky');
	airshipskyflash.animation.addByPrefix('bop', 'scream sky', 24, false);
	airshipskyflash.setGraphicSize(Std.int(airshipskyflash.width * 4)); // REAL funny guys.
	airshipskyflash.updateHitbox();
	airshipskyflash.setGraphicSize(Std.int(airshipskyflash.width * 3));
	airshipskyflash.antialiasing = true;
	add(airshipskyflash);
	airshipskyflash.alpha = 0.0001;
	
	airshipPlatform = new FlxBackdrop(Paths.image('stages/airship/danger/fgPlatform'), FlxAxes.X);
	airshipPlatform.setPosition(-7184.8, 282.25);
	airshipPlatform.scale.set(2, 2);
	airshipPlatform.updateHitbox();
	add(airshipPlatform);
	
	// TODO: Rewrite this this is a little dire to look at
	
	platform2 = new FlxSprite(1600, 350);
	platform2.frames = Paths.getSparrowAtlas('stages/common/platform');
	platform2.animation.addByPrefix('bop', 'danger', 24, true);
	platform2.animation.play('bop');
	platform2.alpha = 0.00001;
	
	add(platform2);
	
	platform3 = new FlxSprite(850, 550);
	platform3.frames = Paths.getSparrowAtlas('stages/airship/danger/dangerboards');
	platform3.animation.addByPrefix('bop', 'speakerwheel', 24, true);
	platform3.animation.play('bop');
	platform3.alpha = 0.00001;
	
	add(platform3);

	
	platform4 = new FlxSprite(990, 520);
	platform4.frames = Paths.getSparrowAtlas('stages/airship/danger/dangerboards');
	platform4.animation.addByPrefix('bop', 'skateboard', 24, true);
	platform4.animation.play('bop');
	platform4.alpha = 0.00001;
	
	add(platform4);
	
	platform5 = new FlxSprite(1900, 500);
	platform5.frames = Paths.getSparrowAtlas('stages/airship/danger/dangerboards');
	platform5.animation.addByPrefix('bop', 'cart', 24, true);
	platform5.animation.play('bop');
	platform5.alpha = 0.00001;
	
	add(platform5);
	//pet.zIndex = 1;
	platform5.zIndex = 2;
}

function onCreatePost()
{
	/*if (hasGfSkin && game.gf.curCharacter != 'gf-ghost' && game.gf.curCharacter != 'upgirl')
	{
		platform3.alpha = 1;
	}
	if (game.gf.curCharacter == 'upgirl')
	{
		platform4.alpha = 1;
		game.gf.y += 30;
	}*/

	/*if (hasBfSkin && game.boyfriend.curCharacter != 'bf-ghost')
	{
		platform2.alpha = 1;
		game.boyfriend.x += 60;
		game.boyfriend.y -= 240;
	}*/
	
	//if (hasPet) platform5.alpha = 1;
	
	dadAnchorPoint[0] = game.dad.x;
	dadAnchorPoint[1] = game.dad.y;
	
	dadLegs.x = dad.x + 5;
	dadLegs.y = dad.y + 15;
	
	airSpeedlines = new FlxBackdrop(Paths.image('stages/airship/danger/speedlines'), FlxAxes.X, 1, 787.95, 0);
	airSpeedlines.setPosition(-3352.1, -1035.95);
	airSpeedlines.alpha = 0.2;
	airSpeedlines.scrollFactor.set(1.3, 1.3);
	add(airSpeedlines);
}

function onCountdownTick()
{
	dadLegs.dance();
}

function onUpdate(elapsed) // to anyone else reading this script I'm sorry its just huge
{
	if (ClientPrefs.inDevMode)
	{
		if (FlxG.keys.pressed.Q) bgspeed -= elapsed * 15;
		if (FlxG.keys.pressed.E) bgspeed += elapsed * 15;
	}
	
	final delta:Float = (elapsed * bgspeed);
	
	if (!isDead)
	{
		if (!blackScream) game.camGame.shake(0.0008, 0.01);
		game.camGame.y = Math.sin((Conductor.songPosition / 280) * (Conductor.bpm / 60) * 1.0) * 2 - 100;
		game.camHUD.y = Math.sin((Conductor.songPosition / 300) * (Conductor.bpm / 60) * 1.0) * 0.6;
		game.camHUD.angle = Math.sin((Conductor.songPosition / 350) * (Conductor.bpm / 60) * -1.0) * 0.6;
	}
	
	game.dad.y = dadAnchorPoint[1] + legPosY[dadLegs.animation.curAnim.curFrame] - 20;
	
	airFarClouds.x -= (delta * 7);
	airMidClouds.x -= (delta * 13);
	airCloseClouds.x -= (delta * 50);
	airshipPlatform.x -= (delta * 300);
	airSpeedlines.x -= (delta * 350);
	
	if (airBigCloud != null)
	{
		airBigCloud.x -= (delta * bigCloudSpeed);
		if (airBigCloud.x < -4163.7)
		{
			airBigCloud.x = FlxG.random.float(3931.5, 4824.05);
			airBigCloud.y = FlxG.random.float(-1087.5, -307.35);
			bigCloudSpeed = FlxG.random.float(7, 15);
		}
	}
}

function getDisplacement(left_x:Float = -4000, get_x:Float = 0, returnX:Float = 4000)
{
	// to prevent weird clipping
	var dp:Float = left_x - get_x;
	return (returnX - dp);
}

function onBeatHit()
{
	if (curBeat % 1 == 0)
	{
		dadLegs.dance();
	}
}

function onEvent(ev, v1, v2)
{
	if (ev == 'Legacy')
	{
		switch (v1)
		{
			case 'scream danger':
				blackScream = true;
				airshipskyflash.alpha = 1;
				airshipskyflash.animation.play('bop', false);
			case 'unscream danger':
				blackScream = false;
				FlxTween.tween(airshipskyflash, {alpha: 0}, 0.6, {ease: FlxEase.quartOut});
			case 'bye gf':
				FlxTween.tween(gf, {x: -2000}, 4, {ease: FlxEase.quartIn});
				FlxTween.tween(platform3, {x: -2000}, 4, {ease: FlxEase.quartIn});
				FlxTween.tween(platform4, {x: -2000}, 4, {ease: FlxEase.quartIn});
				//FlxTween.tween(pet, {x: -1700}, 8, {ease: FlxEase.quartIn});
				FlxTween.tween(platform5, {x: -2000}, 8, {ease: FlxEase.quartIn});
				FlxTween.num(9, 14, 5, {ease: FlxEase.quadIn}, function(v:Float) {
					bgspeed = v;
				});
		}
	}
}
