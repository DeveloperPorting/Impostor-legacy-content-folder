import funkin.scripting.PluginsManager;

var bothSing:Bool = false;
var twoSing:Bool = false;
public var cargoDark:FlxSprite;
public var lightoverlayDK:FlxSprite;
public var mainoverlayDK:FlxSprite;
var cargoAirship:FlxSprite;
/*
	There is a bug where the first note played in a changed section will be the
	other character that sang last time. I do not know how to fix this yet.


	Post-note: I manually moved all of the events 10ms to the left in the .json
 */
var ext = 'stages/airship/double-kill/';
public var yellow:Character;
public var isBfGhost:Bool = false;
var mandoSing:Bool = false;

function onLoad()
{
	var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'cargo'));
	bg.antialiasing = true;
	bg.scale.set(2, 2);
	bg.updateHitbox();
	bg.scrollFactor.set(1, 1);
	bg.active = false;
	add(bg);
	
	cargoDark = new FlxSprite(-1000, -1000).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
	cargoDark.antialiasing = true;
	cargoDark.scrollFactor.set(0, 0);
	cargoDark.alpha = 0.001;
	add(cargoDark);
}

function goodNoteHit(note)
{
	// trace('wait this my jam!' + note.noteType);
	if (mandoSing) PluginsManager.callPluginFunc('PlayStateLegacy', 'characterSing', [yellow, note]);
}

function onBeatHit()
{
	if (yellow != null) yellow.onBeatHit(curBeat);
}

function onCreatePost()
{
	isBfGhost = (boyfriend.curCharacter == 'bf-ghost' || boyfriend.curCharacter == 'yellowplayable');
	
	if (isBfGhost)
	{
		mandoSing = true;
		
		yellow = new Character(3100, 650, 'yellow-ghost');
		yellow.alpha = 0.001;
		yellow.scale.x = -1 * yellow.scale.x;
		startCharacterPos(yellow);
		
		add(yellow);
	}
	
	lightoverlayDK = new FlxSprite(0, 0).loadGraphic(Paths.image(ext + 'scvavd'));
	lightoverlayDK.scale.set(2, 2);
	lightoverlayDK.updateHitbox();
	lightoverlayDK.alpha = 0.51;
	lightoverlayDK.blend = BlendMode.ADD;
	add(lightoverlayDK);
	
	mainoverlayDK = new FlxSprite(-100, 0).loadGraphic(Paths.image(ext + 'overlay ass dk'));
	mainoverlayDK.scale.set(4, 4);
	mainoverlayDK.updateHitbox();
	mainoverlayDK.alpha = 0.6;
	mainoverlayDK.blend = BlendMode.ADD;
	add(mainoverlayDK);
	// FlxG.camera.bgColor = FlxColor.RED;
	// add(cargoDarkFG);
}

function startCharacterPos(char:Character) {
    char.x += char.positionArray[0];
    char.y += char.positionArray[1];
}

// function onGameOver() FlxG.camera.bgColor = FlxColor.BLACK;
// LOL

function onEvent(eventName, value1, value2)
{
	switch (eventName)
	{
		case 'Legacy': // I fucked up but i dont wanna go back and fix all the events i put down
			switch (value1) // orbyy do not pull this line of code on me ever again i will kill you
			{
				case 'black':
					camCurTarget = game.gf;
				case 'not black':
					camCurTarget = null;
			}
		case 'Opponent Two':
			twoSing = Std.int(value1) == 1;
			if (!bothSing) refreshDoubleKillIcon();
		case 'Both Opponents':
			bothSing = Std.int(value1) == 1;
			playHUD.iconP2.changeIcon(bothSing ? 'double-kill' : (twoSing ? 'black' : 'white'));
	}
}

function refreshDoubleKillIcon()
{
	if (hasColor) playHUD.scoreTxt.color = (twoSing ? gf : dad).healthColour;
	playHUD.healthBar.setColors((twoSing ? gf : dad).healthColour, boyfriend.healthColour);
	playHUD.iconP2.changeIcon(twoSing ? 'black' : 'white');
}

function opponentNoteHitPre(note)
{
	if (note.noteType == 'Opponent 2 Sing')
	{
		note.owner = gf;
	}
	else if (bothSing)
	{
		PluginsManager.callPluginFunc('PlayStateLegacy', 'characterSing', [gf, note]);
	}
	else if (twoSing)
	{
		note.owner = gf;
	}
}
