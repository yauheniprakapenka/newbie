import 'package:flame/components.dart';

import '../../game/newbie_game.dart';

class FloorIndicatorComponent extends SpriteComponent with HasGameRef<NewbieGame> {
  final bool isActive;

  FloorIndicatorComponent({required this.isActive});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(
      isActive ? FloorIndicatorSprite.activeSpritePath : FloorIndicatorSprite.notActiveSpritePath,
    );
    size = FloorIndicatorSprite.srcSize * 0.05;
    anchor = Anchor.center;
  }
}

class FloorIndicatorSprite {
  static const String _baseUrl = 'newbie/sprites/buttons';
  static const String activeSpritePath = '$_baseUrl/button_green_blank.png';
  static const String notActiveSpritePath = '$_baseUrl/button_grey_blank.png';
  static final Vector2 srcSize = Vector2(146.0, 148.0);
}
