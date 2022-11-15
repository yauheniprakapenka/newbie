import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

import '../../../core_ui/movement_state.dart';
import '../components/joystick_button_component.dart/joystick_button_component.dart';
import '../components/joystick_button_component.dart/joystick_images.dart';
import '../sprite_components/ambulance_component/ambulance_component.dart';
import '../sprite_components/newbie_component/newbie_component.dart';
import '../sprite_components/police_component/police_component.dart';
import '../tiled_components/newbie_map_tiled_component.dart';

class NewbieGame extends FlameGame with HasCollisionDetection, HasTappables, HasDraggables {
  late final Size mapSize;
  int collisionDirection = kNoCollision;
  int georgeMovementState = kIdle;

  @override
  Future<void> onLoad() async {
    final TiledComponent newbieMap = await TiledComponent.load(
      NewbieMapTiledComponent.path,
      NewbieMapTiledComponent.tileSize,
    );
    await add(newbieMap);

    final TiledMap tiledMap = newbieMap.tileMap.map;
    mapSize = Size(
      tiledMap.width * NewbieMapTiledComponent.tileSize[0],
      tiledMap.height * NewbieMapTiledComponent.tileSize[1],
    );
    final Rect worldBounds = Rect.fromLTRB(0, 0, mapSize.width, mapSize.height);

    final AmbulanceComponent ambulance = AmbulanceComponent()..position = Vector2(160, 1200);
    await add(ambulance);

    final PoliceComponent police = PoliceComponent()..position = Vector2(240, 1200);
    await add(police);

    final NewbieComponent newbie = NewbieComponent()..position = Vector2(200, 1222);
    await add(newbie);
    camera.followComponent(newbie, worldBounds: worldBounds);

    await _initAppJoystick();

    await super.onLoad();
  }

  Future<void> _initAppJoystick() async {
    await add(
      JoystickButtonComponent(
        margin: const EdgeInsets.only(left: 120, bottom: 120),
        sprite: await Sprite.load(JoystickImages.buttonUp),
        onPressed: () {
          georgeMovementState = kWalkUp;
        },
        onReleased: () {
          georgeMovementState = kIdle;
        },
      ),
    );

    await add(
      JoystickButtonComponent(
        margin: const EdgeInsets.only(left: 40, bottom: 40),
        sprite: await Sprite.load(JoystickImages.buttonLeft),
        onPressed: () {
          georgeMovementState = kWalkLeft;
        },
        onReleased: () {
          georgeMovementState = kIdle;
        },
      ),
    );
    await add(
      JoystickButtonComponent(
        margin: const EdgeInsets.only(left: 120, bottom: 40),
        sprite: await Sprite.load(JoystickImages.buttonDown),
        onPressed: () {
          georgeMovementState = kWalkDown;
        },
        onReleased: () {
          georgeMovementState = kIdle;
        },
      ),
    );

    await add(
      JoystickButtonComponent(
        margin: const EdgeInsets.only(left: 200, bottom: 40),
        sprite: await Sprite.load(JoystickImages.buttonRight),
        onPressed: () {
          georgeMovementState = kWalkRight;
        },
        onReleased: () {
          georgeMovementState = kIdle;
        },
      ),
    );
  }
}
