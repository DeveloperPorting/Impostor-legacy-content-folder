// If we move the ui edits in utils to the playhud then ill make this its own hud class otherwise heres my chopped cooked buns w salad code
import flixel.util.FlxSort;

import funkin.utils.SortUtil;
import funkin.game.shaders.RGBPalette.RGBShaderReference;
import funkin.game.shaders.RGBPalette;

var finaleUIActive:Bool = false;
var ext:String = 'ui/finale/';
var newBar:Bar;
var blackPIcon:FlxSprite;

// RGBShader related vars for skin support
var isRGB:Bool = false;

public var skinColors:Map<String, Array<FlxColor>> = [
	// public so hypothetically you can push your own without needing to edit this script hopefully
	'redp' => [0xFFFD132B, 0xFFFC5D6A, 0xFF700E4A], // normal, light, dark
	'greenp' => [0xFF1E4824, 0xFF4C683C, 0xFF00221F],
	'yellowplayable' => [0xFFFFD452, 0xFFFFEC8E, 0xFFE0893B],
	'whitep' => [0xFFE9E4F4, 0xFFFFFFFF, 0xFF7278B6],
	'blackp' => [0xFF381B51, 0xFF5539A0, 0xFF200A1E],
	'maroonplayable' => [0xFF6B2B3C, 0xFFCC5849, 0xFF440D37],
	'pinkplayable' => [0xFFFD42AD, 0xFFFFBFFE, 0xFF9E01B9],
	'fall-guy' => [0xFFFF6699, 0xFFFFB999, 0xFFCC3399],
	'minigrey' => [0xFF59587A, 0xFFC07EF1, 0xFF282C4F]
];

function onCreatePost()
{
	isRGB = skinColors.exists(boyfriend.curCharacter);
	var playerBar:String = isRGB ? 'insideRGB' : 'insideBLUE';
	
	newBar = new Bar(0, FlxG.height - 198, ext + 'healthbarBG', function() return game.playHUD.healthLerp, game.healthBounds.min, game.healthBounds.max);
	newBar.barWidth -= 230;
	newBar.leftBar.loadGraphic(Paths.image(ext + 'insideRED'));
	newBar.rightBar.loadGraphic(Paths.image(ext + playerBar));
	newBar.leftToRight = false;
	newBar.forEachAlive(obj -> {
		obj.scale.set(0.6, 0.6);
		obj.updateHitbox();
	});
	if (ClientPrefs.downScroll)
	{
		newBar.flipY = true;
		newBar.y = -75;
	}
	newBar.screenCenter(FlxAxes.X);
	newBar.setColors(FlxColor.WHITE, FlxColor.WHITE);
	// dumb ordering shit fuck i hate it!
	newBar.bg.zIndex = 0;
	newBar.rightBar.zIndex = 1;
	newBar.leftBar.zIndex = 1;
	newBar.visible = false;
	playHUD.insert(0, newBar);
	newBar.sort(SortUtil.sortByZ, FlxSort.ASCENDING);
	
	if (isRGB)
	{
		var rgbShader = new RGBShaderReference(newBar.rightBar, initRGBPalete(boyfriend.curCharacter));
		newBar.rightBar.shader = rgbShader.shader;
	}
	
	blackPIcon = new FlxSprite(45, ClientPrefs.downScroll ? -125 : 390);
	blackPIcon.frames = Paths.getSparrowAtlas('icons/icon-blackFinale');
	blackPIcon.scale.set(0.8, 0.8);
	blackPIcon.updateHitbox();
	blackPIcon.animation.addByPrefix('winning', 'black icon calm0', 24, true);
	blackPIcon.animation.addByPrefix('losing', 'black icon mad0', 24, true);
	blackPIcon.animation.play('winning');
	blackPIcon.offset.set(0, 0);
	blackPIcon.visible = false;
	playHUD.add(blackPIcon);
}

public function finaleUIOn()
{
	finaleUIActive = true;
	playHUD.healthBar.visible = false; // Ideally I'd completely remove it but i dont wanna add a bunch of null checks so
	newBar.visible = true;
	playHUD.iconP1.visible = true;
	blackPIcon.visible = true;
	playHUD.iconP1.x = newBar.x + (newBar.width / 1.4) + 40;
	playHUD.iconP1.y = newBar.y + 60;
	if (ClientPrefs.downScroll) playHUD.iconP1.y += 10;
}

function onUpdate(elapsed)
{
	if (!finaleUIActive) return;
	
	var newPercent:Null<Float> = FlxMath.remapToRange(FlxMath.bound(newBar.valueFunction(), newBar.bounds.min, newBar.bounds.max), newBar.bounds.min, newBar.bounds.max, 0, 100);
	newBar.percent = (newPercent != null ? newPercent : 0);
	updateParasiteIcon((100 - playHUD.healthBar.percent) * 0.01);
}

function updateParasiteIcon(curHealth:Float)
{
	if (curHealth < 0.2)
	{
		blackPIcon.animation.play('losing');
		blackPIcon.offset.set(0, 39);
	}
	else
	{
		blackPIcon.animation.play('winning');
		blackPIcon.offset.set(0, 0);
	}
}

function initRGBPalete(paletteToUse:String)
{
	var newRGB = new RGBPalette();
	newRGB.setColors(skinColors[paletteToUse]);
	return newRGB;
}

function opponentNoteHit(note)
{
	if (!finaleUIActive) return;
	
	if (health > .2) health -= (Math.max(health - .2, 0) * (note.isSustainNote ? .005 : .1));
}
