import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'garland_spritesheet.dart';

class GarlandComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 0.6;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _animation;
    anchor = Anchor.center;
    await super.onLoad();
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(GarlandSpriteSheet.imagePath),
      srcSize: GarlandSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: GarlandSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: GarlandSpriteSheet.numberOfSprites,
    );
  }
}
