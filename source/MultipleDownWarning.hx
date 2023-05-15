package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class MultipleDownWarning extends MusicBeatState {
	public static var leftState: Bool = false;

	var warnText: FlxText;

	override function create() {
		super.create();

		var bg: FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width, "Woah there!
			This song contains sections which involve
			holding down multiple notes at once, or spamming notes.
			This could be very diffiult on laptop keyboards
			You've been warned!
			[ENTER] Continue    [ESC] Go Back", 32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed: Float) {
		if (!leftState) {
			var back: Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				ClientPrefs.lotsOfNotesWarning = false;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!back) {
					FlxG.sound.volume = 1;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function(twn: FlxTween) {
							MusicBeatState.switchState(new PlayState());
						}
					});
				}
				else {
					FlxG.sound.volume = 1;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function(twn: FlxTween) {
							MusicBeatState.switchState(new FreeplayState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
