function onStepHit()
{
	switch (curStep)
	{
        case 0:
            defaultCamZoom = 0.65;
        case 32:
            defaultCamZoom = 0.63;
        case 64:
            defaultCamZoom = 0.66;
            camSpecialThing([540, 400], [900, 400]);
        case 256:
            defaultCamZoom = 0.68;
        case 464:
            defaultCamZoom = 0.85;
            camSpecialThing([540, 400], [1200, 430]);
            FlxTween.tween(camGame, {zoom: defaultCamZoom}, 3, {ease: FlxEase.quadOut});
        case 506:
            defaultCamZoom = 0.6;
            camSpecialThing([540, 380], [540, 380]);
            FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
        case 520:
            camSpecialThing([540, 380], [900, 380]);
        case 640:
            defaultCamZoom = 0.85;
            camSpecialThing([540, 380], [1200, 430]);
            FlxTween.tween(camGame, {zoom: defaultCamZoom}, 3, {ease: FlxEase.quadOut});
        case 704:
            defaultCamZoom = 0.6;
            camSpecialThing([540, 380], [900, 380]);
            FlxTween.tween(camGame, {zoom: defaultCamZoom}, 2, {ease: FlxEase.quadOut});
        case 828:
            defaultCamZoom = 0.58;
            camSpecialThing([720, 720], [720, 380]);
        case 840:
            defaultCamZoom = 0.6;
            camSpecialThing([540, 380], [900, 380]);
        case 1096:
            defaultCamZoom = 0.63;
        case 1224:
            defaultCamZoom = 0.58;
            camSpecialThing([720, 300], [720, 300]);
    }
}