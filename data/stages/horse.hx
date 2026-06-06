var ext = 'stages/dlc/horse/';

function onLoad()
{
	var sky:FlxSprite = new FlxSprite(-600, -380).loadGraphic(Paths.image(ext + 'sky'));
	add(sky);

	var one:FlxSprite = new FlxSprite(-910, -200).loadGraphic(Paths.image(ext + '1'));
	one.scrollFactor.set(0.7,0.7);
	add(one);

	var two:FlxSprite = new FlxSprite(130, 380).loadGraphic(Paths.image(ext + '2'));
	two.scrollFactor.set(0.8,0.8);
	add(two);

	var three:FlxSprite = new FlxSprite(-600, 200).loadGraphic(Paths.image(ext + '3'));
	three.scrollFactor.set(0.9,0.9);
	add(three);

	var ground:FlxSprite = new FlxSprite(-550, 660).loadGraphic(Paths.image(ext + 'ground'));
	add(ground);

}
function onCreatePost()
{
	game.gf.scale.set(0.9, 0.9);
	game.gf.color = 0xFFDDDDDD;
	pet.color = 0xFFDDDDDD;

	snapCamToPos(900, 380);
	camSpecialThing([540, 380], [900, 380]);
	
	var front:FlxSprite = new FlxSprite(-700, 600).loadGraphic(Paths.image(ext + 'front'));
	front.scrollFactor.set(1.1,1.1);
	add(front);

	var subtract:FlxSprite = new FlxSprite(-600, -380).loadGraphic(Paths.image(ext + 'subtract'));
	subtract.blend = BlendMode.SUBTRACT;
	subtract.scrollFactor.set(1,1);
	subtract.alpha = 0.11;
	add(subtract);
}


function onEvent(name, v1, v2)
{
	switch (name)
	{
		case 'Legacy':
			switch (v1)
			{
				case 'noob':
					isCameraOnForcedPos = true;
					snapCamToPos(500, 450);
				case 'bf':
					isCameraOnForcedPos = true;
					snapCamToPos(850, 450);
				case 'normal':
					isCameraOnForcedPos = false;
			}
	}
}
