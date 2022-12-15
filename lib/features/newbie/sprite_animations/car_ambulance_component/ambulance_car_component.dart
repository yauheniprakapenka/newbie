import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'ambulance_car_spritesheet.dart';

class AmbulanceCarComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(AmbulanceCarSpriteSheet.imagePath),
      srcSize: AmbulanceCarSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = AmbulanceCarSpriteSheet.spriteSize * 0.4;
    anchor = Anchor.center;
    angle = -0.2;

    await super.onLoad();
  }
}
