import 'package:flame/components.dart';

import '../../game/newbie_game.dart';
import 'door_elevator_spritesheet.dart';

class ElevatorDoorComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  @override
  Future<void> onLoad() async {
    size = DoorElevatorSpriteSheet.spriteSize * 1.36;
    await super.onLoad();
  }
}
