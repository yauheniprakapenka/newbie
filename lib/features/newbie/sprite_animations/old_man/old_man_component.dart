import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'old_man_spritesheet.dart';

class OldManComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  OldManComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(OldManSpriteSheet.imagePath),
      srcSize: OldManSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: OldManSpriteSheet.numberOfSprites,
      stepTime: 0.9,
    );
    size = OldManSpriteSheet.spriteSize * 0.57;
    anchor = Anchor.center;

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'А ведь по молодости я тоже занимался коньками',
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
