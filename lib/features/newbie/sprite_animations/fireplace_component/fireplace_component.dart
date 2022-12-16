import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'fireplace_spritesheet.dart';

class FireplaceComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 0.4;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = FireplaceSpriteSheet.spriteSize;
    animation = _animation;
    anchor = Anchor.center;
    await super.onLoad();
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(FireplaceSpriteSheet.imagePath),
      srcSize: FireplaceSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: FireplaceSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: FireplaceSpriteSheet.numberOfSprites,
    );
  }
}
