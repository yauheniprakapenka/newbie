import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../newbie_game.dart';

class JavaImageComponent extends SpriteComponent with HasGameRef<NewbieGame>, CollisionCallbacks {
  final Vector2 _srcSize = Vector2.all(160);

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('newbie/sprites/java_image.png', srcSize: _srcSize);
    size = _srcSize * 0.3;
    anchor = Anchor.center;
    return super.onLoad();
  }
}
