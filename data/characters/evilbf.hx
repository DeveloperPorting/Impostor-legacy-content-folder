function onKeyPress(k:Int):Void
{
	if (k == 0 && boyfriend.curCharacter == 'evilbf' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('wow');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}