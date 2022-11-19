import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'door_elevator_sprite_animation.dart';
import 'door_elevator_spritesheet.dart';

class DoorElevatorComponent extends SpriteAnimationComponent with HasGameRef<NewbieGame> {
  late final SpriteAnimation _openingDoorAnimation;
  late final SpriteAnimation _closingDoorAnimation;
  late final SpriteAnimation _idleOpenedDoorAnimation;
  late final SpriteAnimation _idleClosedDoorAnimation;

  static const Duration _openDoorTime = Duration(seconds: 2);
  final Vector2 _initialePosition = Vector2(1338, 474);
  int _scriptNumber = 0;
  bool _needToRunFuture = true;

  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = await DoorElevatorSpriteAnimation.getSpriteSheet(gameRef);
    _closingDoorAnimation = DoorElevatorSpriteAnimation.closingDoorAnimation(spriteSheet);
    _openingDoorAnimation = DoorElevatorSpriteAnimation.openingDoorAnimation(spriteSheet);
    _idleOpenedDoorAnimation = DoorElevatorSpriteAnimation.idleOpenedDoor(spriteSheet);
    _idleClosedDoorAnimation = DoorElevatorSpriteAnimation.idleClosedDoor(spriteSheet);
    position = _initialePosition;
    size = DoorSpriteSheet.spriteSize * 1.3;
    await super.onLoad();
  }

  @override
  void update(double dt) {
    _updateMovement();
    super.update(dt);
  }

  void _updateMovement() {
    switch (_scriptNumber) {
      case 0:
        animation = _idleClosedDoorAnimation;
        if (_needToRunFuture) {
          _needToRunFuture = false;
          Future.delayed(_openDoorTime).then((value) {
            _scriptNumber = 1;
            animation = _openingDoorAnimation;
            _needToRunFuture = true;
          });
        }
        break;
      case 1:
        if (_needToRunFuture) {
          _needToRunFuture = false;
          Future.delayed(_openDoorTime).then((value) {
            _scriptNumber = 2;
            animation = _closingDoorAnimation;
            _needToRunFuture = true;
          });
        }
    }
  }
}
