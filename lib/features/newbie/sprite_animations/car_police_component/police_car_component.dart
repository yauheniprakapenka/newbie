import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'police_car_spritesheet.dart';

class PoliceCarComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  PoliceCarComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(PoliceCarSpriteSheet.imagePath),
      srcSize: PoliceCarSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = PoliceCarSpriteSheet.spriteSize * 0.5;
    anchor = Anchor.center;
    angle = 0.3;

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'Проходит конкурс украшения кабинетов в офисе и дома. Сохраняйте спокойствие.',
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
