import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

// ignore_for_file: no-magic-number
import '../../game/newbie_game.dart';
import 'ambulance_spritesheet.dart';

class AmbulanceComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(AmbulanceSpriteSheet.imagePath),
      srcSize: AmbulanceSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = AmbulanceSpriteSheet.spriteSize * 0.4;
    anchor = Anchor.center;

    await super.onLoad();
  }
}
