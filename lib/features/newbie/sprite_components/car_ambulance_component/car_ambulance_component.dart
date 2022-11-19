import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'car_ambulance_spritesheet.dart';

class CarAmbulanceComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(CarAmbulanceSpriteSheet.imagePath),
      srcSize: CarAmbulanceSpriteSheet.spriteSize,
    );

    animation = spriteSheet.createAnimation(
      row: 0,
      to: 3,
      stepTime: 0.3,
    );

    size = CarAmbulanceSpriteSheet.spriteSize * 0.4;
    anchor = Anchor.center;
    position = Vector2(452, 1000);
    angle = -0.2;

    await super.onLoad();
  }
}
