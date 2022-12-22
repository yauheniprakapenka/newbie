import 'package:flame/components.dart';

import '../../../../core_ui/movement_direction.dart';
import '../../sprite_animations/blue_boy/blue_boy_component.dart';
import '../../sprite_animations/brown_boy/brown_boy_component.dart';
import '../../sprite_animations/old_man/old_man_component.dart';
import '../../sprite_animations/orange_boy/orange_boy_component.dart';

final List<SpriteAnimationComponent> getBoyComponents = [
  OrangeBoyComponent(dialog: 'Делаю как на андроид')..position = Vector2(357.2578125, 891.40625),
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
  OrangeBoyComponent(
    direction: MovementDirection.walkLeft,
    dialog:
        'Она сказала, что любит меня как друга. Я ответил ей, что в С++ друзья имеют доступ к приватным частям',
  )..position = Vector2(3648.2109375, 732.84375),
  BrownBoyComponent(dialog: 'Уходи')..position = Vector2(3109.32421875, 204.078125),
  BrownBoyComponent(
    dialog: 'Если есть необходимость работы в офисе на выходных, записывайся до 11 часов',
    direction: MovementDirection.walkLeft,
  )..position = Vector2(1565.64453125, 392.54296875),
  BrownBoyComponent(
    dialog:
        'Встречаются два девопс на концеренции. -Как сделать чтобы релизить быстро и качественно? -Могу рассказать -Расказать я и сам могу, а как сделать то?',
    direction: MovementDirection.walkLeft,
  )..position = Vector2(3262.99609375, 191.578125),
  BlueBoyComponent(
    dialog: 'Не забудь забрать еду из холодильника',
  )..position = Vector2(2646.14453125, 420.06640625),
  BlueBoyComponent(
    dialog: '-У нас дыра в безопасности -Слава Богу, хоть что-то у нас в безопасности',
  )..position = Vector2(3859.4140625, 716.1640625),
  BlueBoyComponent(
    dialog: 'Я бы начал волноваться. Все таки пятница вечер.',
  )..position = Vector2(3480.7265625, 722.0000500000001),
  OldManComponent()..position = Vector2(3129.625, 1311.43364375),
  BlueBoyComponent(
    dialog: 'Я думал, нетворкинг - это когда отказываешься работать',
  )..position = Vector2(1459.69921875, 820.8086437500001),
  OrangeBoyComponent(
    dialog:
        'Посмотрел я на мобильных разработчиков: целый день за компьютером сидят не вставая, очень мобильно',
  )..position = Vector2(1458.171875, 886.1641125000001),
  BlueBoyComponent(
    dialog: '-Вы курите? -Только когда пишу юнит тесты -Ваши легкие полностью здоровы',
  )..position = Vector2(348.3125, 742.765625),
  BlueBoyComponent(
    dialog: '-Какое волшебное слово надо сказать, чтобы получить то, что хочешь? -sudo',
    direction: MovementDirection.walkLeft,
  )..position = Vector2(542.33984375, 892.53515625),
  OrangeBoyComponent(
    dialog:
        'Всегда было интересно как устраиваются на работу сами эйчары. Типа им нужно убить предыдущего эйчара? Или победить босса-эйчара? Или у них что-то типа игры кто кого пересобесит? Как?',
  )..position = Vector2(3584.046875, 328.9140625),
  BlueBoyComponent(
    dialog: 'Аксес денайд. Юзер инвалид.',
  )..position = Vector2(3511.296875, 377.0390625),
  BlueBoyComponent(
    dialog:
        '-Насколько это срочная задача? -Это не просто срочно. Это очень срочно! И сделать это нужно ни сегодня, ни завтра, а внезапно!',
  )..position = Vector2(2658.75390625, 161.06640625),
  OrangeBoyComponent(
    dialog:
        '-Моему другу нужен сайт. Предложил вариант за 500 баксов и дал твой номер телефона -Что, а сайт то большой? -Размером с обычный экран',
  )..position = Vector2(3481.1484375, 661.40625),
  BlueBoyComponent(
    dialog: 'Не волнуйтесь, если что-то не работает. Если бы все работало, то вас бы уволили',
  )..position = Vector2(1406.8718750000103, 515.4601562499997),
  OrangeBoyComponent(
    dialog: 'А что, если заказчик знает, что он хочет?',
  )..position = Vector2(2951.54843749998, 777.1187499999995),
  OrangeBoyComponent()..position = Vector2(2018.2507812499875, 597.0710937499988),
  OrangeBoyComponent()..position = Vector2(2383.410937499991, 581.5898437499987),
  BlueBoyComponent()..position = Vector2(2363.289843749991, 600.3046874999987),
  BrownBoyComponent()..position = Vector2(2137.8148437499935, 614.9609374999987),
  BrownBoyComponent()..position = Vector2(3004.7874999999935, 407.13281249999875),
];
