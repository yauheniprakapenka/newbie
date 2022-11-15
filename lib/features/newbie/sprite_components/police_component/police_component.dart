import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

// ignore_for_file: no-magic-number
import '../../game/newbie_game.dart';
import 'police_spritesheet.dart';

class PoliceComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(PoliceSpriteSheet.imagePath),
      srcSize: PoliceSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = PoliceSpriteSheet.spriteSize * 0.5;
    anchor = Anchor.center;

    await super.onLoad();
  }
}
