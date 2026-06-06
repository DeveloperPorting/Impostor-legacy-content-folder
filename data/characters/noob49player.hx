function onCreatePost()
{
	if (hasPet)
	{
		if (pet.curPet == 'rgbpet')
		{
			pet.shader = null;
		}
		pet.loadPet('greypet');
	}
	else
	{
		pet.loadPet('greypet');
	}
	
	if (curSong == 'Finale') skinColors.set('noob49player', [0xFF5A5B7B, 0xFF828299, 0xFF282C4F]);
	else if (curSong == 'Defeat') nonDeathSkins.push('noob49player');
}
