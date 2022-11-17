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

  static const double _speed = 2.5;
  static const double _stepTime = 0.2;
  static const double _relationToSpriteSize = 0.7;
  static const int _desiredNumberOfSpritesInRowForIdleAnimation = 1;
  static const double _sizeMultiplier = 1;

  Vector2 get _componentSize => NewbieSpriteSheet.spriteSize * _sizeMultiplier;

  NewbieComponent() {
    add(
      RectangleHitbox.relative(
        Vector2.all(_relationToSpriteSize),
        parentSize: _componentSize,
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _idle;
    size = _componentSize;
    anchor = Anchor.center;
    debugMode = true;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  void _updateMovement() {
    animation = _idle;
    switch (gameRef.georgeMovementState) {
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
      to: NewbieSpriteSheet.spritesInRow,
    );

    _walkLeft = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goLeftAnimationRowIndex,
      stepTime: _stepTime,
      to: NewbieSpriteSheet.spritesInRow,
    );

    _walkUp = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goUpAnimationRowIndex,
      stepTime: _stepTime,
      to: NewbieSpriteSheet.spritesInRow,
    );

    _walkRight = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goRightAnimationRowIndex,
      stepTime: _stepTime,
      to: NewbieSpriteSheet.spritesInRow,
    );

    _idle = spriteSheet.createAnimation(
      row: NewbieSpriteSheet.goDownAnimationRowIndex,
      stepTime: _stepTime,
      to: _desiredNumberOfSpritesInRowForIdleAnimation,
    );
  }
}
