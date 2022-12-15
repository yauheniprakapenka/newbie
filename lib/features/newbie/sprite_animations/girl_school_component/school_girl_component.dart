import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'school_girl_spritesheet.dart';

class SchoolGirlComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkDownAnimation;
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  late final SpriteAnimation _walkUpAnimation;
  late final SpriteAnimation _idleAnimation;

  static const double _animationSpeed = 0.16;
  static const double _movementSpeed = 0.4;

  final Vector2 _initialePosition = Vector2(386, 310);
  int _scriptNumber = 0;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = SchoolGirlSpriteSheet.spriteSize * 0.8;
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
      image: await gameRef.images.load(SchoolGirlSpriteSheet.imagePath),
      srcSize: SchoolGirlSpriteSheet.spriteSize,
    );

    _walkDownAnimation = spriteSheet.createAnimation(
      row: SchoolGirlSpriteSheet.walkDownAnimationRowIndex,
      stepTime: _animationSpeed,
      to: SchoolGirlSpriteSheet.numberOfSprites,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: SchoolGirlSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: SchoolGirlSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkUpAnimation = spriteSheet.createAnimation(
      row: SchoolGirlSpriteSheet.walkUpAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _idleAnimation = SpriteAnimation.spriteList([spriteSheet.getSprite(3, 1)], stepTime: 1);
  }

  void _updateMovement() {
    switch (_scriptNumber) {
      case 0:
        if (y < 496) {
          y += _movementSpeed;
          animation = _walkDownAnimation;
        } else {
          animation = _walkRightAnimation;
          _scriptNumber = 1;
        }
        break;
      case 1:
        if (x < 575) {
          x += _movementSpeed;
        } else {
          animation = _walkUpAnimation;
          _scriptNumber = 2;
        }
        break;
      case 2:
        if (y > 370) {
          y -= _movementSpeed;
        } else {
          animation = _walkDownAnimation;
          _scriptNumber = 3;
        }
        break;
      case 3:
        if (y < 496) {
          y += _movementSpeed;
        } else {
          animation = _walkLeftAnimation;
          _scriptNumber = 4;
        }
        break;
      case 4:
        if (x > _initialePosition.x) {
          x -= _movementSpeed;
        } else {
          animation = _walkUpAnimation;
          _scriptNumber = 5;
        }
        break;
      case 5:
        if (y > _initialePosition.y) {
          y -= _movementSpeed;
        } else {
          _scriptNumber = 6;
        }
        break;
      case 6:
        animation = _idleAnimation;
        Future.delayed(const Duration(seconds: 2)).then((value) {
          _scriptNumber = 0;
          animation = _walkDownAnimation;
        });
        break;
    }
  }
}
