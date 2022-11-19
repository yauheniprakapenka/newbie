import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

import '../../../core_ui/movement_direction.dart';
import '../components/joystick_button_component.dart/joystick_button_component.dart';
import '../components/joystick_button_component.dart/joystick_images.dart';
import '../sprite_components/car_ambulance_component/car_ambulance_component.dart';
import '../sprite_components/door_elevator_component/door_elevator_component.dart';
import '../sprite_components/girl_glaucous_component/girl_glaucous_component.dart';
import '../sprite_components/girl_lilac_component/girl_lilac_component.dart';
import '../sprite_components/girl_pink_component/girl_pink_component.dart';
import '../sprite_components/girl_school_component/girl_school_component.dart';
import '../sprite_components/kid_yellow_component/kid_yellow_component.dart';
import '../sprite_components/newbie_component/newbie_component.dart';
import '../sprite_components/car_police_component/car_police_component.dart';
import '../sprite_components/tree_spritesheet_component/tree_component.dart';
import '../tiled_components/newbie_map_tiled_component.dart';

class NewbieGame extends FlameGame with HasCollisionDetection, HasTappables, HasDraggables {
  late final Size mapSize;
  MovementDirection collisionDirection = MovementDirection.noCollision;
  MovementDirection georgeMovementState = MovementDirection.idle;

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

    await add(CarAmbulanceComponent());

    final CarPoliceComponent police = CarPoliceComponent();
    await add(police);

    final KidYellowComponent kidYellow = KidYellowComponent()..position = Vector2(1840, 1520);
    await add(kidYellow);

    await add(GirlPinkComponent());
    await add(GirlGlaucousComponent());
    await add(GirlSchoolComponent());
    await add(GirlLilacComponent());
    await add(DoorElevatorComponent());
    await add(TreeComponent()..position = Vector2(510, 1460));
    await add(TreeComponent()..position = Vector2(620, 1404));
    await add(TreeComponent()..position = Vector2(790, 1570));
    await add(TreeComponent()..position = Vector2(970, 1310));
    await add(TreeComponent()..position = Vector2(1414, 1500));
    await add(TreeComponent()..position = Vector2(1609, 1660));
    await add(TreeComponent()..position = Vector2(2060, 1560));

    final NewbieComponent newbie = NewbieComponent()..position = Vector2(2060, 1560);
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
          georgeMovementState = MovementDirection.walkUp;
        },
        onReleased: () {
          georgeMovementState = MovementDirection.idle;
        },
      ),
    );

    await add(
      JoystickButtonComponent(
        margin: const EdgeInsets.only(left: 40, bottom: 40),
        sprite: await Sprite.load(JoystickImages.buttonLeft),
        onPressed: () {
          georgeMovementState = MovementDirection.walkLeft;
        },
        onReleased: () {
          georgeMovementState = MovementDirection.idle;
        },
      ),
    );
    await add(
      JoystickButtonComponent(
        margin: const EdgeInsets.only(left: 120, bottom: 40),
        sprite: await Sprite.load(JoystickImages.buttonDown),
        onPressed: () {
          georgeMovementState = MovementDirection.walkDown;
        },
        onReleased: () {
          georgeMovementState = MovementDirection.idle;
        },
      ),
    );

    await add(
      JoystickButtonComponent(
        margin: const EdgeInsets.only(left: 200, bottom: 40),
        sprite: await Sprite.load(JoystickImages.buttonRight),
        onPressed: () {
          georgeMovementState = MovementDirection.walkRight;
        },
        onReleased: () {
          georgeMovementState = MovementDirection.idle;
        },
      ),
    );
  }
}
