import 'package:flame/components.dart';

import '../game/newbie_game.dart';

class SnowFlakeComponent extends SpriteComponent with HasGameRef<NewbieGame> {
  static const double _room401TopY = 694;
  static const double _room401BottomY = 897;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(SnowflakeSprite.path);
    size = SnowflakeSprite.srcSize * 0.33;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  void _updateMovement() {
    y += 0.7;
    if (y > _room401BottomY) {
      y = _room401TopY;
    }
  }
}

class SnowflakeSprite {
  static const String path = 'newbie/sprites/snowflake.png';
  static final Vector2 srcSize = Vector2(146.0, 148.0);
}
