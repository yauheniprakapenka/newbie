import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import 'rabbit_spritesheet.dart';

class RabbitComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  MovementDirection _movementDirection = MovementDirection.walkLeft;
  static const double _animationSpeed = 0.13;
  static const double _movementSpeed = 0.14;

  final Vector2 initialePosition;
  final double _xDeviation = 50;

  RabbitComponent({required this.initialePosition});

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _walkLeftAnimation;
    anchor = Anchor.center;
    size = RabbitSpriteSheet.spriteSize * 0.7;
    position = initialePosition;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(RabbitSpriteSheet.imagePath),
      srcSize: RabbitSpriteSheet.spriteSize,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: RabbitSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
      to: RabbitSpriteSheet.numberOfSprites,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: RabbitSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
      to: RabbitSpriteSheet.numberOfSprites,
    );
  }

  void _updateMovement() {
    if (_movementDirection == MovementDirection.walkLeft) {
      if (x > initialePosition.x - _xDeviation) {
        x -= _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkRight;
        animation = _walkRightAnimation;
      }
      return;
    }

    if (_movementDirection == MovementDirection.walkRight) {
      if (x < initialePosition.x + _xDeviation) {
        x += _movementSpeed;
      } else {
        _movementDirection = MovementDirection.walkLeft;
        animation = _walkLeftAnimation;
      }
      return;
    }

    throw Exception('Unimplemented movement direction $_movementDirection');
  }
}
