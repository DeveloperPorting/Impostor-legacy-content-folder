function onLoad()
{
	parent.useRenderTexture = true;
	parent.alpha = .8;
}

function onCreatePost()
{
	if (curSong == 'Finale') skinColors.set('yellow-ghost', [0xFFFFD452, 0xFFFFEC8E, 0xFFE0893B]);
	else if (curSong == 'Defeat') nonDeathSkins.push('yellow-ghost');
}
