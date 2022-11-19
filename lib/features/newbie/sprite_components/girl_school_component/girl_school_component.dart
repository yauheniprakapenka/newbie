import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'girl_school_spritesheet.dart';

class GirlSchoolComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkDownAnimation;
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  late final SpriteAnimation _walkUpAnimation;
  late final SpriteAnimation _idleAnimation;

  static const double _animationSpeed = 0.16;
  static const double _movementSpeed = 0.4;

  final Vector2 _initialePosition = Vector2(586, 340);
  int _scriptNumber = 0;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = GirlSchoolSpriteSheet.spriteSize * 0.8;
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
      image: await gameRef.images.load(GirlSchoolSpriteSheet.imagePath),
      srcSize: GirlSchoolSpriteSheet.spriteSize,
    );

    _walkDownAnimation = spriteSheet.createAnimation(
      row: GirlSchoolSpriteSheet.walkDownAnimationRowIndex,
      stepTime: _animationSpeed,
      to: GirlSchoolSpriteSheet.spritesInRow,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: GirlSchoolSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: GirlSchoolSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _walkUpAnimation = spriteSheet.createAnimation(
      row: GirlSchoolSpriteSheet.walkUpAnimationRowIndex,
      stepTime: _animationSpeed,
    );

    _idleAnimation = SpriteAnimation.spriteList([spriteSheet.getSprite(3, 1)], stepTime: 1);
  }

  void _updateMovement() {
    switch (_scriptNumber) {
      case 0:
        if (y < 526) {
          y += _movementSpeed;
          animation = _walkDownAnimation;
        } else {
          animation = _walkRightAnimation;
          _scriptNumber = 1;
        }
        break;
      case 1:
        if (x < 775) {
          x += _movementSpeed;
        } else {
          animation = _walkUpAnimation;
          _scriptNumber = 2;
        }
        break;
      case 2:
        if (y > 400) {
          y -= _movementSpeed;
        } else {
          animation = _walkDownAnimation;
          _scriptNumber = 3;
        }
        break;
      case 3:
        if (y < 526) {
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
