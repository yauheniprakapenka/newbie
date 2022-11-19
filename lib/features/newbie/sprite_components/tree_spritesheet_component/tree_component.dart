import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'tree_sprite_animation.dart';
import 'tree_spritesheet.dart';

class TreeComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = await TreeSpriteAnimation.getSpriteSheet(gameRef);
    animation = TreeSpriteAnimation.animation(spriteSheet);
    size = TreeSpriteSheet.spriteSize;
    anchor = Anchor.center;
    await super.onLoad();
  }
}
