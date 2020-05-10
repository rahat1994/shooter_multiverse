import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shootermultiverse/game/game.dart';
import 'game/sound_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  await Flame.images.loadAll([
    'game_bg.png',
    'planet_1.png',
    'planet_2.png',
    'planet_3.png',
    'ship.png',
    'fire.png',
    'win.png',
    'explosion.png',
    'ui/dialog-credits.png',
    'ui/dialog-help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
    'ui/start-button.png',
    'branding/title.png',
    'lose_splash.png',
  ]);
  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'sfx/death_is_another_path.mp3',
    'sfx/explosion.mp3',
    'sfx/main_theme.mp3',
  ]);

  ShooterGame game = ShooterGame();
  runApp(game.widget);

  VerticalDragGestureRecognizer verticalDrag = VerticalDragGestureRecognizer();
  verticalDrag.onUpdate = game.onDrag;
  flameUtil.addGestureRecognizer(verticalDrag);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTap = game.onTap;
  flameUtil.addGestureRecognizer(tapper);
}
