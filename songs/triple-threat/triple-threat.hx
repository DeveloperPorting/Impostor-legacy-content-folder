import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

function onStepHit()
{
	switch (curStep)
	{
		case 1:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 6.5, {ease: FlxEase.quadInOut});
		case 132:
			defaultCamZoom = 0.55;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 2, {ease: FlxEase.quadOut});
		case 240:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 260:
			defaultCamZoom = 0.52;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 0.5, {ease: FlxEase.quadOut});
		case 320:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 2, {ease: FlxEase.quadOut});
		case 384:
			defaultCamZoom = 0.55;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 416:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 0.8, {ease: FlxEase.quadOut});
		case 448:
			defaultCamZoom = 0.52;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 513:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 612:
			defaultCamZoom = 0.6;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 2, {ease: FlxEase.quadInOut});
			camSpecialThing([700, 600], [950, 580]);
		case 644:
			defaultCamZoom = 0.65;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
			camSpecialThing([720, 620], [950, 600]);
		case 680:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 0.5, {ease: FlxEase.quadOut});
		case 1000:
			defaultCamZoom = 0.55;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
			camSpecialThing([600, 550], [1200, 550]);
		case 1032:
			FlxTween.tween(camGame, {zoom: 0.58}, 0.2, {ease: FlxEase.quadOut});
		case 1036:
			FlxTween.tween(camGame, {zoom: 0.58}, 0.2, {ease: FlxEase.quadOut});
		case 1040:
			FlxTween.tween(camGame, {zoom: 0.58}, 0.2, {ease: FlxEase.quadOut});
		case 1044:
			FlxTween.tween(camGame, {zoom: 0.58}, 0.2, {ease: FlxEase.quadOut});
		case 1048:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
			camSpecialThing([600, 550], [950, 550]);
		case 1064:
			defaultCamZoom = 0.49;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1072:
			FlxTween.tween(camGame, {zoom: 0.51}, 0.2, {ease: FlxEase.quadOut});
		case 1076:
			FlxTween.tween(camGame, {zoom: 0.51}, 0.5, {ease: FlxEase.quadOut});
		case 1096:
			defaultCamZoom = 0.51;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1112:
			FlxTween.tween(camGame, {zoom: 0.49}, 0.2, {ease: FlxEase.quadOut});
		case 1116:
			FlxTween.tween(camGame, {zoom: 0.49}, 0.2, {ease: FlxEase.quadOut});
		case 1120:
			FlxTween.tween(camGame, {zoom: 0.49}, 0.2, {ease: FlxEase.quadOut});
		case 1128:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1192:
			defaultCamZoom = 0.51;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1288:
			defaultCamZoom = 0.55;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1308:
			defaultCamZoom = 0.65;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadIn});
			camSpecialThing([500, 650], [950, 550]);
		case 1320:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 2, {ease: FlxEase.quadOut});
		case 1402:
			defaultCamZoom = 0.55;
		case 1448:
			defaultCamZoom = 0.5;
		case 1464:
			defaultCamZoom = 0.52;
		case 1482:
			defaultCamZoom = 0.55;
		case 1512:
			defaultCamZoom = 0.5;
		case 1544:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1544:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1548:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1552:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1556:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1561:
			defaultCamZoom = 0.52;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1576:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1688:
			defaultCamZoom = 0.52;
		case 1692:
			defaultCamZoom = 0.54;
		case 1696:
			defaultCamZoom = 0.56;
		case 1700:
			defaultCamZoom = 0.58;
		case 1704:
			defaultCamZoom = 0.55;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
			camSpecialThing([500, 500], [1300, 550]);
		case 1768:
			defaultCamZoom = 0.5;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 2, {ease: FlxEase.quadOut});
			camSpecialThing([700, 550], [1000, 550]);
		case 1800:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1804:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1808:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1812:
			FlxTween.tween(camGame, {zoom: 0.52}, 0.2, {ease: FlxEase.quadOut});
		case 1816:
			defaultCamZoom = 0.55;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
			camSpecialThing([500, 550], [1200, 550]);
		case 1832:
			defaultCamZoom = 0.59;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadOut});
		case 1846:
			defaultCamZoom = 0.8;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 15, {ease: FlxEase.quadInOut});
			camSpecialThing([500, 550], [1500, 600]);
			camZooming = false;
		case 2073:
			defaultCamZoom = 1.3;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 2, {ease: FlxEase.quadOut});
			camSpecialThing([500, 550], [1700, 100]);
		case 2088:
			loBlack.alpha = 1;
			camSpecialThing([1700, 100], [1700, 100]);
			camHUD.visible = false;
		case 2088:
			loBlack.alpha = 1;
			defaultCamZoom = 0.6;
			FlxTween.tween(camGame, {zoom: defaultCamZoom}, 0.1, {ease: FlxEase.linear});
		case 2104:
			flashback.alpha = 1;
			flashback.animation.play('1', true);
		case 2136:
			flashback.animation.play('2', true);
		case 2168:
			flashback.animation.play('3', true);
		case 2184:
			flashback.animation.play('4', true);
		case 2200:
			flashback.animation.play('5', true);
		case 2232:
			flashback.animation.play('6', true);
		case 2264:
			flashback.animation.play('7', true);
		case 2296:
			flashback.animation.play('8', true);
		case 2328:
			flashback.animation.play('9', true);
		case 2344:
			flashback.alpha = 0.001;
		case 2360:
			logo.alpha = 1;
		}
}