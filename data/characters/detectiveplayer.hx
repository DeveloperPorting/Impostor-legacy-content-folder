function onCreatePost()
{
	if (curSong == 'Finale') skinColors.set('detectiveplayer', [0xFF342F43, 0xFF464154, 0xFF15141A]);
	else if (curSong == 'Defeat') nonDeathSkins.push('detectiveplayer');
}

function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'detectiveplayer' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}
