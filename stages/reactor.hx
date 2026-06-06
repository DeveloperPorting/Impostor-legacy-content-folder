import funkin.game.shaders.DropShadowShader;

var ext = 'stages/mira/reactor/';
var toogusorange:FlxSprite;
var toogusblue:FlxSprite;
var tooguswhite:FlxSprite;

function onLoad()
{
	var bg0:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'wallbgthing'));
	add(bg0);
	
	var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'floornew'));
	add(bg);
	
	toogusorange = new FlxSprite(875, 890);
	toogusorange.frames = Paths.getSparrowAtlas(ext + 'yellowglita');
	toogusorange.animation.addByPrefix('bop', 'Pillars with crewmates instance 1', 24, false);
	toogusorange.animation.play('bop');
	toogusorange.setGraphicSize(Std.int(toogusorange.width * 1));
	add(toogusorange);
	
	var bg2:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'backbars'));
	add(bg2);
	
	toogusblue = new FlxSprite(450, 995);
	toogusblue.frames = Paths.getSparrowAtlas(ext + 'browngeoff');
	toogusblue.animation.addByPrefix('bop', 'Pillars with crewmates instance 1', 24, false);
	toogusblue.animation.play('bop');
	toogusblue.setGraphicSize(Std.int(toogusblue.width * 1));
	add(toogusblue);
	
	var bg3:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'frontpillars'));
	add(bg3);
	
	tooguswhite = new FlxSprite(1200, 100);
	tooguswhite.frames = Paths.getSparrowAtlas(ext + 'ball lol');
	tooguswhite.animation.addByPrefix('bop', 'core instance 1', 24, false);
	tooguswhite.animation.play('bop');
	add(tooguswhite);
}

function onCreatePost()
{
	var lightoverlay:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'frontblack'));
	add(lightoverlay);
	
	var mainoverlay:FlxSprite = new FlxSprite(750, 100);
	mainoverlay.frames = Paths.getSparrowAtlas(ext + 'yeahman');
	mainoverlay.animation.addByPrefix('bop', 'Reactor Overlay Top instance 1', 24, true);
	mainoverlay.animation.play('bop');
	add(mainoverlay);
	
	if (ClientPrefs.shaders)
	{
		if (hasBfSkin)
		{
			var bfRim:DropShadowShader; // pause
			bfRim = new DropShadowShader();
			bfRim.setAdjustColor(-75, -30, -45, 26);
			bfRim.color = 0xFFDDBD08;
			bfRim.angle = 100;
			bfRim.threshold = 0.07;
			bfRim.distance = 20;
			boyfriend.shader = bfRim;
			bfRim.attachedSprite = boyfriend;
			boyfriend.animation.onFrameChange.add(function() {
				if (bfRim.attachedSprite != null)
				{
					bfRim.updateFrameInfo(boyfriend.frame);
				}
			});
			boyfriend.useRenderTexture = true;
		}
		
		if (hasGfSkin)
		{
			var gfRim:DropShadowShader;
			gfRim = new DropShadowShader();
			gfRim.setAdjustColor(-75, -30, -45, 26);
			gfRim.color = 0xFFDDBD08;
			gfRim.angle = 100;
			gfRim.threshold = 0.07;
			gfRim.distance = 20;
			gf.shader = gfRim;
			gfRim.attachedSprite = gf;
			gf.animation.onFrameChange.add(function() {
				if (gfRim.attachedSprite != null)
				{
					gfRim.updateFrameInfo(gf.frame);
				}
			});
			gf.useRenderTexture = true;
		}
		
		if (hasPet)
		{
			var petRim:DropShadowShader;
			petRim = new DropShadowShader();
			petRim.setAdjustColor(-75, -30, -45, 26);
			petRim.color = 0xFFDDBD08;
			petRim.angle = 140;
			petRim.threshold = 0.07;
			pet.shader = petRim;
			petRim.attachedSprite = pet;
			pet.animation.onFrameChange.add(function() {
				if (petRim.attachedSprite != null)
				{
					petRim.updateFrameInfo(pet.frame);
				}
			});
		}
	}
	else
	{
		if (hasBfSkin) boyfriend.color = 0xffe080a6;
		
		if (hasGfSkin) gf.color = 0xffe080a6;
		
		if (hasPet) pet.color = 0xffe080a6;
	}
}

function onBeatHit()
{
	if (curBeat % 4 == 0)
	{
		toogusorange.animation.play('bop', true);
		toogusblue.animation.play('bop', true);
		tooguswhite.animation.play('bop', true);
	}
}
