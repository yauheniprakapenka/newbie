import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../game/newbie_game.dart';
import '../newbie_component/newbie_component.dart';
import 'figure_skates_girl_spritesheet.dart';

class FigureSkatesGirlComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  late final SpriteAnimation _walkLeftAnimation;
  late final SpriteAnimation _walkRightAnimation;
  
  MovementDirection _movementDirection = MovementDirection.walkLeft;

  static const double _animationSpeed = 0.5;
  static const double _movementSpeed = 0.5;

  final Vector2 initialePosition;
  final double _xDeviation = 170;

  FigureSkatesGirlComponent({required this.initialePosition}) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _walkLeftAnimation;
    anchor = Anchor.center;
    size = FigureSkatesGirlSpriteSheet.spriteSize * 0.7;
    position = initialePosition;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = gameRef.newbieMovementState;
      gameRef.showDialogByPosition(
        'I believe I can fly!',
        position - Vector2(0, 44),
      );
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is NewbieComponent) {
      gameRef.collisionDirection = MovementDirection.idle;
    }
    super.onCollisionEnd(other);
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(FigureSkatesGirlSpriteSheet.imagePath),
      srcSize: FigureSkatesGirlSpriteSheet.spriteSize,
    );

    _walkLeftAnimation = spriteSheet.createAnimation(
      row: FigureSkatesGirlSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
      to: FigureSkatesGirlSpriteSheet.numberOfSprites,
    );

    _walkRightAnimation = spriteSheet.createAnimation(
      row: FigureSkatesGirlSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
      to: FigureSkatesGirlSpriteSheet.numberOfSprites,
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
