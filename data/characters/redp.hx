function onUpdate(elapsed:Float):Void
{
	if (FlxG.keys.justPressed.SPACE && boyfriend.curCharacter == 'redp' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('hey');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}
