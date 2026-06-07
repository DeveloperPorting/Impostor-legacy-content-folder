var ext = 'stages/freeplay/jerma/';

function onLoad()
{
	var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + "jerma"));
	add(bg);
	var vig:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + "vignette"));
	add(vig);
	vig.cameras = [camHUD];
}

function onCreatePost()
{
	camSpecialThing([900, 450], [1000, 625]);
}
