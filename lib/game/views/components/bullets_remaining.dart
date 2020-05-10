import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:shootermultiverse/game/game.dart';
import 'package:shootermultiverse/game/views/view.dart';
class BulletsRemaining {
  final ShooterGame game;
  Rect rect;
  Sprite sprite;
  TextConfig config;
  BulletsRemaining(this.game) {

    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    config = TextConfig(fontSize: 25.0, color: Color(0xFFFFFFFF), textAlign: TextAlign.center);
  }

  void render(Canvas c) {

    config.render(c, 'Bullets Remaining ${game.bulletRemaining}', Position(game.tileSize * 2, (game.screenSize.height * .95)- (game.tileSize * 0.5)));
  }

  void update(double t) {}

  void onTapDown() {
    game.activeView = View.playing;
  }
}