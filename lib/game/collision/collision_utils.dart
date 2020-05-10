import 'package:shootermultiverse/game/collision/collision_box.dart';
import 'package:shootermultiverse/game/missile/config.dart';
import 'package:shootermultiverse/game/missile/missile.dart';
import 'package:shootermultiverse/game/planet/config.dart';
import 'package:shootermultiverse/game/planet/planet.dart';

bool checkForCollision(Planet planet, Missile missile) {

  final planetBox = CollisionBox(
    x: planet.x + 1,
    y: planet.y + 1,
    width: planet.planetRect.width - 2,
    height: planet.planetRect.height - 2,
  );

  final missileBox = CollisionBox(
    x: missile.missileRect.left + 1,
    y: missile.missileRect.top + 1,
    width: missile.missileRect.width - 2,
    height: missile.missileRect.height - 2,
  );

  if (boxCompare(planetBox, missileBox)) {


//    final CollisionBox planetCollisionBox = PlanetCollisionBox.rotating;
//    final CollisionBox missileCollisionBox = MissileCollisionBox.shooting;
    bool crashed = true;
//
//    final adjPlanetBox =
//        createAdjustedCollisionBox(planetCollisionBox, planetBox);
//    final adjMissileBox =
//        createAdjustedCollisionBox(missileCollisionBox, missileBox);
//
//    crashed = crashed || boxCompare(adjPlanetBox, adjMissileBox);



    print(crashed);

    return crashed;
  }
  return false;
}

bool boxCompare(CollisionBox planetBox, CollisionBox missileBox) {
  final double missileX = missileBox.x;
  final double missileY = missileBox.y;


//  print('planet top: ${planetBox.y}');
//  print('planet height: ${planetBox.height}');
//  print(missileY);
//  print(planetBox.x < missileX + missileBox.width &&
//      planetBox.y + planetBox.height > missileY &&
//      planetBox.x + planetBox.width > missileX);
//  print(planetBox.x < missileX + missileBox.width);
//  print(planetBox.y + planetBox.height > missileY);
//  print(planetBox.x + planetBox.width > missileX);
//
//  print('loop end');

  //detecting collision
  return planetBox.x < missileX + missileBox.width &&
      planetBox.y + planetBox.height > missileY &&
      planetBox.x + planetBox.width > missileX;
}

CollisionBox createAdjustedCollisionBox(
    CollisionBox box, CollisionBox adjustment) {
  return CollisionBox(
    x: box.x + adjustment.x,
    y: box.y + adjustment.y,
    width: box.width,
    height: box.height,
  );
}
