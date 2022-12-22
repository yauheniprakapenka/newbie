import 'package:flame/components.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../sprite_animations/ballon/ballon_component.dart';
import '../../sprite_animations/blue_boy/blue_boy_component.dart';
import '../../sprite_animations/brown_boy/brown_boy_component.dart';
import '../../sprite_animations/green_girl/green_girl_component.dart';
import '../../sprite_animations/orange_boy/orange_boy_component.dart';
import '../../sprite_animations/purple_girl/purple_girl_component.dart';

final List<PositionComponent> happyBirthday = [
  BrownBoyComponent(hasCollision: false)..position = Vector2(3617.80078125, 461.85546875),
  OrangeBoyComponent(hasCollision: false)..position = Vector2(3545.4609375, 448.96875),
  BlueBoyComponent(hasCollision: false)..position = Vector2(3574.42578125, 460.12109375),
  PurpleGirlComponent(hasCollision: false)..position = Vector2(3534.1875, 414.3515625),
  PurpleGirlComponent(hasCollision: false, direction: MovementDirection.walkLeft)
    ..position = Vector2(3677.02734375, 426.21484375),
  OrangeBoyComponent(hasCollision: false, direction: MovementDirection.walkLeft)
    ..position = Vector2(3656.3046875, 458.3203125),
  GreenGirlComponent(
    dialog:
        'Дорогая Саша Винникова. Гармонии и тепла внутри себя и с внешним миром. С Днем рождения!',
    direction: MovementDirection.walkLeft,
  )..position = Vector2(3594.53515625, 409.03515625),
  BallonComponent.purple()..position = Vector2(3568.03125, 447.703125),
  BallonComponent.green()..position = Vector2(3543.2265625, 404),
  BallonComponent.red()..position = Vector2(3671, 416.09375),
  BallonComponent.green()..position = Vector2(3652, 447),
];
