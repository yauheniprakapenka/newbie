import 'package:flame/components.dart';

import '../../sprite_animations/fireplace_component/fireplace_component.dart';
import '../../sprite_animations/garland/garland_component.dart';
import '../../sprite_animations/garland/garland_spritesheet.dart';

final List<SpriteAnimationComponent> room401Components = [
  FireplaceComponent()..position = Vector2(548.94921875, 700.33203125),
  GarlandComponent()
    ..position = Vector2(472.12890625, 690.8671875)
    ..size = GarlandSpriteSheet.spriteSize * 0.5,
];
