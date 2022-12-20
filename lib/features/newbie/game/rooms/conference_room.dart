import 'package:flame/components.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../sprite_animations/blue_boy/blue_boy_component.dart';
import '../../sprite_animations/brown_boy/brown_boy_component.dart';
import '../../sprite_animations/lantern_light/lantern_light_component.dart';
import '../../sprite_animations/orange_boy/orange_boy_component.dart';

final List<PositionComponent> conferenceRoomComponents = [
  BlueBoyComponent(
    respondToCollision: false,
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4345.9453125, 642.6914562500001),
  OrangeBoyComponent(
    respondToCollision: false,
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4342.25390625, 674.23051875000011),
  BrownBoyComponent(
    respondToCollision: false,
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4338.625, 583.1406750000001),
  LanternLightComponent()..position = Vector2(4161.62890625, 512.3906750000001),
  LanternLightComponent()..position = Vector2(4169.953125, 539.3398937500001),
  LanternLightComponent()..position = Vector2(4151.9296875, 551.2109875000001),
  LanternLightComponent()..position = Vector2(4348.515625, 755.2852062500001),
];
