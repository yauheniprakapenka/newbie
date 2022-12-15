import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'traffic_light_spritesheet.dart';

class TrafficLightComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 2;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    size = TrafficLightSpriteSheet.spriteSize;
    animation = _animation;
    await super.onLoad();
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(TrafficLightSpriteSheet.imagePath),
      srcSize: TrafficLightSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: TrafficLightSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: TrafficLightSpriteSheet.numberOfSprites,
    );
  }
}
