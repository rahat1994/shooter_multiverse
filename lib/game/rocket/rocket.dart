import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:shootermultiverse/game/game.dart';

class Rocket extends PositionComponent with HasGameRef, Tapable, ComposedComponent{

  Rect rocketRect;
  final ShooterGame game;
  Offset position;
  Sprite rocketSprite;


  Rocket(this.game){
    rocketSprite = Sprite('ship.png');
    game.rocketPosition = Offset(game.screenSize.width/2, game.screenSize.height - game.tileSize *5);
    rocketRect = Rect.fromLTWH(game.screenSize.width/2, game.screenSize.height - game.tileSize *5, game.tileSize *1.5, (game.tileSize *1.5) * 1.44);
  }

  @override
  void render(Canvas canvas) {
    rocketSprite.renderRect(canvas, rocketRect);
  }

  @override
  void update(double t) {

    if(position != null){
      rocketRect = rocketRect.translate(position.dx - rocketRect.left, 0);
    }
  }

  void onTap(){

  }

  void onDragStart(DragUpdateDetails d){
    position = Offset(d.globalPosition.dx, d.globalPosition.dy);
  }
}

