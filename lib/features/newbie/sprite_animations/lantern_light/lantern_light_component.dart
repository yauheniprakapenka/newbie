import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'lantern_light_spritesheet.dart';

class LanternLightComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(LanternLightSpriteSheet.imagePath),
      srcSize: LanternLightSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: LanternLightSpriteSheet.numberOfSprites,
      stepTime: 0.5,
    );
    size = LanternLightSpriteSheet.spriteSize;
    anchor = Anchor.center;

    await super.onLoad();
  }
}
