import 'package:flame/components.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../sprite_animations/blue_boy/blue_boy_component.dart';
import '../../sprite_animations/brown_boy/brown_boy_component.dart';
import '../../sprite_animations/green_girl/green_girl_component.dart';
import '../../sprite_animations/lantern_light/lantern_light_component.dart';
import '../../sprite_animations/orange_boy/orange_boy_component.dart';
import '../../sprite_animations/purple_girl/purple_girl_component.dart';

final List<PositionComponent> conferenceRoomComponents = [
  BlueBoyComponent(
    hasCollision: false,
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4345.9453125, 642.6914562500001),
  OrangeBoyComponent(
    hasCollision: false,
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4342.25390625, 674.23051875000011),
  BrownBoyComponent(
    hasCollision: false,
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4338.625, 583.1406750000001),
  LanternLightComponent()..position = Vector2(4161.62890625, 512.3906750000001),
  LanternLightComponent()..position = Vector2(4169.953125, 539.3398937500001),
  LanternLightComponent()..position = Vector2(4151.9296875, 551.2109875000001),
  LanternLightComponent()..position = Vector2(4348.515625, 755.2852062500001),
  PurpleGirlComponent(
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4324.3203125, 613.11328125),
  GreenGirlComponent(
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4351.0078125, 603.9296875),
  OrangeBoyComponent(
    hasCollision: false,
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4301.43359375, 599.33984375),
  GreenGirlComponent(
    direction: MovementDirection.walkLeft,
  )..position = Vector2(4276.95703125, 595.66015625),
  BrownBoyComponent(
    dialog:
        'Пожелаем ребятам лёгкого старта и продуктивной работы! Надеемся, что среди этих слушателей с горящими глазами есть наши будущие коллеги!',
  )..position = Vector2(4229.9296875, 750.2109375),
];
