import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shootermultiverse/game/collision/collision_utils.dart';
import 'package:shootermultiverse/game/missile/missile.dart';
import 'package:shootermultiverse/game/planet/planet.dart';
import 'package:shootermultiverse/game/rocket/rocket.dart';
import 'package:shootermultiverse/game/sound_manager.dart';
import 'package:shootermultiverse/game/space/space.dart';
import 'package:shootermultiverse/game/views/components/bullets_remaining.dart';
import 'package:shootermultiverse/game/views/view.dart';
import 'package:shootermultiverse/game/views/home_view.dart';
import 'package:shootermultiverse/game/views/components/start-button.dart';
import 'package:shootermultiverse/game/views/lost_view.dart';
import 'package:shootermultiverse/game/views/win_view.dart';

enum ShooterGameStatus { playing, waiting, lost, won }

class ShooterGame extends BaseGame {
  View activeView = View.home;
  HomeView homeView;
  StartButton startButton;
  Size screenSize;
  double tileSize;
  Space backGround;
  Rocket rocket;
  Planet planet;
  List<Missile> missiles = List<Missile>();
  bool fireNow = false;
  double fireX;
  double fireY;
  Offset rocketPosition;
  List<PlanetType> planets = List<PlanetType>();
  int firstMissile = 0;
  int bulletRemaining = 5;
  ShooterGameStatus gameStatus = ShooterGameStatus.waiting;
  LostView lostView;
  WinView winView;
  BulletsRemaining bulletsRemainingText;
  ShooterGame() {
    initialize();
  }

  initialize() async {
    resize(await Flame.util.initialDimensions());
//    BGM.play(0);
    planets.addAll(
        [PlanetType.planet_1, PlanetType.planet_2, PlanetType.planet_3]);
    backGround = Space(this);
    rocket = Rocket(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    lostView = LostView(this);
    winView = WinView(this);
    bulletsRemainingText = BulletsRemaining(this);
    spawnPlanet();
  }

  spawnPlanet() {
    print(planets);
    if (planets.isNotEmpty) {
      planet = Planet(this, planets.first);
    } else {
      planet = Planet(this, PlanetType.planet_1);
    }
  }

  @override
  void render(Canvas canvas) {
    backGround.render(canvas);
    missiles.forEach((Missile missile) => missile.render(canvas));
    rocket.render(canvas);
    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.home ||
        activeView == View.lost ||
        activeView == View.won) {
      startButton.render(canvas);
    }
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.won) winView.render(canvas);
    if (activeView == View.playing) bulletsRemainingText.render(canvas);
    planet.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
    rocket.update(t);
    planet.update(t);
    missiles.forEach((Missile missile) => missile.update(t));
    missiles.removeWhere((Missile missile) => missile.isOffScreen);

    final hasCollision =
        missiles.isNotEmpty && checkForCollision(planet, missiles.first);

    if (hasCollision) {
      Flame.audio.play('sfx/explosion.mp3');
      planet.destroyPlanet();
      missiles.remove(missiles.first);
      planets.remove(planets.first);
    }

    if (planets.isEmpty) {
      gameStatus = ShooterGameStatus.won;
      activeView = View.won;
    }

    if (bulletRemaining <= 0 && planets.isNotEmpty && missiles.isEmpty) {
      gameStatus = ShooterGameStatus.won;
      activeView = View.lost;
    }
    print(planets.length);
//    print(bulletRemaining);
//    print(planets.length);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  @override
  void onTap() {
    if (activeView == View.playing) {
      if (firstMissile <= 0) {
        firstMissile++;
      } else {
        fireMissile();
        bulletRemaining -= 1;
      }
    }
  }

  fireMissile() {
    missiles.add(Missile(this, rocketPosition));
  }

  void onDrag(DragUpdateDetails d) {
    rocketPosition = Offset(d.globalPosition.dx, rocketPosition.dy);
    rocket.onDragStart(d);
  }

  @override
  void onTapDown(TapDownDetails details) {
    bool isHandled = false;

    if (!isHandled && startButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        firstMissile = 0;
        if (planets.isEmpty) {
          planets.addAll([PlanetType.planet_2, PlanetType.planet_3]);
        }
        startButton.onTapDown();
        isHandled = true;
      }
    }
  }
}
