public var bfLegs:Character;
var bfAnchorPoint:Array<Float> = [0, 0];
var legPosY = [13, 7, -3, -1, -1, 2, 7, 9, 7, 2, 0, 0, 3, 1, 3, 7, 13];

function onLoad()
{
	bfLegs = new Character(0, 0, 'bf-legs', true);
	boyfriendGroup.insert(boyfriendGroup.members.indexOf(bfLegs) + 1, bfLegs);
}

function onCreatePost()
{
	bfLegs.x = game.boyfriend.x;
	bfLegs.y = game.boyfriend.y;
	bfAnchorPoint[0] = game.boyfriend.x;
	bfAnchorPoint[1] = game.boyfriend.y;
}

function onUpdate(elapsed)
{
	game.boyfriend.y = bfAnchorPoint[1] + legPosY[bfLegs.animation.curAnim.curFrame];
	
	// This changes the legs from the miss version to the normal one and makes sure it starts on the same animation frame where it left off
	if (!StringTools.contains(game.boyfriend.animation.curAnim.name, 'miss') && StringTools.contains(bfLegs.animation.curAnim.name, 'miss'))
	{
		var lastFrame:Int = 0;
		lastFrame = bfLegs.animation.curAnim.curFrame;
		bfLegs.idleSuffix = '';
		bfLegs.recalculateDanceIdle();
		bfLegs.animation.curAnim.curFrame = lastFrame;
	}
	
	// Ensures that the arms and legs r always opposite from each other and only updates If bf is in his idle anim
	if (StringTools.contains(game.boyfriend.animation.curAnim.name, 'dance'))
	{
		game.boyfriend.danced = bfLegs.danced;
		game.boyfriend.animation.curAnim.curFrame = bfLegs.animation.curAnim.curFrame;
	}
}

function onKeyRelease() game.boyfriend.danced = bfLegs.danced;

function onCountdownTick()
{
	bfLegs.dance();
}

function onBeatHit()
{
	if (curBeat % 1 == 0)
	{
		bfLegs.dance();
	}
}

// This changes the legs from the normal version to the miss version and makes sure it starts on the same animation frame where it left off
function noteMiss(daNote)
{
	var lastFrame:Int = 0;
	
	lastFrame = bfLegs.animation.curAnim.curFrame;
	bfLegs.idleSuffix = 'miss';
	bfLegs.recalculateDanceIdle();
	bfLegs.animation.curAnim.curFrame = lastFrame;
}
