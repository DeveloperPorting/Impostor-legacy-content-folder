import funkin.data.FinaleState;
import funkin.states.TitleState;

var video:FunkinVideoSprite;
var finale:Bool = false;

function onEndSong():Void {
	if (finale) {
		TitleState.initialized = false;
		FlxG.resetGame();
		return;
	}
	
	if (ClientPrefs.finaleState != FinaleState.INACTIVE) return;
	
	ClientPrefs.finaleState = FinaleState.ACTIVE;
	ClientPrefs.flush();
	
	FlxTween.tween(camGame, {zoom: .5}, 2, {ease: FlxEase.sineIn});
	FlxTween.tween(camHUD, {zoom: 2.5}, 1, {ease: FlxEase.sineIn});
	
	camHUD.fade(FlxColor.BLACK, 2);
	
	finale = true;
	canPause = false;
	
	FlxTimer.wait(2, function() {
		camHUD.visible = camGame.visible = false;
		
		add(video = new FunkinVideoSprite(0, 0, false));
		video.camera = camOther;
		
		video.onEnd(endSong);
		video.onFormat(() -> {
			video.setGraphicSize(0, FlxG.height);
			video.updateHitbox();
			video.screenCenter();
		});
		
		if (video.load(Paths.video('finale'))) video.delayAndStart() else endSong();
	});
	
	return Function_Stop;
}