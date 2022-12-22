import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'ballon_spritesheet.dart';

class BallonComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  final BallonColor ballonColor;

  static const double _animationSpeed = 0.5;

  late final SpriteAnimation _greenAnimation;
  late final SpriteAnimation _redAnimation;
  late final SpriteAnimation _purpleAnimation;

  BallonComponent({
    required this.ballonColor,
  });

  factory BallonComponent.green() {
    return BallonComponent(ballonColor: BallonColor.green);
  }

  factory BallonComponent.red() {
    return BallonComponent(ballonColor: BallonColor.red);
  }

  factory BallonComponent.purple() {
    return BallonComponent(ballonColor: BallonColor.purple);
  }

  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(BallonSpriteSheet.imagePath),
      srcSize: BallonSpriteSheet.spriteSize,
    );

    _greenAnimation = spriteSheet.createAnimation(
      row: BallonSpriteSheet.greenRowIndex,
      stepTime: _animationSpeed,
      to: BallonSpriteSheet.numberOfSprites,
    );

    _redAnimation = spriteSheet.createAnimation(
      row: BallonSpriteSheet.redRowIndex,
      stepTime: _animationSpeed,
      to: BallonSpriteSheet.numberOfSprites,
    );

    _purpleAnimation = spriteSheet.createAnimation(
      row: BallonSpriteSheet.purpleRowIndex,
      stepTime: _animationSpeed,
      to: BallonSpriteSheet.numberOfSprites,
    );

    switch (ballonColor) {
      case BallonColor.green:
        animation = _greenAnimation;
        break;
      case BallonColor.purple:
        animation = _purpleAnimation;
        break;
      case BallonColor.red:
        animation = _redAnimation;
        break;
    }

    size = BallonSpriteSheet.spriteSize * 1.2;
    anchor = Anchor.center;

    await super.onLoad();
  }
}

enum BallonColor {
  green,
  red,
  purple,
}
