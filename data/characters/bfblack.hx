function onCreatePost()
{
	switch (curSong)
	{
		// case 'Double Kill': DEADASS DOESN'T WORK HERE UNLESS I PUT A TRACE I DONT KNOW WHY????
		// rimlightExcludedSkins.push('bfblack');
		case 'Defeat':
			nonDeathSkins.push('bfblack');
			rimlightExcludedSkins.push('bfblack');
			boyfriend.shader = null; // I GUESS. I hope I can find a better way to do this
		case 'Finale':
			skinColors.set('bfblack', [0xFF2B2C3C, 0xFF1A182E, 0xFF485E84]);
			rimlightExcludedSkins.push('bfblack');
			boyfriend.shader = null;
	}
}

function onStartCountdown() if (curSong == 'Double Kill') rimlightExcludedSkins.push('bfblack'); // refer to the comment in the previous function
