import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'purple_girl_spritesheet.dart';

class PurpleGirlComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  final String dialog;
  final MovementDirection? direction;
  final bool hasCollision;

  PurpleGirlComponent({
    this.dialog = '',
    this.direction,
    this.hasCollision = true,
  }) {
    add(RectangleHitbox());
  }
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(PurpleGirlSpriteSheet.imagePath),
      srcSize: PurpleGirlSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: PurpleGirlSpriteSheet.numberOfSprites,
      stepTime: 0.4,
    );
    size = PurpleGirlSpriteSheet.spriteSize * 0.5;
    anchor = Anchor.center;

    if (direction == MovementDirection.walkLeft) {
      flipHorizontally();
    }

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (hasCollision) {
      if (other is NewbieComponent) {
        gameRef.collisionDirection = gameRef.newbieMovementState;
        gameRef.showDialogByPosition(
          dialog,
          position - Vector2(0, 44),
        );
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (hasCollision) {
      if (other is NewbieComponent) {
        gameRef.collisionDirection = MovementDirection.idle;
      }
    }
    super.onCollisionEnd(other);
  }
}
