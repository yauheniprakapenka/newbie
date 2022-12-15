import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'tree_spritesheet.dart';

class TreeSpriteAnimation {
  static const double _animationSpeed = 0.1;

  static Future<SpriteSheet> getSpriteSheet(NewbieGame gameRef) async {
    return SpriteSheet(
      image: await gameRef.images.load(TreeSpriteSheet.imagePath),
      srcSize: TreeSpriteSheet.spriteSize,
    );
  }

  static SpriteAnimation animation(SpriteSheet spriteSheet) {
    return spriteSheet.createAnimation(
      row: TreeSpriteSheet.treeRowIndex,
      stepTime: _animationSpeed,
      to: TreeSpriteSheet.numberOfSprites,
    );
  }
}
