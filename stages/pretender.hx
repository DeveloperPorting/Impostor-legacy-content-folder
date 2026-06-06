var ext = 'stages/mira/greenhouse/pretender/';
var gfDeadPretender:FlxSprite;
var cloud1:FlxSprite;
var cloud2:FlxSprite;
var cloud3:FlxSprite;
var cloud4:FlxSprite;
var cloudbig:FlxSprite;
var blueMira:FlxSprite;

function onLoad()
{
	var sky:FlxSprite = new FlxSprite(-1500, -800).loadGraphic(Paths.image(ext + 'bg sky'));
	sky.antialiasing = ClientPrefs.globalAntialiasing;
	add(sky);
	
	var cloudfar:FlxSprite = new FlxSprite(-1300, -100).loadGraphic(Paths.image(ext + 'cloud fathest'));
	cloudfar.antialiasing = ClientPrefs.globalAntialiasing;
	add(cloudfar);
	
	var cloudfront:FlxSprite = new FlxSprite(-1300, 0).loadGraphic(Paths.image(ext + 'cloud front'));
	cloudfront.antialiasing = ClientPrefs.globalAntialiasing;
	add(cloudfront);
	
	cloud1 = new FlxBackdrop(Paths.image(ext + 'cloud 1'));
	cloud1.setPosition(0, -1000);
	cloud1.updateHitbox();
	cloud1.antialiasing = ClientPrefs.globalAntialiasing;
	add(cloud1);
	
	cloud2 = new FlxBackdrop(Paths.image(ext + 'cloud 2'));
	cloud2.setPosition(0, -1200);
	cloud2.updateHitbox();
	cloud2.antialiasing = ClientPrefs.globalAntialiasing;
	add(cloud2);
	
	cloud3 = new FlxBackdrop(Paths.image(ext + 'cloud 3'));
	cloud3.setPosition(0, -1400);
	cloud3.updateHitbox();
	cloud3.antialiasing = ClientPrefs.globalAntialiasing;
	add(cloud3);
	
	cloud4 = new FlxBackdrop(Paths.image(ext + 'cloud 4'));
	cloud4.setPosition(0, -1600);
	cloud4.updateHitbox();
	cloud4.antialiasing = ClientPrefs.globalAntialiasing;
	add(cloud4);
	
	cloudbig = new FlxBackdrop(Paths.image(ext + 'bigcloud'));
	cloudbig.setPosition(0, -1200);
	cloudbig.updateHitbox();
	cloudbig.antialiasing = ClientPrefs.globalAntialiasing;
	add(cloudbig);
	
	var ground:FlxSprite = new FlxSprite(-1200, -750).loadGraphic(Paths.image(ext + 'ground'));
	ground.antialiasing = ClientPrefs.globalAntialiasing;
	add(ground);
	
	var plantfront:FlxSprite = new FlxSprite(-2, -680).loadGraphic(Paths.image(ext + 'front plant'));
	plantfront.antialiasing = ClientPrefs.globalAntialiasing;
	add(plantfront);
	
	var plant1:FlxSprite = new FlxSprite(1000, 190).loadGraphic(Paths.image(ext + 'knocked over plant'));
	plant1.antialiasing = ClientPrefs.globalAntialiasing;
	add(plant1);
	
	var plant2:FlxSprite = new FlxSprite(-800, 260).loadGraphic(Paths.image(ext + 'knocked over plant 2'));
	plant2.antialiasing = ClientPrefs.globalAntialiasing;
	add(plant2);
	
	var deadmungus:FlxSprite = new FlxSprite(950, 250).loadGraphic(Paths.image(ext + 'tomatodead'));
	deadmungus.antialiasing = ClientPrefs.globalAntialiasing;
	add(deadmungus);
	
	gfDeadPretender = new FlxSprite(-1, 188);
	gfDeadPretender.frames = Paths.getSparrowAtlas(ext + 'gf_dead_p');
	gfDeadPretender.animation.addByPrefix('bop', 'GF Dancing Beat', 24, false);
	gfDeadPretender.animation.play('bop');
	// gfDeadPretender.setGraphicSize(Std.int(gfDeadPretender.width * 1.1)); WHY???????????????
	gfDeadPretender.antialiasing = ClientPrefs.globalAntialiasing;
	add(gfDeadPretender);
	
	var ripbozo:FlxSprite = new FlxSprite(900, 500).loadGraphic(Paths.image(ext + 'ripbozo'));
	ripbozo.scale.set(0.6, 0.6); // accurate to his size
	ripbozo.updateHitbox();
	ripbozo.antialiasing = ClientPrefs.globalAntialiasing;
	add(ripbozo);
	
	var rhmdead:FlxSprite = new FlxSprite(1150, 630).loadGraphic(Paths.image(ext + 'rhm dead'));
	rhmdead.scrollFactor.set(1.1, 1);
	rhmdead.antialiasing = ClientPrefs.globalAntialiasing;
	add(rhmdead);
	
	bluemira = new FlxSprite(-1150, 400);
	bluemira.frames = Paths.getSparrowAtlas(ext + 'blued');
	bluemira.animation.addByPrefix('bop', 'bob bop', 24, false);
	bluemira.animation.play('bop');
	bluemira.scrollFactor.set(1.2, 1);
	bluemira.antialiasing = ClientPrefs.globalAntialiasing;
}

