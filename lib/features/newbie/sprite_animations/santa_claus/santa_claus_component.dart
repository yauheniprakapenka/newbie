import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'santa_claus_spritesheet.dart';

class SantaClausComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _animation;
  static const double _animationSpeed = 0.6;

  @override
  Future<void> onLoad() async {
    await _createAnimation();
    animation = _animation;
    anchor = Anchor.center;
    size = SantaClausSpriteSheet.spriteSize;
    await super.onLoad();
  }

  Future<void> _createAnimation() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(SantaClausSpriteSheet.imagePath),
      srcSize: SantaClausSpriteSheet.spriteSize,
    );

    _animation = spriteSheet.createAnimation(
      row: SantaClausSpriteSheet.animationRowIndex,
      stepTime: _animationSpeed,
      to: SantaClausSpriteSheet.numberOfSprites,
    );
  }
}
