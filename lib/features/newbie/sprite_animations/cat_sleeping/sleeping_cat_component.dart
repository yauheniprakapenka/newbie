import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'sleeping_cat_spritesheet.dart';

class SleepingCatComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  SleepingCatComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(SleepingCatSpriteSheet.imagePath),
      srcSize: SleepingCatSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: SleepingCatSpriteSheet.animationRowIndex,
      to: SleepingCatSpriteSheet.numberOfSprites,
      stepTime: 0.6,
    );
    size = SleepingCatSpriteSheet.spriteSize * 0.37;
    anchor = Anchor.center;

    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'Я правда не знаю как "фвыа яохъйтафша воыфа" попало в продакшн',
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
