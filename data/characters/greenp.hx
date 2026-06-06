function onKeyPress(k:Int):Void
{
	if (boyfriend.curCharacter == 'greenp' && boyfriend.getAnimName() == 'idle')
	{
		if (k == 2)
		{
			boyfriend.playAnim('singUP');
			boyfriend.specialAnim = true;
			boyfriend.holding = true;
		}
	}
}

function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'greenp' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}
