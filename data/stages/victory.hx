import flixel.FlxSprite;
import flixel.text.FlxText;

var ext = 'stages/jorsawsee/victory/';

var props:Array<Dynamic> = [
	['smoke1', -600, 637.6, 1.3, 4],
	['smoke2', -492, 429.75, 0.9, 2], // 430
	['headlight', -195.85, -298, 1.1, 4],
	['headlight', 892.45, -298, 1.1, 4],
	['smoke3', 100, 410, 0.5, -1.5]
];

// 198.25
var chars:Array<Dynamic> = [
	['jorsawsee', 320, [200, 450, 643]],
	['warchief', 305, [320, 500, 660]],
	['jelqer', 344, [330, 520, 680]]
];

var victory:FlxText;
var crewmates:Array<FlxSprite> = [];
var boppers:Array<FlxSprite> = [];
var leftBitches:FlxSprite;
var rightBitches:FlxSprite;
var overlay:FlxSprite;
var void:FlxSprite;

function onCountdownTick()
{
	for (i in crewmates)
		i.animation.play('bop', true);
}

function onBeatHit()
{
	crewmates[0].animation.play('bop', true);
	crewmates[2].animation.play('bop', true);
	switch (curBeat % 2)
	{
		case 0:
			crewmates[1].animation.play('bop', true);
			overlay.animation.play('bop');
			for (i in boppers)
				i.animation.play('bop');
			leftBitches.animation.play('bop');
		case 1:
			// HMM
			rightBitches.animation.play('bop');
	}
}

function onStartCountdown()
{
	var fakeStartTimer = new FlxTimer().start((Conductor.crotchet / 1000) / playbackRate, function(tmr:FlxTimer) {
		if (tmr.loopsLeft % 2 == 0)
		{
			crewmates[1].animation.play('bop', true);
			for (i in boppers)
				i.animation.play('bop');
			leftBitches.animation.play('bop');
		}
		if (tmr.loopsLeft % 2 == 1) rightBitches.animation.play('bop');
	}, 5);
}

function onLoad()
{
	void = new FlxSprite(-402.95, 0).loadGraphic(Paths.image(ext + 'void'));
	void.zIndex = -2;
	void.blend = BlendMode.ADD;
	void.alpha = 0;
	add(void);
	
	for (i in 0...props.length)
	{
		var prop:FlxSprite = new FlxSprite(props[i][1], props[i][2]);
		prop.frames = Paths.getSparrowAtlas(ext + 'props');
		prop.animation.addByPrefix('bop', props[i][0] + ' instance 1', 0, false);
		prop.animation.play('bop');
		prop.scrollFactor.set(props[i][3], props[i][3]);
		prop.blend = BlendMode.ADD;
		if (props[i][4] != null) prop.zIndex = props[i][4];
		add(prop);
	}
	
	leftBitches = new FlxSprite(-500, 230);
	leftBitches.frames = Paths.getSparrowAtlas(ext + 'ghosts');
	leftBitches.animation.addByPrefix('bop', 'idleleft', 24, false);
	leftBitches.animation.play('bop');
	leftBitches.scrollFactor.x = 0.77;
	leftBitches.alpha = 0.5;
	add(leftBitches);
	
	rightBitches = new FlxSprite(1059, 236);
	rightBitches.frames = Paths.getSparrowAtlas(ext + 'ghosts');
	rightBitches.animation.addByPrefix('bop', 'idleright', 24, false);
	rightBitches.animation.play('bop');
	rightBitches.scrollFactor.x = 0.77;
	rightBitches.alpha = 0.5;
	leftBitches.zIndex = -2;
	rightBitches.zIndex = -2;
	add(rightBitches);
	
	for (i in 0...chars.length)
	{
		var prop:FlxSprite = new FlxSprite(chars[i][2][0], chars[i][1]);
		prop.frames = Paths.getSparrowAtlas(ext + 'middle_chars');
		prop.animation.addByPrefix('bop', 'idle' + chars[i][0], 24, false);
		prop.animation.play('bop');
		prop.scrollFactor.x = 0.8;
		// prop.blend = BlendMode.ADD;
		// if (props[i][3] != null) prop.zIndex = props[i][3];
		prop.zIndex = -1;
		crewmates.push(prop);
	}
	add(crewmates[1]);
	add(crewmates[2]);
	add(crewmates[0]);
	
	victory = new FlxText(280, 67, -1, 'VICTORY'); //-88
	victory.setFormat(Paths.font('vcr'), 70, 0xFF4DFFFF);
	victory.scale.set(2.774, 2.774);
	victory.updateHitbox();
	victory.scrollFactor.x = 0.5;
	add(victory);
}

function onSongStart()
{
	camGame.alpha = 1;
}

function onUpdate()
{
	game.health = 999;
	victoryBS();
}

