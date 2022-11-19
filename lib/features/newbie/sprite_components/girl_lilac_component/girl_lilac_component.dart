import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'girl_lilac_sprite_animation.dart';
import 'girl_lilac_spritesheet.dart';

class GirlLilacComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkDownAnimation;
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  late final SpriteAnimation _walkUpAnimation;
  late final SpriteAnimation _idleAnimation;

  static const double _movementSpeed = 0.4;
  static const Duration _pictureViewingTime = Duration(seconds: 4);

  final Vector2 _initialePosition = Vector2(1180, 600);
  int _scriptNumber = 0;
  bool _needToRunFuture = true;

  @override
  Future<void> onLoad() async {
    await _createSpriteAnimations();
    size = GirlLilacSpriteSheet.spriteSize * 0.8;
    position = _initialePosition;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  Future<void> _createSpriteAnimations() async {
    final SpriteSheet spriteSheet = await GirlLilacSpriteAnimation.getSpriteSheet(gameRef);
    _walkDownAnimation = GirlLilacSpriteAnimation.walkDownAnimation(spriteSheet);
    _walkLeftAnimation = GirlLilacSpriteAnimation.walkLeftAnimation(spriteSheet);
    _walkRightAnimation = GirlLilacSpriteAnimation.walkRightAnimation(spriteSheet);
    _walkUpAnimation = GirlLilacSpriteAnimation.walkUpAnimation(spriteSheet);
    _idleAnimation = GirlLilacSpriteAnimation.idleAnimation(spriteSheet);
  }

  void _updateMovement() {
    switch (_scriptNumber) {
      case 0:
        animation = _idleAnimation;
        if (_needToRunFuture) {
          _needToRunFuture = false;
          Future.delayed(_pictureViewingTime).then((value) {
            _scriptNumber = 1;
            animation = _walkDownAnimation;
          });
        }
        break;
      case 1:
        if (y < 620) {
          y += _movementSpeed;
        } else {
          animation = _walkLeftAnimation;
          _scriptNumber = 2;
        }
        break;
      case 2:
        if (x > 765) {
          x -= _movementSpeed;
        } else {
          animation = _walkUpAnimation;
          _scriptNumber = 3;
        }
        break;
      case 3:
        if (y > _initialePosition.y) {
          y -= _movementSpeed;
        } else {
          animation = _idleAnimation;
          _scriptNumber = 4;
          _needToRunFuture = true;
        }
        break;
      case 4:
        if (_needToRunFuture) {
          _needToRunFuture = false;
          Future.delayed(_pictureViewingTime).then((value) {
            _scriptNumber = 5;
            animation = _walkDownAnimation;
          });
        }
        break;
      case 5:
        if (y < 620) {
          y += _movementSpeed;
        } else {
          animation = _walkRightAnimation;
          _scriptNumber = 6;
        }
        break;
      case 6:
        if (x < _initialePosition.x) {
          x += _movementSpeed;
        } else {
          animation = _walkLeftAnimation;
          _scriptNumber = 7;
        }
        break;
      case 7:
        if (y > _initialePosition.y) {
          y -= _movementSpeed;
        } else {
          animation = _idleAnimation;
          _scriptNumber = 0;
          _needToRunFuture = true;
        }
        break;
    }
  }
}
