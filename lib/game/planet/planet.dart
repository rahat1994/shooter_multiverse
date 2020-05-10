import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Animation;
import 'package:shootermultiverse/game/game.dart';

enum PlanetType {planet_1, planet_2, planet_3, dying_planet}


class Planet extends PositionComponent with HasGameRef, Tapable, ComposedComponent, Resizable {

  Rect planetRect;
  PlanetType type = PlanetType.dying_planet;
  bool isDestroyed = false;
  double planetVelocity = 0.0;
  ShooterGame game;
  bool direction = true;
  Planet1 planetOne;
  Planet2 planetTwo;
  Planet3 planeThree;
  DyingPlanet dyingPlanet;
  Planet(this.game, this.type)
        :planetOne = Planet1(),
        planetTwo = Planet2(),
        planeThree = Planet3(),
        super(){
    planetRect = Rect.fromLTWH(0, 0, 175, 175);

    Animation dyingPlanetAnimation = Animation.spriteList([
      Sprite('explosion.png', width: 32,height: 32, x: 0),
      Sprite('explosion.png', width: 32,height: 32, x: 64),
      Sprite('explosion.png', width: 32,height: 32, x: 96),
      Sprite('explosion.png', width: 32,height: 32, x: 128),
      Sprite('explosion.png', width: 32,height: 32, x: 160),
      Sprite('explosion.png', width: 32,height: 32, x: 192),
    ], stepTime: 0.3, loop: false);
    dyingPlanet = DyingPlanet(dyingPlanetAnimation);
  }

  PositionComponent get currentPlanet{

    (isDestroyed) ? type = PlanetType.dying_planet : type = type;


    switch(type){
      case PlanetType.planet_1:
        return planetOne;
      case PlanetType.planet_2:
        return planetTwo;
      case PlanetType.planet_3:
        return planeThree;
      case PlanetType.dying_planet:
        return dyingPlanet;
      default:
        return planetOne;
    }
  }

  @override
  void render(Canvas canvas) {
    this.currentPlanet.render(canvas);
  }
  void destroyPlanet(){
    isDestroyed = true;
  }
  @override
  void update(double t) {
    if(this.currentPlanet.x > game.screenSize.width - 175){
      direction = false;
    } else if(this.currentPlanet.x < 0){
      direction = true;
    }

    if(!isDestroyed){
      (direction ) ?x += 5 : x -= 5;
    }

    this.currentPlanet.x = x;
    this.currentPlanet.update(t);
    if(type == PlanetType.dying_planet){
      if(dyingPlanet.isDone()){
        game.spawnPlanet();
      }
    }
  }
}

class Planet1 extends SpriteComponent {
  Planet1()
    :super.fromSprite(
    175,
    175,
    Sprite('planet_1.png',
        width: 400,
        height: 400
    )
  );
}

class Planet2 extends SpriteComponent {

  Planet2()
      :super.fromSprite(
      175,
      175,
      Sprite('planet_2.png',
          width: 400,
          height: 400
      )
  );

}

class Planet3 extends SpriteComponent {
  Planet3()
      :super.fromSprite(
      175,
      175,
      Sprite('planet_3.png',
          width: 400,
          height: 400)
  );
}

class DyingPlanet extends AnimationComponent {

  Animation dyingPlanetAnimation;

  DyingPlanet(this.dyingPlanetAnimation)
      : super(
        175.0,
        175.0,
        dyingPlanetAnimation
      );

  bool isDone(){
    return dyingPlanetAnimation.done();
  }
}