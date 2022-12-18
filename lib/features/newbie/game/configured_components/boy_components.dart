import 'package:flame/components.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../sprite_animations/blue_boy/blue_boy_component.dart';
import '../../sprite_animations/brown_boy/brown_boy_component.dart';
import '../../sprite_animations/orange_boy/orange_boy_component.dart';

final List<SpriteAnimationComponent> getBoyComponents = [
  OrangeBoyComponent(dialog: 'Делаю как на андроид')..position = Vector2(357.2578125, 865.40625),
  OrangeBoyComponent(dialog: 'Не работает принтер в галерее?')
    ..position = Vector2(3734.3359375, 773.08203125),
  BrownBoyComponent(
    dialog: 'Dear Sirs and Madams, best regards',
    direction: MovementDirection.walkLeft,
  )..position = Vector2(3812.828125, 725.328125),
  BrownBoyComponent(
    dialog: 'Выписывай',
    direction: MovementDirection.walkLeft,
  )..position = Vector2(598.57421875, 744.015625),
  OrangeBoyComponent(dialog: 'Теща - это святое')..position = Vector2(3033.9921875, 332.0390625),
  OrangeBoyComponent(dialog: 'Давайте подождём, что скажет тестирование. Я всего лишь менеджер.')
    ..position = Vector2(3303.66015625, 201.421875),
  BrownBoyComponent(dialog: 'Уходи')..position = Vector2(3109.32421875, 204.078125),
  BrownBoyComponent(
    dialog: 'Если есть необходимость работы в офисе на выходных, записывайся до 11 часов',
    direction: MovementDirection.walkLeft,
  )..position = Vector2(1565.64453125, 392.54296875),
  BlueBoyComponent(
    dialog: 'Не забудь забрать еду из холодильника',
  )..position = Vector2(2646.14453125, 420.06640625),
  BlueBoyComponent(
    dialog: 'Я бы начал волноваться. Все таки пятница вечер.',
  )..position = Vector2(3480.7265625, 722.0000500000001),
];
