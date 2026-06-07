import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxStringUtil;

import funkin.backend.DebugDisplay;
import funkin.backend.math.Vector3;
import funkin.utils.MathUtil;
//import funkin.data.GameFlags;
import funkin.data.ClientPrefs;
//import funkin.data.CosmicubeData;
//import funkin.utils.ProgressionUtil;

using StringTools;

public var comboX:Float = 0; // Offset midscroll bullshit. fuck.
var combosPadding:Float = 0;
var flashSprite:FlxSprite;
var lyric_box:FlxSprite;
var lyric_text:FlxText;
var reactorFade:Float = 3;
public var dbText:String = '';
public var bfOff:Dynamic = -1;
public var dadOff:Dynamic = -1;
public var showDevInfo:Bool = false;

var rankThresholds:Array<{min: Float, name: String}> = [
	{min: 99.0, name: "P"},
	{min: 95.0, name: "S"},
	{min: 90.0, name: "A"},
	{min: 80.0, name: "B"},
	{min: 70.0, name: "C"},
	{min: 60.0, name: "D"},
	{min: 50.0, name: "E"}
];

// Akinator game below vvvvvvvvvvv

/**
 * Can the camera follow who is singing?
**/
public var canFollow:Bool = true;

/**
 * Does your character have a GF skin?
**/
public var hasGfSkin = false;

/**
 * Does your character have a BF skin?
**/
public var hasBfSkin = false;

/**
 * Does your character have a pet?
**/
public var hasPet = false;

/**
 * Does your character have Colored UI on?
**/
public var hasColor = false;

// CAMERA SHIT
var camBopInterval:Int = 4;
var camBopIntensity:Float = 1;
var twistShit:Float = 1;
var twistAmount:Float = 1;
var camTwistIntensity:Float = 0;
var camTwistIntensity2:Float = 3;
var camTwist:Bool = false;

function onLoad()
{
	/*hasBfSkin = (ClientPrefs.bfSkin != 'default' && !isStoryMode);
	hasGfSkin = (ClientPrefs.gfSkin != 'default' && !isStoryMode);
	hasPet = (ClientPrefs.pet != '' && !isStoryMode);*/
	hasColor = (ClientPrefs.colorText != 'Disabled');
}

function onCreatePost()
{
	modifyGUI();

	if (!ClientPrefs.inDevMode) return;
	var WATERMARK:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/pause/looksie_extreme_demon'));
	WATERMARK.camera = camOther;
	WATERMARK.alpha = 0.3;
	WATERMARK.setPosition((FlxG.width - WATERMARK.width), (FlxG.height - WATERMARK.height));
	add(WATERMARK);

	DebugDisplay.addPlugin(() -> ('[ TAB to expand or collapse dev info ]' + (showDevInfo ? dbText : '')));
}

/**
	* Used for the weird camera thing all stage.luas in V4 do.
	** look at this
	* ```haxe
	camSpecialThing([500, 700], [1000, 700], 0.9, 0);
	* ```
**/
public function camSpecialThing(?dad = null, ?bf = null, ?zoom:Float = -1, ?snaptoo:Int = -1)
{
	if (zoom > 0) defaultCamZoom = zoom;
	if (bf != null && bf != -1) bfOff = bf;
	if (dad != null && dad != -1) dadOff = dad;
	if (snaptoo != -1 && snaptoo != null)
	{
		var huh = (snaptoo == 0 ? dad : bf);
		snapCamToPos(huh[0], huh[1]);
	}
}

/**
 * resets the camera positions. not really used considering this mod relies on `camSpecialThing` like oxygen
**/
public function resetCam()
{
	// Reset hardbaked positions for camera
	dadOff = -1;
	bfOff = -1;
}

