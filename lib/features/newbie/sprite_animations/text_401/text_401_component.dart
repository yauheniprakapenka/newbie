import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'text_401_spritesheet.dart';

class Text401Component extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(Text401SpriteSheet.imagePath),
      srcSize: Text401SpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: Text401SpriteSheet.animationRowIndex,
      to: Text401SpriteSheet.numberOfSprites,
      stepTime: 1.3,
    );
    size = Text401SpriteSheet.spriteSize * 0.6;
    anchor = Anchor.center;

    await super.onLoad();
  }
}
