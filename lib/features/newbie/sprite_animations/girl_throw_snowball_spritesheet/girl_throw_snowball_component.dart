import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'girl_throw_snowball_spritesheet.dart';

class GirlThrowSnowballComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(GirlThrowSnowballSpriteSheet.imagePath),
      srcSize: GirlThrowSnowballSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: GirlThrowSnowballSpriteSheet.numberOfSprites,
      stepTime: 0.2,
    );
    size = GirlThrowSnowballSpriteSheet.spriteSize * 1.7;
    anchor = Anchor.center;

    await super.onLoad();
  }
}
