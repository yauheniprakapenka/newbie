import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../core_ui/movement_direction.dart';
import '../game/newbie_game.dart';
import '../sprite_animations/newbie_component/newbie_component.dart';

class CocaColaComponent extends SpriteComponent with CollisionCallbacks, HasGameRef<NewbieGame> {
  CocaColaComponent() {
    add(RectangleHitbox());
  }
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(CocaColaSprite.path);
    size = CocaColaSprite.srcSize * 0.3;
    anchor = Anchor.center;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'Веселье приносит и вкус бодрящий Праздника вкус всегда настоящий',
        position - Vector2(0, 44),
      );
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

class CocaColaSprite {
  static const String path = 'newbie/sprites/coca_cola.png';
  static final Vector2 srcSize = Vector2(32.0, 96.0);
}
