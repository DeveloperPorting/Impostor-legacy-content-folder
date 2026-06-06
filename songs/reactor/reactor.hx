function onCreatePost()
{
	camSpecialThing([1725, 1100], [1725, 1100], defaultCamZoom, 0);
}

function onEvent(n, v1, v2)
{
	switch (n)
	{
		case 'Legacy':
			switch (v1)
			{
				case 'base':
					camSpecialThing([1450, 1150], [1950, 1150], 0.8);
				case 'mid':
					camSpecialThing([1725, 1100], [1725, 1100], 0.7);
				case 'mid2':
					camSpecialThing([1725, 1100], [1725, 1100], 0.8);
				case 'mid3':
					camSpecialThing([1725, 1200], [1725, 1200], 0.9);
			}
	}
}

// Jesus christ
/*

	if curBeat == 608 then
		setProperty('defaultCamZoom',0.9)
		followchars = true
		xx = 1725
		yy = 1200
		xx2 = 1725
		yy2 = 1200
	end
	if curBeat == 672 then
		setProperty('defaultCamZoom',0.7)
		followchars = true
		xx = 1725
		yy = 1100
		xx2 = 1725
		yy2 = 1100
	end
 */
