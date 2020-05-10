import 'package:shootermultiverse/game/collision/collision_box.dart';

class MissileConfig {
  static double speed = 10;
}

class MissileCollisionBox {
  static final CollisionBox shooting =
      CollisionBox(x: 1.0, y: 10.0, width: 100, height: 100);
}
