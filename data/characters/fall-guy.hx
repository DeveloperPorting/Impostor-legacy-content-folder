function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'fall-guy' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}
