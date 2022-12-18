import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'brown_boy_spritesheet.dart';

class BrownBoyComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  final String dialog;
  final MovementDirection? direction;

  BrownBoyComponent({
    required this.dialog,
    this.direction,
  }) {
    add(RectangleHitbox());
  }
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(BrownBoySpriteSheet.imagePath),
      srcSize: BrownBoySpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: BrownBoySpriteSheet.numberOfSprites,
      stepTime: 0.4,
    );
    size = BrownBoySpriteSheet.spriteSize / 2.3;
    anchor = Anchor.center;

    if (direction == MovementDirection.walkLeft) {
      flipHorizontally();
    }

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
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
