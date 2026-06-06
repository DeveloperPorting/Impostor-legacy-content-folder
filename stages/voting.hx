var ext = 'stages/jorsawsee/voting-time/';
var voting5:FlxSprite;
var voting6:FlxSprite;
var redmungus:Character;

function onLoad()
{
	var bars:FlxSpriteGroup = new FlxSpriteGroup();
	bars.cameras = [camHUD];
	add(bars);
	
	for (i in 0...2) // maybe this is doin too much idk
	{
		var bar = new FlxSprite().makeGraphic(FlxG.width + 3, 90, FlxColor.BLACK);
		bar.y = i == 1 ? 630 : 0;
		bars.add(bar);
	}
	
	var voting1:FlxSprite = new FlxSprite(700, 125).loadGraphic(Paths.image(ext + 'back'));
	voting1.scale.set(1.5, 1.5);
	voting1.updateHitbox();
	add(voting1);
	
	// voting2
	var voting2:FlxSprite = new FlxSprite(-430, -275).loadGraphic(Paths.image(ext + 'walls something'));
	voting2.scale.set(1.5, 1.5);
	voting2.updateHitbox();
	add(voting2);
	
	var votinguh:FlxSprite = new FlxSprite(500, 590).loadGraphic(Paths.image(ext + 'chair3'));
	votinguh.scale.set(1.2, 1.2);
	votinguh.updateHitbox();
	add(votinguh);
	
	// voting3
	var voting3:FlxSprite = new FlxSprite(150, 625).loadGraphic(Paths.image(ext + 'chair2'));
	voting3.scale.set(1.4, 1.4);
	voting3.updateHitbox();
	add(voting3);
	
	// voting4
	var voting4:FlxSprite = new FlxSprite(-180, 700).loadGraphic(Paths.image(ext + 'chair1'));
	voting4.scale.set(1.5, 1.5);
	voting4.updateHitbox();
	add(voting4);
	
	redmungus = new Character(1775, 200, 'madgus');
	startCharacterPos(redmungus);
	add(redmungus);
	redmungus.scale.set(1.2, 1.2);
	redmungus.danceEveryNumBeats = 1;
}

function onCreatePost()
{
	for (playField in playFields)
		if (playField.ID != 0) playField.playerControls = false;
		
	game.boyfriend.scale.x *= 1.35;
	game.boyfriend.scale.y *= 1.35;
	game.dad.scale.set(1.2, 1.2);
	game.boyfriend.updateHitbox();
	game.boyfriend.dance();
	var voting5:FlxSprite = new FlxSprite(-140, 680).loadGraphic(Paths.image(ext + 'table'));
	voting5.scale.set(1.5, 1.5);
	voting5.updateHitbox();
	add(voting5);
	
	var voting6:FlxSprite = new FlxSprite(-428, -170).loadGraphic(Paths.image(ext + 'light'));
	voting6.scale.set(1.5, 1.5);
	voting6.updateHitbox();
	voting6.blend = BlendMode.ADD;
	add(voting6);
	
	snapCamToPos(1275, 575);
	// snapCamToPos(1800, 575);
	game.isCameraOnForcedPos = true;
	
	game.playFields.members[2].owner = game.gf;
	game.playFields.members[2].visible = false;
	game.playFields.members[3].owner = redmungus;
	game.playFields.members[3].visible = false;
	modManager.setValue("alpha", 1, 2);
	modManager.setValue("alpha", 1, 3);
	
	if (boyfriend.gameoverLoopDeathSound == null) boyfriend.gameoverLoopDeathSound = 'Jorsawsee_Loop';
	if (boyfriend.gameoverConfirmDeathSound == null) boyfriend.gameoverConfirmDeathSound = 'Jorsawsee_End';
}

function onBeatHit()
{
	redmungus.onBeatHit(curBeat);
}

function changeUI(who:Character)
{
	if (hasColor) scoreTxt.color = who.healthColour;
	if (who != boyfriend)
	{
		iconP2.changeIcon(who.healthIcon);
		playHUD.healthBar.setColors(who.healthColour, boyfriend.healthColour);
	}
}

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Cam lock in Voting Time':
			if (value1 == 'in')
			{
				FlxG.camera.zoom = 1;
				defaultCamZoom = 1;
				
				if (value2 == 'dad')
				{
					snapCamToPos(460, 700);
					changeUI(dad);
				}
				else
				{
					changeUI(boyfriend);
					snapCamToPos(2100, 700);
				}
			}
			else if (value1 == 'close')
			{
				FlxG.camera.zoom = 1.05;
				defaultCamZoom = 1.05;
				
				if (value2 == 'dad')
				{
					snapCamToPos(480, 680);
					changeUI(gf);
				}
				else
				{
					snapCamToPos(2100, 680);
					changeUI(redmungus);
				}
			}
			else
			{
				defaultCamZoom = 0.55;
				FlxG.camera.zoom = 0.55;
				snapCamToPos(1275, 575);
			}
			
		case 'Play Animation':
			if (value1 == 'redmungus')
			{
				redmungus.playAnim(value2, true);
				redmungus.specialAnim = true;
			}
	}
}
