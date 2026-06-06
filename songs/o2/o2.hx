var wtf:FlxText;

function onCreatePost()
{
	wtf = new flixel.text.FlxText(0, 0, 600, '');
	wtf.setFormat(Paths.font('vcr.ttf'), 96, 0xff80ffff, 'center');
	wtf.camera = camHUD;
	wtf.screenCenter();
	insert(0, wtf);
	
	camSpecialThing([700, 700], [980, 700]);
	snapCamToPos(800, 670);
}

function onEvent(event, v1, v2)
{
	if (event == 'Lights Down O2')
	{
		camGame.fade(FlxColor.BLACK, Conductor.crotchet / 500);
	}
	else if (event == 'WTF O2')
	{
		switch (v1)
		{
			case 'what':
				wtf.text = 'WHAT\n ';
			case 'the':
				wtf.text = 'WHAT THE\n ';
			case 'fuck':
				wtf.text = 'WHAT THE\nF-';
				
			case 'die':
				wtf.destroy();
				camHUD.alpha = camGame.alpha = .001;
				if (ClientPrefs.flashing) camOther.flash(0xff950000, Conductor.crotchet / 1000);
				
				prepareScary();
		}
		
		wtf.screenCenter();
	}
	else if (event == 'Change Character' && v2 == 'meangus')
	{
		camSpecialThing([850, 750], [1510, 750]);
		
		camGame.alpha = 1;
		
		camGame.fade(FlxColor.BLACK, Conductor.crotchet / 500, true, null, true);
		FlxTween.tween(camHUD, {alpha: 1}, Conductor.crotchet / 800, {ease: FlxEase.quadOut});
		
		scary();
	}
}