function victoryBS()
{
	if (playHUD == null || playHUD.scoreTxt == null) return;
	
	var currentText:String = playHUD.scoreTxt.text;
	if (currentText == null || currentText.length == 0) return;
	currentText = currentText.split('\n').join('');
	
	var missesLabel:String = Lang.str('misses', 'Misses');
	var victoryLabel:String = Lang.str('victory0', 'Who cares? You already won!');
	var parts:Array<String> = currentText.split(' | ');
	if (parts.length < 2) return;
	
	if (Lang.hasSpecial('rightToLeft'))
	{
		var rtlNeedle:String = ' :' + missesLabel;
		var rtlPos:Int = parts[1].indexOf(rtlNeedle);
		if (rtlPos >= 0)
		{
			parts[1] = victoryLabel + parts[1].substring(rtlPos);
		}
	}
	else
	{
		var ltrNeedle:String = missesLabel + ': ';
		var ltrPos:Int = parts[1].indexOf(ltrNeedle);
		if (ltrPos >= 0)
		{
			parts[1] = parts[1].substring(0, ltrPos + ltrNeedle.length) + victoryLabel;
		}
	}
	
	playHUD.scoreTxt.text = parts.join(' | ') + '\n';
	
	Lang.arabicTextFix(playHUD.scoreTxt);
}

function moveCrew(crew, pos)
{
	crewmates[crew].visible = (pos > -1);
	crewmates[crew].x = chars[crew][2][pos];
}

function onEvent(n, v1, v2)
{
	switch (n)
	{
		case 'Legacy':
			switch (v1)
			{
				case 'jelq_sesh1':
					moveCrew(1, 1);
					moveCrew(2, -1);
				case 'jorsawsee1':
					moveCrew(1, 0);
					moveCrew(2, 2);
				case 'warchief2':
					moveCrew(0, 2);
					moveCrew(1, -1);
					moveCrew(2, 0);
				case 'jelq_sesh2':
					moveCrew(0, 2);
					moveCrew(1, 0);
					moveCrew(2, -1);
				case 'jorsawsee2':
					moveCrew(0, -1);
					moveCrew(1, 0);
					moveCrew(2, 2);
				// transform!
				case 'hide':
					camSpecialThing([600, 450], [850, 450]);
					victory.alpha = 0;
					defaultCamZoom = 0.7;
					leftBitches.alpha = 0;
					rightBitches.alpha = 0;
					for (crew in crewmates)
						crew.alpha = 0;
						
				case 'reveal':
					victory.alpha = 1;
					camSpecialThing([600, 400], [850, 400]);
					defaultCamZoom = 0.6;
					leftBitches.alpha = 1;
					rightBitches.alpha = 1;
					for (crew in crewmates)
						crew.alpha = 1;
					void.alpha = 0.5;
			}
		case 'Victory Darkness':
			if (v1 == 'on') FlxG.sound.play(Paths.sound('stage/playerdisconnect'));
			playHUD.scoreTxt.visible = v1 != 'on';
			camGame.visible = v1 == 'on' ? false : true;
	}
}

function onCreatePost()
{
	game.instakillOnMiss = false;
	game.healthLoss = 0;
	game.health = 2;
	game.camHUD.alpha = 0;
	camGame.alpha = 0;
	
	moveCrew(0, -1);
	moveCrew(1, -1);
	moveCrew(2, 1);
	snapCamToPos(600, 400);
	camSpecialThing([600, 400], [850, 400]);
	for (i in [playHUD.healthBar, playHUD.iconP1, playHUD.iconP2])
	{
		i.visible = false;
	}
	if (ClientPrefs.downScroll) playHUD.scoreTxt.y = FlxG.height * 0.06;
	
	overlay = new FlxSprite(-1200, 170);
	overlay.frames = Paths.getSparrowAtlas(ext + 'overlay');
	overlay.animation.addByPrefix('bop', 'idleLIGHT instance 1', 24, false);
	overlay.animation.play('bop');
	overlay.scale.set(2, 2);
	overlay.updateHitbox();
	overlay.zIndex = 5;
	// prop.scrollFactor.set(props[i][3], props[i][3]);
	overlay.blend = BlendMode.ADD;
	add(overlay);
	
	if (hasBfSkin && game.boyfriend.curCharacter == 'yellowplayable')
	{
		triggerEventNote('Change Character', 'boyfriend', 'yellow-ghost');
	}
	
	refreshZ();
	
	// just incase
	
	if (boyfriend.gameoverLoopDeathSound == null) boyfriend.gameoverLoopDeathSound = 'Jorsawsee_Loop';
	if (boyfriend.gameoverConfirmDeathSound == null) boyfriend.gameoverConfirmDeathSound = 'Jorsawsee_End';
}

function onEndSong()
{
	if (game.totalNotesHit <= 0) game.unlockAchievementPopup('you_suck');
	return Function_Continue;
}
