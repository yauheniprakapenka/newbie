import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'boy_with_stick_spritesheet.dart';

class BoyWithStickComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 0.4;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = BoyWithStickSpriteSheet.spriteSize;
    animation = _animation;
    anchor = Anchor.center;
    flipHorizontally();
    await super.onLoad();
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(BoyWithStickSpriteSheet.imagePath),
      srcSize: BoyWithStickSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: BoyWithStickSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: BoyWithStickSpriteSheet.numberOfSprites,
    );
  }
}
