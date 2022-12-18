import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../core_ui/movement_direction.dart';
import '../game/newbie_game.dart';
import '../sprite_animations/sprite_animations.dart';

class MainDoorToBuildingComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  MainDoorToBuildingComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      final Vector2 elevatorPosition = Vector2(1276.33203125, 509.9141125000001);
      gameRef.newbie.position = elevatorPosition;
      gameRef.newbieMovementState = MovementDirection.idle;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = MovementDirection.idle;
    }
    super.onCollisionEnd(other);
  }
}
