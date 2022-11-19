import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'car_police_spritesheet.dart';

class CarPoliceComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
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
    angle = 0.3;
    position = Vector2(452, 1100);

    await super.onLoad();
  }
}
