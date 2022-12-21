import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'kid_yellow_spritesheet.dart';

class KidYellowComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  KidYellowComponent() {
    add(RectangleHitbox());
  }
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(KidYellowSpriteSheet.imagePath),
      srcSize: KidYellowSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: KidYellowSpriteSheet.numberOfSprites,
      stepTime: 0.2,
    );
    size = KidYellowSpriteSheet.spriteSize;
    anchor = Anchor.center;

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'Почему вакансии айтишников звучат как случайный набор английских слов типа нам нужен junior mid level lead frontend backend back space chicken tikka masala разработчик на полный рабочий день?',
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
