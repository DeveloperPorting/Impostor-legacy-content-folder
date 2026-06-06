var video:FunkinVideoSprite;
var outroCutscene:Bool = false;

function onLoad()
{
	videoCutscene('week1/meltdown');
}

function onCreatePost()
{
	video = new FunkinVideoSprite(0, 0, false);
	insert(0, video);
	video.onFormat(() -> {
		video.camera = camOther;
		video.setGraphicSize(0, FlxG.height);
		video.updateHitbox();
		video.screenCenter();
	});
	if (isStoryMode || repeatedCutscenes) songEndCallback = meltEnd;
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Meltdown Video':
			meltdownVid();
	}
}

function onUpdate()
{
	if (outroCutscene)
	{
		if(controls.BACK) {
			outroCutscene = false;
			video.destroy();
			endSong();
		}
	}
	if (FlxG.keys.justPressed.Q && ClientPrefs.inDevMode)
	{
		setSongTime(143 * 1000);
		clearNotesBefore(Conductor.songPosition);
	}
}

function meltEnd()
{
	video.onEnd(() -> {
		endSong();
	});
	canPause = false;
	outroCutscene = true;
	camOther.bgColor = FlxColor.BLACK;
	if (video.load(Paths.video(Paths.sanitize('week1/post-week1')))) video.delayAndStart();
	textFade();
}

function meltdownVid()
{
	if (ClientPrefs.lowQuality) return;
	if (video.load(Paths.video(Paths.sanitize('week1/meltdownEnd')))) video.delayAndStart();
}
