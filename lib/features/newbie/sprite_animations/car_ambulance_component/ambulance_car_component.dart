import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'ambulance_car_spritesheet.dart';

class AmbulanceCarComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  AmbulanceCarComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(AmbulanceCarSpriteSheet.imagePath),
      srcSize: AmbulanceCarSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = AmbulanceCarSpriteSheet.spriteSize * 0.4;
    anchor = Anchor.center;
    angle = -0.2;

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'Такой волнительный день. У кого-нибудь может закружиться голова.',
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
