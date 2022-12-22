import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../../../core_ui/screen.dart';
import '../../game/newbie_game.dart';
import 'newbie_sprite_sheet.dart';

class NewbieComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkDown;
  late final SpriteAnimation _walkLeft;
  late final SpriteAnimation _walkRight;
  late final SpriteAnimation _walkUp;
  late final SpriteAnimation _idle;

  static const double _speed = 13.5;
  static const double _stepTime = 0.2;
  static const int _desiredNumberOfnumberOfSpritesForIdleAnimation = 1;

  Vector2 get _componentSize => NewbieSpriteSheet.spriteSize * 0.85;

  NewbieComponent() {
    add(
      RectangleHitbox(size: Vector2.all(25), anchor: Anchor.center, position: Vector2.all(22)),
    );
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _idle;
    size = _componentSize;

    // debugMode = true;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  void _updateMovement() {
    animation = _idle;
    switch (gameRef.newbieMovementState) {
      case MovementDirection.walkDown:
        if (y < gameRef.mapSize.height - height) {
          if (gameRef.collisionDirection != MovementDirection.walkDown) {
            y += _speed;
            animation = _walkDown;
          }
        }
        break;
      case MovementDirection.walkLeft:
        final bool notReachedLeftScreenEdge = x > kStartXPosition;
        if (notReachedLeftScreenEdge) {
          if (gameRef.collisionDirection != MovementDirection.walkLeft) {
            animation = _walkLeft;
            x -= _speed;
          }
        }
        break;
      case MovementDirection.walkUp:
        if (y > kStartYPosition) {
          if (gameRef.collisionDirection != MovementDirection.walkUp) {
            animation = _walkUp;
            y -= _speed;
          }
        }
        break;
      case MovementDirection.walkRight:
        if (x < gameRef.mapSize.width - width) {
          if (gameRef.collisionDirection != MovementDirection.walkRight) {
            animation = _walkRight;
            x += _speed;
          }
        }
        break;
      default:
        animation = _idle;
    }
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(NewbieSpriteSheet.imagePath),
      srcSize: NewbieSpriteSheet.spriteSize,
    );

    _walkDown = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goDownAnimationRowIndex,
      stepTime: _stepTime,
      to: NewbieSpriteSheet.numberOfSprites,
    );

    _walkLeft = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goLeftAnimationRowIndex,
      stepTime: _stepTime,
      to: NewbieSpriteSheet.numberOfSprites,
    );

    _walkUp = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goUpAnimationRowIndex,
      stepTime: _stepTime,
      to: NewbieSpriteSheet.numberOfSprites,
    );

    _walkRight = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goRightAnimationRowIndex,
      stepTime: _stepTime,
      to: NewbieSpriteSheet.numberOfSprites,
    );

    _idle = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goDownAnimationRowIndex,
      stepTime: _stepTime,
      to: _desiredNumberOfnumberOfSpritesForIdleAnimation,
    );
  }
}
