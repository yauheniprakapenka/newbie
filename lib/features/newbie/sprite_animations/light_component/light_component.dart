import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'light_spritesheet.dart';

class LightComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 2;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = LightSpriteSheet.spriteSize;
    animation = _animation;
    anchor = Anchor.center;
    await super.onLoad();
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(LightSpriteSheet.imagePath),
      srcSize: LightSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: LightSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: LightSpriteSheet.numberOfSprites,
    );
  }
}
