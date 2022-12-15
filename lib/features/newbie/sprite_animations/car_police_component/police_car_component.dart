import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'police_car_spritesheet.dart';

class PoliceCarComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(PoliceCarSpriteSheet.imagePath),
      srcSize: PoliceCarSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = PoliceCarSpriteSheet.spriteSize * 0.5;
    anchor = Anchor.center;
    angle = 0.3;

    await super.onLoad();
  }
}