function onMoveCamera(whosTurn:Bool)
{
	// CAMERA SPECIAL THING
	if (dadOff == -1 && bfOff == -1) return;
	
	if (game.camCurTarget == boyfriend) whosTurn = 'boyfriend'; // sure watever i dont care. hmph
	
	if (whosTurn == 'dad')
	{
		camFollow.setPosition(dadOff[0], dadOff[1]);
	}
	else
	{
		camFollow.setPosition(bfOff[0], bfOff[1]);
	}
	
	if (startingSong) return;
	if (ClientPrefs.camFollowsCharacters && canFollow)
	{
		var character = switch (whosTurn)
		{
			case 'gf': gf;
			case 'dad': (opponentStrums?.owner ?? dad);
			default: (playerStrums?.owner ?? boyfriend);
		}
		
		if (game.camCurTarget != null) character = game.camCurTarget; // used for characters that aren't player or opponent
		
		final displacement = character.getSingDisplacement();
		camFollow.x += displacement.x;
		camFollow.y += displacement.y;
	}
}

function modifyGUI()
{
	playHUD.timeBar.setColors(0xFF44d844, 0xFF2e412e);
	playHUD.timeTxt.x += 110;
	playHUD.timeBar.x -= 337;
	playHUD.timeTxt.y += 10;
	playHUD.timeTxt.size = 14;
	playHUD.timeTxt.borderSize = 1;
	playHUD.timeTxt.setFormat(Paths.font("vcr.ttf"), 14, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	playHUD.scoreTxt.clearFormats();
	if (hasColor) playHUD.scoreTxt.color = dad.healthColour;
	
	ratingPop = (.47 / .42);
	combosPop = (.35 / .33);
	
	switch (playHUD.ratingSuffix)
	{
		case '-nuzzus':
			ratingScale = 2;
			combosScale = 2;
		case '-pixel':
			ratingScale = 3;
			combosScale = 3;
		default:
			ratingScale = .42;
			combosScale = .33;
			combosPadding = -30;
	}
}

function getRank(accuracy:Float):String
{
	for (rule in rankThresholds)
	{
		if (accuracy >= rule.min) return rule.name;
	}
	
	return "F";
}

function onUpdateScore()
{
	var accuracyText:String = "N/A";
	var rankText:String = "N/A";

	if (songScore > 0 || songMisses > 0)
	{
		accuracyText = MathUtil.floorDecimal(ratingPercent * 100, 2) + "%";
		rankText = getRank(MathUtil.floorDecimal(ratingPercent * 100, 2));
	}
	
	playHUD.scoreTxt.text = "Score: " + songScore + " | Misses: " + songMisses + " | Accuracy: " + accuracyText + " | Rank: " + rankText;
	return Function_Stop;
}

function onPopUpScorePost(note, rating)
{
	if (playHUD.ratingGraphic != null)
	{
		// functionality still exists
		if (ClientPrefs.colorText == 'Enabled DX') playHUD.ratingGraphic.color = scoreTxt.color;
		
		playHUD.ratingGraphic.x = ((FlxG.width / 2) - (playHUD.ratingGraphic.width / 2) + comboX);
		playHUD.ratingGraphic.y = (ClientPrefs.downScroll ? (FlxG.height - playHUD.ratingGraphic.height - 50) : 55);
	}
	
	if (playHUD.ratingNumGroup != null && playHUD.ratingNumGroup.members != null)
	{
		var activeMembers = [for (member in playHUD.ratingNumGroup.members) if (member != null && member.exists && member.alive) member];
		
		var totalDigits = activeMembers.length;
		var daLoop = 0;
		var xOffset = 0;
		
		var totalWidth = 0;
		for (m in activeMembers)
			totalWidth += ((m.frameWidth + combosPadding) * combosScale);
		xOffset = ((FlxG.width - totalWidth) / 2);
		
		for (numScore in activeMembers)
		{
			if (ClientPrefs.colorText == 'Enabled DX') numScore.color = scoreTxt.color;
			
			numScore.x = (xOffset - (numScore.frameWidth + combosPadding) * combosScale / 2 /* i call this the Evil factor */ + comboX);
			numScore.y = (ClientPrefs.downScroll ? (FlxG.height - numScore.height - 117.5) : 122.5);
			xOffset += ((numScore.frameWidth + combosPadding) * combosScale);
			
			daLoop++;
		}
	}
	
	return Function_Continue; // Let original function run
}

function onUpdate(elapsed)
{
	flashSprite?.alpha = FlxMath.lerp(flashSprite?.alpha, 0, elapsed * reactorFade);
	
	if (!ClientPrefs.inDevMode) return;
	if (FlxG.keys.justPressed.TAB)
	{
		showDevInfo = !showDevInfo;
		dbGroup.visible = !dbGroup.visible;
	}
	
	if (showDevInfo)
	{
		dbText = '\nVS IMPOSTOR LEGACY v1.0.2'
			+ '\nHealth: '
			+ game.health
			+ '\nDad Camera, BF Camera:'
			+ [dadOff, bfOff]
			+ '\nCamera Position:'
			+ [camFollow.x, camFollow.y]
			+ ' (zoom: '
			+ defaultCamZoom
			+ ', add: '
			+ defaultCamZoomAdd
			+ ')'
			+ '\nSong Time: '
			+ Conductor.songPosition
			+ ' ('
			+ Math.round(Conductor.songPosition / 1000)
			+ 's)'
			+ '\n'
			+ getBool('Story Mode', PlayState.isStoryMode)
			+ '\nQueued Currency (score / 600): '
			+ Std.int(songScore / 600)
			+ '\nCharacters: '
			+ [dad.curCharacter, (gf == null ? null : gf.curCharacter), boyfriend.curCharacter]
			+ '\n'
			+ getBool('Low Quality', ClientPrefs.lowQuality)
			+ getBool(' | Photosensitive', ClientPrefs.photosensitive)
			+ getBool(' | Shaders', ClientPrefs.shaders)
			+ '\nAllocated Notes: ' + notes.length;
	}
}

function onUpdatePost(elapsed)
{
	playHUD.timeTxt.text = PlayState.SONG.song.toUpperCase();
}

public function getBool(sss:String, bbb:Bool, ?withSlashN:Bool = true):String
{
	return (withSlashN ? '\n' : '') + sss + ': ' + (bbb ? 'ON' : 'OFF');
}

function onFirstEventPush(eventName) // I had to add this callback to all scripts it was only being called by event scripts (which makes sense)
{
	switch (eventName)
	{
	    case 'Reactor Beep':
	        flashSprite = new FlxSprite(0, 0).makeGraphic(1280, 720, 0xFFb30000);
			flashSprite.alpha = 0.001;
			flashSprite.cameras = [camOther];
			add(flashSprite);
		case 'Optional Captions':
			lyric_box = new FlxSprite().makeGraphic(1, 1, 0xAA000000);
			lyric_text = new FlxText(0, 520, -1, '', 32);
			lyric_text.setFormat(Paths.font("liberbold.ttf"), 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			for (i in [lyric_box, lyric_text])
			{
				i.cameras = [camOther];
				i.visible = false;
				add(i);
			}
	}
}

/**
 * If val == '' then return null
**/
public function nullBlank(val)
{
	return val.length == 0 || val.trim() == '';
}

function onEvent(eventName, value1, value2)
{
    onFirstEventPush(eventName);
	switch (eventName)
	{
		case 'Optional Captions':
			if (lyric_box == null)
			{
				lyric_box = new FlxSprite().makeGraphic(1, 1, 0xAA000000);
				lyric_text = new FlxText(0, 520, -1, '', 32);
				lyric_text.setFormat(Paths.font("liberbold.ttf"), 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				for (i in [lyric_box, lyric_text])
				{
					i.cameras = [camOther];
					i.visible = false;
					add(i);
				}
			}
			if (nullBlank(value1) || value1 == '0' || ClientPrefs.language == 'english')
			{
				lyric_box.visible = lyric_text.visible = false;
				return;
			}
			if (showDevInfo) trace(Lang.str(value1));
			lyric_box.visible = lyric_text.visible = true;
			lyric_text.text = Lang.str(value1);
			lyric_box.setGraphicSize(Std.int(lyric_text.width + 20), Std.int(lyric_text.height));
			lyric_box.updateHitbox();
			lyric_text.x = (FlxG.width - lyric_text.width) / 2;
			lyric_text.y = Std.int(nullBlank(value2) ? 500 : value2);
			lyric_box.setPosition(lyric_text.x - 10, lyric_text.y);
		case 'Set Cams':
			var coords = value1.split(',');
			var zoomy = Std.parseFloat(value2);
			if (showDevInfo) trace([coords, zoomy]);
			camSpecialThing([coords[0], coords[1]], [coords[2], coords[3]], zoomy);
		case 'Reset Cams':
			resetCam();
		case 'Insta Cam Zoom':
			switch (Std.int(value2))
			{
				default:
					camGame.zoom += Std.parseFloat(value1);
					defaultCamZoom += Std.parseFloat(value1);
				case 1:
					camGame.zoom = Std.parseFloat(value1);
					defaultCamZoom = Std.parseFloat(value1);
			}
		case '_placeholder':
			if (showDevInfo) trace('vs placeholder');
		case 'Reactor Beep':
			flashSprite?.alpha = 0.3;
		case 'Change Character':
			if (hasColor) scoreTxt.color = dad.healthColour == FlxColor.BLACK ? FlxColor.WHITE : dad.healthColour;
		case 'flash':
			var charType = 1;
			if (value1 != null) charType = Std.int(value1);
			// also used for identity crisis idk why dont blame me shrug
			switch (charType)
			{
				case 0:
					camGame.flash(FlxColor.WHITE, 0.35);
				case 1:
					camGame.flash(FlxColor.WHITE, 0.35);
				case 2:
					camGame.flash(FlxColor.WHITE, 0.55);
				// darkMono.visible = true;
				case 3:
					camGame.flash(FlxColor.WHITE, 0.55);
					// darkMono.visible = false;
					// saxguy.visible = false;
			}
		case 'Extra Cam Zoom':
			var _zoom:Float = Std.parseFloat(value1);
			if (Math.isNaN(_zoom)) _zoom = 0;
			defaultCamZoomAdd = _zoom;
		case 'Camera Twist':
			camTwist = true;
			var _intensity:Float = Std.parseFloat(value1);
			if (Math.isNaN(_intensity)) _intensity = 0;
			var _intensity2:Float = Std.parseFloat(value2);
			if (Math.isNaN(_intensity2)) _intensity2 = 0;
			camTwistIntensity = _intensity;
			camTwistIntensity2 = _intensity2;
			if (_intensity2 == 0)
			{
				camTwist = false;
				FlxTween.tween(camHUD, {angle: 0}, 1, {ease: FlxEase.sineInOut});
				FlxTween.tween(camGame, {angle: 0}, 1, {ease: FlxEase.sineInOut});
			}
			
		case 'Alter Camera Bop':
			var _intensity:Float = Std.parseFloat(value1);
			if (Math.isNaN(_intensity)) _intensity = 1;
			var _interval:Int = Std.parseInt(value2);
			if (Math.isNaN(_interval)) _interval = 4;
			
			camZoomingMult = _intensity;
			// gamez = _intensity;
			beatsPerZoom = _interval;
	}
}

function onStepHit()
{
	if (camTwist)
	{
		// Because of difference in cameras that I do NOT want to fix, this has to be done in a different way
		if (curStep % 4 == 0) FlxTween.tween(camHUD, {y: -6 * camTwistIntensity2}, Conductor.stepCrotchet * 0.002, {ease: FlxEase.circOut});
		
		if (curStep % 4 == 2) FlxTween.tween(camHUD, {y: 0}, Conductor.stepCrotchet * 0.002, {ease: FlxEase.sineIn});
	}
}

function onBeatHit()
{
	if (camTwist) // && ClientPrefs.flashing
	{
		if (curBeat % 2 == 0)
		{
			twistShit = twistAmount;
		}
		else
		{
			twistShit = -twistAmount;
		}
		camHUD.angle = twistShit * camTwistIntensity2;
		camGame.angle = twistShit * camTwistIntensity2;
		FlxTween.tween(camHUD, {angle: twistShit * camTwistIntensity}, Conductor.stepCrotchet * 0.002, {ease: FlxEase.circOut});
		FlxTween.tween(camHUD, {x: -twistShit * camTwistIntensity}, Conductor.crochet * 0.001, {ease: FlxEase.linear});
		FlxTween.tween(camGame, {angle: twistShit * camTwistIntensity}, Conductor.stepCrotchet * 0.002, {ease: FlxEase.circOut});
		FlxTween.tween(camGame, {x: -twistShit * camTwistIntensity}, Conductor.crochet * 0.001, {ease: FlxEase.linear});
	}
}
