import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';
import 'package:shootermultiverse/game/game.dart';

class Missile extends PositionComponent with HasGameRef {
  Rect missileRect;
  final ShooterGame game;
  bool isExploded;
  bool isOffScreen = false;
  Sprite missileSprite;

  Missile(this.game, Offset rocketPosition) {
    missileSprite = Sprite('fire.png');
    missileRect = Rect.fromLTWH(rocketPosition.dx, rocketPosition.dy,
        game.tileSize * 0.5, (game.tileSize * 1) * 2);
  }

  @override
  void render(Canvas c) {
    missileSprite.renderRect(c, missileRect);
  }

  @override
  void update(double t) {
    if (missileRect.top.isNegative) {
      isOffScreen = true;
    }
    missileRect = missileRect.translate(0, -(game.tileSize * 12 * t));
  }
}
