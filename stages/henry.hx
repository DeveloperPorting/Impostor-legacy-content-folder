var ext = 'stages/henry/';
public var mom:Character;
public var we_have_mom_boy:Bool = false;

function onLoad()
{
	var bg:FlxSprite = new FlxSprite(-1600, -300).loadGraphic(Paths.image(ext + 'stage'));
	add(bg);
}

function onCountdownStarted()
{
	if (!we_have_mom_boy) return;
	
	var fakeStartTimer = new FlxTimer().start((Conductor.crotchet / 1000) / playbackRate, function(tmr:FlxTimer) {
		mom.onBeatHit(tmr.loopsLeft);
	}, 5);
}

function onEvent(n, v1, v2)
{
	switch (n)
	{
		case 'Ellie Drop':
			mom.visible = true;
			dad.playAnim('shock', false);
			dad.specialAnim = true;
			mom.playAnim('enter', false);
			mom.specialAnim = true;
			iconP2.changeIcon('ellie');
		default:
			switch (v1)
			{
				case 'forcecamtarget':
					switch (v2)
					{
						case 'mom':
							camCurTarget = mom;
						default:
							camCurTarget = null;
					}
			}
	}
}

function onBeatHit()
{
	if (we_have_mom_boy) mom.onBeatHit(curBeat);
}

function onUpdate(elapsed)
{
	if (FlxG.keys.justPressed.Q && ClientPrefs.inDevMode)
	{
		setSongTime(70 * 1000);
		clearNotesBefore(Conductor.songPosition);
	}
}

function opponentNoteHitPre(note)
{
	if (note.noteType == 'Opponent 2 Sing')
	{
		note.owner = mom;
	}
	else if (note.noteType == 'Both Opponents Sing')
	{
		characterSing(mom, note);
	}
}

function onCreatePost()
{
	camSpecialThing([700, 550], [1000, 550], 0.7);
}
