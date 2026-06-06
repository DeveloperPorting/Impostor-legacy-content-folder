function onCreatePost()
{
	if (curSong == 'Finale') skinColors.set('bobby', [0xFF1F0F89, 0xFF392BA5, 0xFF19123E]);
	else if (curSong == 'Defeat') nonDeathSkins.push('bobby');
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
