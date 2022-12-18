import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../../../../core_ui/movement_direction.dart';
import '../../../sprite_animations/sprite_animations.dart';
import '../../newbie_game.dart';

class InfoComponent extends SpriteComponent with HasGameRef<NewbieGame>, CollisionCallbacks {
  final Vector2 _srcSize = Vector2.all(64);
  final String dialog;

  InfoComponent({
    required this.dialog,
  }) {
    add(RectangleHitbox());
  }

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('newbie/sprites/info_sprite.png', srcSize: _srcSize);
    size = _srcSize * 0.4;
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        dialog,
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
