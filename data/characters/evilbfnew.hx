function onKeyPress(k:Int):Void
{
	if (k == 0 && boyfriend.curCharacter == 'evilbfnew' && boyfriend.getAnimName() == 'idle')
	{
		boyfriend.playAnim('wow');
		boyfriend.specialAnim = true;
		boyfriend.holding = true;
	}
}