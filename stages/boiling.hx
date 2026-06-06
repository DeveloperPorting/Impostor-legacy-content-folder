import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitterMode;
import flixel.effects.particles.FlxParticle;

import funkin.game.shaders.DropShadowShader;
//import funkin.objects.SnowEmitter;

var snowAlpha = 0.3;
//var snowEmitter:SnowEmitter;
var emberEmitter:FlxEmitter;
var ext = 'stages/polus/maroon/boiling/';
var lavaOverlay:FlxSprite;
var lava:FlxSprite;
var ground:FlxSprite;

function onLoad()
{
	lava = new FlxSprite(-650, -694); // FlxSprite(-400, -650);
	lava.frames = Paths.getSparrowAtlas(ext + 'wallBP');
	lava.animation.addByPrefix('bop', 'Back wall and lava', 24, true);
	lava.animation.play('bop');
	lava.scrollFactor.set(0.8, 0.8);
	add(lava);
	
	FlxTween.tween(lava, {y: -750}, 200);
	
	/*switch (pet.curPet) // change pet
	{
		case 'snowball':
			pet.loadPet('snowballmelted');
		case 'snowmate':
			pet.loadPet('snowmatemelted');
		case 'fishus':
			pet.loadPet('fishuscooked');
		case 'thenug':
			pet.loadPet('thenugcrisp');
		case 'slugmate':
			pet.loadPet('deadslugmate');
		case 'fribbit':
			pet.loadPet('fribbitsweat');
	}*/
	
	ground = new FlxSprite(1050, 650).loadGraphic(Paths.image(ext + 'platform'));
	add(ground);
	
	var bubbles = new FlxSprite(800, 850);
	bubbles.frames = Paths.getSparrowAtlas(ext + 'bubbles');
	bubbles.animation.addByPrefix('bop', 'Lava Bubbles', 24, true);
	bubbles.animation.play('bop');
	add(bubbles);
	emberEmitter = new FlxEmitter(-1200, 1000);
	
	for (i in 0...150)
	{
		var p = new FlxParticle();
		p.frames = Paths.getSparrowAtlas(ext + 'ember');
		p.animation.addByPrefix('ember', 'ember', 24, true);
		p.animation.play('ember');
		p.exists = false;
		p.animation.curAnim.curFrame = FlxG.random.int(0, 9);
		p.blend = BlendMode.ADD;
		emberEmitter.add(p);
	}
	emberEmitter.launchMode = FlxEmitterMode.SQUARE;
	emberEmitter.velocity.set(-50, -400, 50, -800, -100, 0, 100, -800);
	emberEmitter.scale.set(1, 1, 0.8, 0.8, 0, 0, 0, 0);
	emberEmitter.drag.set(0, 0, 0, 0, 5, 5, 10, 10);
	emberEmitter.width = 4200.45;
	emberEmitter.alpha.set(1, 1);
	emberEmitter.lifespan.set(4, 4.5);
	// heartEmitter.loadParticles(Paths.image('mira/littleheart', 'impostor'), 500, 16, true);
	
	/*snowEmitter = new SnowEmitter(900, -800, 2700);
	snowEmitter.start(false, ClientPrefs.lowQuality ? 0.5 : 0.5);
	snowEmitter.scrollFactor.x.set(1, 1.5);
	snowEmitter.scrollFactor.y.set(1, 1.5);
	add(snowEmitter);
	snowEmitter.alpha.active = false;
	snowEmitter.onEmit.add((particle) -> particle.alpha = snowAlpha);
	snowEmitter.zIndex = 13;*/
	
	redscreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFF24400);
	redscreen.scrollFactor.set();
	redscreen.alpha = 0.001;
	redscreen.cameras = [camHUD];
	add(redscreen);
	
	emberEmitter.start(false, FlxG.random.float(0.3, 0.4), 100000);
}

function onCreatePost()
{
	lavaOverlay = new FlxSprite(1000, -50).loadGraphic(Paths.image(ext + 'overlaythjing'));
	lavaOverlay.scale.set(1.5, 1.5);
	lavaOverlay.blend = BlendMode.ADD;
	lavaOverlay.alpha = 0.7;
	
	add(lavaOverlay);
	if (!ClientPrefs.lowQuality) add(emberEmitter);
	
	/*if (hasBfSkin && game.boyfriend.curCharacter == 'bfpolus')
	{
		triggerEventNote('Change Character', 'dad', 'maroonplayableop');
		game.dad.x = 1050;
		game.dad.y = 320;
		triggerEventNote('Change Character', 'boyfriend', 'bf-lava');
	}*/
	
	//pet.zIndex = 0;
	lavaOverlay.zIndex = 2;
	emberEmitter.zIndex = 2;
	//snowEmitter.zIndex = 2;
	redscreen.zIndex = 3;
	
	if (ClientPrefs.shaders)
	{
		/*if (hasBfSkin && game.boyfriend.curCharacter != 'bf-lava')
		{
			var bfRim:DropShadowShader;
			bfRim = new DropShadowShader();
			bfRim.setAdjustColor(-30, -15, -20, 10);
			bfRim.color = 0xFFFF9100;
			bfRim.angle = 0;
			bfRim.threshold = 0.07;
			bfRim.distance = 15;
			boyfriend.shader = bfRim;
			bfRim.attachedSprite = boyfriend;
			boyfriend.animation.onFrameChange.add(function() {
				if (bfRim.attachedSprite != null)
					bfRim.updateFrameInfo(boyfriend.frame);
			});
			boyfriend.useRenderTexture = true;
		}
		
		if (hasPet)
		{
			var petRim:DropShadowShader;
			petRim = new DropShadowShader();
			petRim.setAdjustColor(-30, -15, -20, 10);
			petRim.color = 0xFFFF9100;
			petRim.angle = 50;
			petRim.distance = 10;
			petRim.threshold = 0.1;
			pet.shader = petRim;
			petRim.attachedSprite = pet;
			pet.animation.onFrameChange.add(function() {
				if (petRim.attachedSprite != null)
					petRim.updateFrameInfo(pet.frame);
			});
		}*/
	}
}

function onEvent(n, v1, v2)
{
	switch (n)
	{
		case 'Legacy':
			switch (v1)
			{
				case 'byebye':
					// FlxTween.tween(game.boyfriend, {y: 1500}, 2, {ease: FlxEase.expoInOut});
					// FlxTween.tween(game.dad, {y: 1200}, 2, {ease: FlxEase.expoInOut});
					// FlxTween.tween(ground, {y: 1500}, 2, {ease: FlxEase.expoInOut});
					// FlxTween.tween(pet, {y: 1500}, 2, {ease: FlxEase.expoInOut});
					// FlxTween.cancelTweensOf(lava);
					// FlxTween.tween(lava, {y: -550}, 4, {ease: FlxEase.expoInOut});
					camSpecialThing(null, [2000, 635], 0.8);
					triggerEventNote('setChrom', '-5', '2');
					FlxTween.tween(redscreen, {alpha: 1}, 2, {ease: FlxEase.expoInOut});
			}
	}
}
