import 'package:shootermultiverse/game/collision/collision_box.dart';

class PlanetConfig {
  static double speed = 10;
}

class PlanetCollisionBox {
  static final CollisionBox rotating =
  CollisionBox(x: 1.0, y: 10.0, width: 100, height: 100);
}
