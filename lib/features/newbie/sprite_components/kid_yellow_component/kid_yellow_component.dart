import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'kid_yellow_spritesheet.dart';

class KidYellowComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(KidYellowSpriteSheet.imagePath),
      srcSize: KidYellowSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: KidYellowSpriteSheet.spritesInRow,
      stepTime: 0.2,
    );

    size = KidYellowSpriteSheet.spriteSize;
    anchor = Anchor.center;

    await super.onLoad();
  }
}