function onUpdate(elapsed)
{
	cloud1.x = FlxMath.lerp(cloud1.x, cloud1.x - 1, FlxMath.bound(elapsed * 9, 0, 1));
	cloud2.x = FlxMath.lerp(cloud2.x, cloud2.x - 3, FlxMath.bound(elapsed * 9, 0, 1));
	cloud3.x = FlxMath.lerp(cloud3.x, cloud3.x - 2, FlxMath.bound(elapsed * 9, 0, 1));
	cloud4.x = FlxMath.lerp(cloud4.x, cloud4.x - 0.1, FlxMath.bound(elapsed * 9, 0, 1));
	cloudbig.x = FlxMath.lerp(cloudbig.x, cloudbig.x - 0.5, FlxMath.bound(elapsed * 9, 0, 1));
}

function onBeatHit()
{
	if (curBeat % 4 == 0) bluemira.animation.play('bop');
	if (curBeat % 1 == 0) gfDeadPretender.animation.play('bop');
}

function onStartCountdown()
{
	var fakeStartTimer = new FlxTimer().start((Conductor.crotchet / 1000) / playbackRate, function(tmr:FlxTimer) {
		if (tmr.loopsLeft % 2 == 0) bluemira.animation.play('bop');
		if (tmr.loopsLeft % 1 == 0) gfDeadPretender.animation.play('bop');
	}, 5);
}

function onCreatePost()
{
	var pot = new FlxSprite(-1550, 650).loadGraphic(Paths.image(ext + 'front pot'));
	pot.scrollFactor.set(1.2, 1);
	pot.antialiasing = ClientPrefs.globalAntialiasing;
	
	var vines = new FlxSprite(-1450, -550).loadGraphic(Paths.image(ext + 'green'));
	vines.scrollFactor.set(1.2, 1);
	vines.antialiasing = ClientPrefs.globalAntialiasing;
	
	var pretenderLighting:FlxSprite = new FlxSprite(-1670, -700).loadGraphic(Paths.image(ext + 'lightingpretender'));
	pretenderLighting.antialiasing = ClientPrefs.globalAntialiasing;
	
	add(bluemira);
	add(pot);
	add(vines);
	add(pretenderLighting);
	
	// I think we should just make it so the song in the json doesn't allow skins
	// but if it detects the skin in clientprefs is pink playable then it changes to her
	
	if (hasBfSkin && game.boyfriend.curCharacter != 'pinkplayable')
	{
		triggerEventNote('Change Character', 'boyfriend', 'pretender');
	}
	else if (hasBfSkin && game.boyfriend.curCharacter == 'pinkplayable')
	{
		triggerEventNote('Change Character', 'dad', 'minigreyop');
		game.dad.x = -300;
		game.dad.y = 350;
	}
	snapCamToPos(450, 300);
	camSpecialThing([160, 200], [380, 200], 0.5);
}

function onSongStart()
{
	if (hasBfSkin && game.boyfriend.curCharacter == 'pinkplayable')
	{
		game.unlockAchievementPopup('lets_be_friends');
	}
}
