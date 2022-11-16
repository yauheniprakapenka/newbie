import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../../../../core_ui/movement_state.dart';
import '../../game/newbie_game.dart';
import 'girl_pink_idle_timer.dart';
import 'girl_pink_spritesheet.dart';

class GirlPinkComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;

  static const double _movementSpeed = 0.7;

  int _movementState = kWalkLeft;
  final GirlPinkIdleTimer _idleMovementStateTimer = GirlPinkIdleTimer();

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = GirlPinkSpriteSheet.spriteSize * 0.8;
    animation = _walkLeftAnimation;
    _movementState = kWalkLeft;
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

    _idleAnimation = spriteSheet.createAnimation(
      row: GirlPinkSpriteSheet.walkDownAnimationRowIndex,
      stepTime: 0.4,
      to: GirlPinkSpriteSheet.spritesInRow,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: GirlPinkSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: 0.2,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: GirlPinkSpriteSheet.walkRightAnimationRowIndex,
      stepTime: 0.2,
    );
  }

  void _updateMovement() {
    if (_movementState == kIdle) {
      if (_idleMovementStateTimer.isFinished) {
        _movementState = kWalkRight;
        _idleMovementStateTimer.reset();
        animation = _walkRightAnimation;
      }
      return;
    }

    if (_movementState == kWalkRight) {
      if (x < 1750) {
        x += _movementSpeed;
      } else {
        _movementState = kWalkLeft;
        animation = _walkLeftAnimation;
      }
      return;
    }

    if (_movementState == kWalkLeft) {
      if (x > 1600) {
        x -= _movementSpeed;
      } else {
        _movementState = kIdle;
        animation = _idleAnimation;
        _idleMovementStateTimer.start();
      }
      return;
    }
  }
}
