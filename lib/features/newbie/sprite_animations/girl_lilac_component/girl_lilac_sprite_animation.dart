import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'girl_lilac_spritesheet.dart';

class GirlLilacSpriteAnimation {
  static const double _animationSpeed = 0.16;

  static Future<SpriteSheet> getSpriteSheet(NewbieGame gameRef) async {
    return SpriteSheet(
      image: await gameRef.images.load(GirlLilacSpriteSheet.imagePath),
      srcSize: GirlLilacSpriteSheet.spriteSize,
    );
  }

  static SpriteAnimation walkDownAnimation(SpriteSheet spriteSheet) {
    return spriteSheet.createAnimation(
      row: GirlLilacSpriteSheet.walkDownAnimationRowIndex,
      stepTime: _animationSpeed,
      to: GirlLilacSpriteSheet.spritesInRow,
    );
  }

  static SpriteAnimation walkLeftAnimation(SpriteSheet spriteSheet) {
    return spriteSheet.createAnimation(
      row: GirlLilacSpriteSheet.walkLeftAnimationRowIndex,
      stepTime: _animationSpeed,
      to: GirlLilacSpriteSheet.spritesInRow,
    );
  }

  static SpriteAnimation walkRightAnimation(SpriteSheet spriteSheet) {
    return spriteSheet.createAnimation(
      row: GirlLilacSpriteSheet.walkRightAnimationRowIndex,
      stepTime: _animationSpeed,
      to: GirlLilacSpriteSheet.spritesInRow,
    );
  }

  static SpriteAnimation walkUpAnimation(SpriteSheet spriteSheet) {
    return spriteSheet.createAnimation(
      row: GirlLilacSpriteSheet.walkUpAnimationRowIndex,
      stepTime: _animationSpeed,
      to: GirlLilacSpriteSheet.spritesInRow,
    );
  }

  static SpriteAnimation idleAnimation(SpriteSheet spriteSheet) {
    return SpriteAnimation.spriteList([spriteSheet.getSprite(3, 1)], stepTime: 1);
  }
}
