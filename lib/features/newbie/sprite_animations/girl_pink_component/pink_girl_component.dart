import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import 'pink_girl_spritesheet.dart';

class PinkGirlComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkDownAnimation;
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  late final SpriteAnimation _walkUpAnimation;

  static const double _animationSpeed = 0.2;
  static const double _movementSpeed = 0.5;

  MovementDirection _movementDirection = MovementDirection.walkLeft;

  static final Vector2 _initialePosition = Vector2(1550, 1460);

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = PinkGirlSpriteSheet.spriteSize * 0.66;
    animation = _walkLeftAnimation;
    _movementDirection = MovementDirection.walkLeft;
    position = _initialePosition;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(PinkGirlSpriteSheet.imagePath),
      srcSize: PinkGirlSpriteSheet.spriteSize,
    );

    _walkDownAnimation = spriteSheet.createAnimation(
      row: PinkGirlSpriteSheet.walkDownAnimationRowIndex,
      stepTime: _animationSpeed,
      to: PinkGirlSpriteSheet.numberOfSprites,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: PinkGirlSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: PinkGirlSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkUpAnimation = spriteSheet.createAnimation(
      row: PinkGirlSpriteSheet.walkUpAnimationRowIndex,
      stepTime: _animationSpeed,
    );
  }

  void _updateMovement() {
    if (_movementDirection == MovementDirection.walkLeft) {
      if (x > 1380) {
        x -= _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkUp;
        animation = _walkUpAnimation;
      }
      return;
    }

    if (_movementDirection == MovementDirection.walkRight) {
      if (x < _initialePosition.x) {
        x += _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkDown;
        animation = _walkDownAnimation;
      }
      return;
    }

    if (_movementDirection == MovementDirection.walkDown) {
      if (y < _initialePosition.y) {
        y += _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkLeft;
        animation = _walkLeftAnimation;
      }
      return;
    }

    if (_movementDirection == MovementDirection.walkUp) {
      if (y > 1440) {
        y -= _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkRight;
        animation = _walkRightAnimation;
      }
      return;
    }

    throw Exception('Unimplemented movement direction $_movementDirection');
  }
}
