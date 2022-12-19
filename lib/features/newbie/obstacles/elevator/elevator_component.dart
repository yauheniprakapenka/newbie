import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../../sprite_animations/sprite_animations.dart';

class ElevatorComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  ElevatorComponent() {
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      final Vector2 mainDoorPosition = Vector2(1129.87109375,1215.6172375);
      gameRef.newbie.position = mainDoorPosition;
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
