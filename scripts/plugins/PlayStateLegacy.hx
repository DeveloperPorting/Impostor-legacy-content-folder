/**
 * PlayStateLegacy
 * Functions that appear to be global in Impostor Legacy PlayState (We currently don't have the source code to really know)
*/

function onLoad() {
	if (ClientPrefs.inDevMode) Logger.log('Script loaded', PRINT, true);
}

function startCharacterPos(char:Character) {
    char.x += char.positionArray[0];
    char.y += char.positionArray[1];
}

function characterSing(char:Character, note:Dynamic)
{
	if (char == null || note == null) return;

	var animName:String = '';
	
	switch (note.noteData % 4)
	{
		case 0:
			animName = 'singLEFT';
		case 1:
			animName = 'singDOWN';
		case 2:
			animName = 'singUP';
		case 3:
			animName = 'singRIGHT';
	}

	if (note.noteType == 'Alt Animation' || note.altNote)
	{
		animName += '-alt';
	}

	var curAnim = char.animation.curAnim;
	
	if (note.isSustainNote && curAnim != null && curAnim.name == animName)
	{
		char.holdTimer = 0;
		return;
	}

	char.playAnim(animName, !note.isSustainNote);
	
	char.holdTimer = 0;
}