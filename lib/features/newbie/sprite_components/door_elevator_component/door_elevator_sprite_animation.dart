import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'door_elevator_spritesheet.dart';

class DoorElevatorSpriteAnimation {
  static const double _animationSpeed = 0.3;
  static const int _doorRowIndex = 0;

  static Future<SpriteSheet> getSpriteSheet(NewbieGame gameRef) async {
    return SpriteSheet(
      image: await gameRef.images.load(DoorSpriteSheet.imagePath),
      srcSize: DoorSpriteSheet.spriteSize,
    );
  }

  static SpriteAnimation openingDoorAnimation(SpriteSheet spriteSheet) {
    return spriteSheet.createAnimation(
      row: DoorSpriteSheet.openDoorRowIndex,
      stepTime: _animationSpeed,
      to: DoorSpriteSheet.spritesInRow,
      loop: false,
    );
  }

  static SpriteAnimation closingDoorAnimation(SpriteSheet spriteSheet) {
    return SpriteAnimation.spriteList(
      [
        spriteSheet.getSprite(_doorRowIndex, 2),
        spriteSheet.getSprite(_doorRowIndex, 1),
        spriteSheet.getSprite(_doorRowIndex, 0),
      ],
      stepTime: _animationSpeed,
      loop: false,
    );
  }

  static SpriteAnimation idleOpenedDoor(SpriteSheet spriteSheet) {
    return SpriteAnimation.spriteList(
      [
        spriteSheet.getSprite(_doorRowIndex, 2),
      ],
      stepTime: _animationSpeed,
    );
  }

  static SpriteAnimation idleClosedDoor(SpriteSheet spriteSheet) {
    return SpriteAnimation.spriteList(
      [
        spriteSheet.getSprite(_doorRowIndex, 0),
      ],
      stepTime: _animationSpeed,
    );
  }
}
