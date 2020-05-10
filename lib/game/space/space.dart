import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:shootermultiverse/game/game.dart';

class Space{
  final ShooterGame game;
  Sprite bgSprite;
  Rect bgRect;
  
  Space(this.game){
    bgSprite = Sprite('game_bg.png');

    bgRect = Rect.fromLTWH(
        0,
        game.screenSize.height - (game.tileSize * 23),
        game.tileSize * 9,
        game.tileSize * 23
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}