import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'santa_claus_spritesheet.dart';

class SantaClausComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 0.6;

  SantaClausComponent() {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _animation;
    anchor = Anchor.center;
    size = SantaClausSpriteSheet.spriteSize;
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'Хоу-хоу-хоу! Ты хорошо себя вел в этом году?',
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
      image: await gameRef.images.load(SantaClausSpriteSheet.imagePath),
      srcSize: SantaClausSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: SantaClausSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: SantaClausSpriteSheet.numberOfSprites,
    );
  }
}
