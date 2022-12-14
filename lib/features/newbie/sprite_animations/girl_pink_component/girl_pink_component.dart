import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import 'girl_pink_spritesheet.dart';

class PinkGirlComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkDownAnimation;
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  late final SpriteAnimation _walkUpAnimation;

  static const double _animationSpeed = 0.2;
  static const double _movementSpeed = 0.5;

  MovementDirection _movementDirection = MovementDirection.walkLeft;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = GirlPinkSpriteSheet.spriteSize * 0.8;
    animation = _walkLeftAnimation;
    _movementDirection = MovementDirection.walkLeft;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(GirlPinkSpriteSheet.imagePath),
      srcSize: GirlPinkSpriteSheet.spriteSize,
    );

    _walkDownAnimation = spriteSheet.createAnimation(
      row: GirlPinkSpriteSheet.walkDownAnimationRowIndex,
      stepTime: _animationSpeed,
      to: GirlPinkSpriteSheet.spritesInRow,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: GirlPinkSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: GirlPinkSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkUpAnimation = spriteSheet.createAnimation(
      row: GirlPinkSpriteSheet.walkUpAnimationRowIndex,
      stepTime: _animationSpeed,
    );
  }

  void _updateMovement() {
    if (_movementDirection == MovementDirection.walkLeft) {
      if (x > 1580) {
        x -= _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkUp;
        animation = _walkUpAnimation;
      }
      return;
    }

    if (_movementDirection == MovementDirection.walkRight) {
      if (x < 1750) {
        x += _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkDown;
        animation = _walkDownAnimation;
      }
      return;
    }

    if (_movementDirection == MovementDirection.walkDown) {
      if (y < 1490) {
        y += _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkLeft;
        animation = _walkLeftAnimation;
      }
      return;
    }

    if (_movementDirection == MovementDirection.walkUp) {
      if (y > 1470) {
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
