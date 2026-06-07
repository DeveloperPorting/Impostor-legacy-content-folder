import funkin.states.substates.PauseSubState;

function onLoad()
{
	FlxG.camera.pixelPerfectRender = true;
	
	var bg:BGSprite = new BGSprite('stages/skeld/tomongus/pixel/stars', -200, 0, 1, 1);
	bg.antialiasing = false;
	bg.setGraphicSize(Std.int(bg.width * 6));
	bg.updateHitbox();
	add(bg);
	
	var fg:BGSprite = new BGSprite('stages/skeld/tomongus/pixel/fg', -200, 0, 1, 1);
	fg.antialiasing = false;
	fg.setGraphicSize(Std.int(fg.width * 6));
	fg.updateHitbox();
	add(fg);
}

function onCreatePost()
{
	camSpecialThing([500, 475], [800, 475]);
	hasCovers = 0;
	
	for (character in [boyfriend, dad, gf])
	{
		character.setPosition(Math.round(character.x), Math.round(character.y));
		character.origin.set(Math.round(character.origin.x), Math.round(character.origin.y)); // fuck you ! fuck you ! fuck y
	}
	
	PauseSubState.songName = 'tomongusPause';
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'tomongusdie':
			FlxG.sound.play(Paths.sound('stage/tomongus_Shot'));
	}
}
