import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'blue_boy_spritesheet.dart';

class BlueBoyComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  final MovementDirection? direction;
  final String dialog;
  final bool respondToCollision;

  BlueBoyComponent({
    this.dialog = '',
    this.direction,
    this.respondToCollision = true,
  }) {
    add(RectangleHitbox());
  }
  
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(BlueBoySpriteSheet.imagePath),
      srcSize: BlueBoySpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: BlueBoySpriteSheet.numberOfSprites,
      stepTime: 0.4,
    );
    size = BlueBoySpriteSheet.spriteSize / 2.3;
    anchor = Anchor.center;

    if (direction == MovementDirection.walkLeft) {
      flipHorizontally();
    }

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (respondToCollision) {
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
    if (respondToCollision) {
      if (other is NewbieComponent) {
        gameRef.collisionDirection = MovementDirection.idle;
      }
    }
    super.onCollisionEnd(other);
  }
}
