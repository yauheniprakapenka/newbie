import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'boy_with_stick_spritesheet.dart';

class BoyWithStickComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 0.4;

  BoyWithStickComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = BoyWithStickSpriteSheet.spriteSize;
    animation = _animation;
    anchor = Anchor.center;
    flipHorizontally();
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'Именем короля Генриха, приказываю вам сложить оружие и сдаться!',
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

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(BoyWithStickSpriteSheet.imagePath),
      srcSize: BoyWithStickSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: BoyWithStickSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: BoyWithStickSpriteSheet.numberOfSprites,
    );
  }
}
