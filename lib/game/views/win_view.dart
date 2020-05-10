import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:shootermultiverse/game/game.dart';

class WinView {
  final ShooterGame game;
  Rect rect;
  Sprite sprite;

  WinView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
    sprite = Sprite('win.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
}