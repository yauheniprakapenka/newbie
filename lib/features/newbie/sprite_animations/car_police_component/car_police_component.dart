import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'car_police_spritesheet.dart';

class PoliceCarComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(CarPoliceSpriteSheet.imagePath),
      srcSize: CarPoliceSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = CarPoliceSpriteSheet.spriteSize * 0.5;
    anchor = Anchor.center;
    angle = 0.3;

    await super.onLoad();
  }
}
