import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import 'bird_spritesheet.dart';

class BirdComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  MovementDirection _movementDirection = MovementDirection.walkLeft;
  static const double _animationSpeed = 0.1;
  static const double _movementSpeed = 0.4;

  final Vector2 initialePosition;
  final double _xDeviation = 500;

  BirdComponent({required this.initialePosition});

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _walkLeftAnimation;
    anchor = Anchor.center;
    size = BirdSpriteSheet.spriteSize * 0.3;
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
      image: await gameRef.images.load(BirdSpriteSheet.imagePath),
      srcSize: BirdSpriteSheet.spriteSize,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: BirdSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
      to: BirdSpriteSheet.numberOfSprites,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: BirdSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
      to: BirdSpriteSheet.numberOfSprites,
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
