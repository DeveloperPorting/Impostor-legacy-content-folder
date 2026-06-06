function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'minigrey' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}
