import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:shootermultiverse/game/game.dart';
import 'package:shootermultiverse/game/views/view.dart';
class StartButton {
  final ShooterGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {

    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('ui/start-button.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTapDown() {
    game.activeView = View.playing;
  }
}