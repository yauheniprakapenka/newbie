import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

import '../../../core_ui/movement_direction.dart';
import '../sprite_animations/boy_with_stick/boy_with_stick_component.dart';
import '../sprite_animations/car_ambulance_component/ambulance_car_component.dart';
import '../sprite_animations/car_police_component/police_car_component.dart';
import '../sprite_animations/door_elevator_component/door_elevator_sprite_animation.dart';
import '../sprite_animations/door_elevator_component/elevator_door_component.dart';
import '../sprite_animations/garland/garland_component.dart';
import '../sprite_animations/garland/garland_spritesheet.dart';
import '../sprite_animations/girl_glaucous_component/glaucous_girl_component.dart';
import '../sprite_animations/girl_lilac_component/girl_lilac_component.dart';
import '../sprite_animations/girl_pink_component/pink_girl_component.dart';
import '../sprite_animations/girl_school_component/school_girl_component.dart';
import '../sprite_animations/girl_throw_snowball_spritesheet/girl_throw_snowball_component.dart';
import '../sprite_animations/kid_yellow_component/kid_yellow_component.dart';
import '../sprite_animations/lantern_light/lantern_light_component.dart';
import '../sprite_animations/newbie_component/newbie_component.dart';
import '../sprite_animations/newbie_component/newbie_map_tiled_component.dart';
import '../sprite_animations/traffic_light/traffic_light_component.dart';
import '../sprite_animations/tree_spritesheet_component/tree_component.dart';
import '../sprites/floor_indicator_component/floor_indicator_component.dart';
import 'floor_manager.dart';
import 'init_app_joystick.dart';
import 'rooms/elevator_room.dart';
import 'rooms/room401.dart';
import 'rooms/room404.dart';
import 'rooms/room405a.dart';

class NewbieGame extends FlameGame with HasCollisionDetection, HasTappables, HasDraggables {
  static final Vector2 _newBiePosition = Vector2(2609.7109375, 1468.265675);

  late final Size mapSize;
  MovementDirection collisionDirection = MovementDirection.noCollision;
  MovementDirection georgeMovementState = MovementDirection.idle;

  // * Components

  final List<SpriteAnimationComponent> _components = [
    AmbulanceCarComponent()..position = Vector2(250, 1000),
    PoliceCarComponent()..position = Vector2(250, 1100),
    KidYellowComponent()..position = Vector2(1642.7578125, 1471.828125),
    PinkGirlComponent(),
    GlaucousGirlComponent(),
    SchoolGirlComponent(),
    GirlLilacComponent(),
    TreeComponent()..position = Vector2(290, 1469),
    TreeComponent()..position = Vector2(459.34375, 1470.74609375),
    TreeComponent()..position = Vector2(606.0859375, 1515.89453125),
    TreeComponent()..position = Vector2(837.703125, 1381.3828125),
    TreeComponent()..position = Vector2(1231.80859375, 1562.89453125),
    TreeComponent()..position = Vector2(1551.9453125, 1600.59375),
    TreeComponent()..position = Vector2(1551.9453125, 1600.59375),
    TreeComponent()..position = Vector2(2121, 1303),
    TreeComponent()..position = Vector2(2810, 1494),
    TrafficLightComponent()..position = Vector2(236.27734375, 1329.375),
    TrafficLightComponent()..position = Vector2(150.99609375, 1261.2265625),
    ...room401Components,
    ...room404Components,
    ...room405aComponents,
    ...elevatorRoomComponents,
    GarlandComponent()
      ..position = Vector2(1131.12890625, 1069.8671875)
      ..size = GarlandSpriteSheet.spriteSize,
    BoyWithStickComponent()..position = Vector2(1833.296875, 1439.171925),
    GirlThrowSnowballComponent()..position = Vector2(1980, 1430),
    LanternLightComponent()..position = Vector2(710.140625, 1364.13676875),
    LanternLightComponent()..position = Vector2(2390.34765625, 1538.69145625),
    LanternLightComponent()..position = Vector2(2744.75, 1314.44926875),
    LanternLightComponent()..position = Vector2(3176.9296875, 1266.7422375),
    LanternLightComponent()..position = Vector2(3302.28125, 1268.74614375),
  ];

  // * Elevator

  final FloorManager _floorManager;
  late int _currentFloor;
  ElevatorDoorState _elevatorDoorState = ElevatorDoorState.closed;

  final ElevatorDoorComponent _elevatorDoor = ElevatorDoorComponent();
  late final SpriteAnimation _openingDoorAnimation;
  late final SpriteAnimation _closingDoorAnimation;
  late final SpriteAnimation _idleOpenedDoorAnimation;
  late final SpriteAnimation _idleClosedDoorAnimation;
  bool _needUpdateDoorAnimation = true;

  NewbieGame({required FloorManager floorManager}) : _floorManager = floorManager;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

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
    await addAll(_components);

    final NewbieComponent newbie = NewbieComponent()..position = _newBiePosition;
    await add(newbie);
    camera.followComponent(newbie, worldBounds: worldBounds);

    await initAppJoystick(this);

    _floorListening();

    unawaited(_floorManager.start());
    await _initializeElevatorDoor();
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    print(info.eventPosition.game);
    super.onTapDown(pointerId, info);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    _updateDoorAnimation();
  }

  void _updateFloorIndicators() {
    final List<Vector2> positions = [
      Vector2(1120, 414),
      Vector2(1134, 414),
      Vector2(1148, 414),
      Vector2(1162, 414),
      Vector2(1176, 414),
      Vector2(1190, 414),
    ];
    for (var i = 0; i < positions.length; i++) {
      final bool isActive = i == _currentFloor;
      add(FloorIndicatorComponent(isActive: isActive)..position = positions[i]);
    }
  }

  Future<void> _initializeElevatorDoor() async {
    final SpriteSheet spriteSheet = await DoorElevatorSpriteAnimation.getSpriteSheet(this);
    _closingDoorAnimation = DoorElevatorSpriteAnimation.closingDoorAnimation(spriteSheet);
    _openingDoorAnimation = DoorElevatorSpriteAnimation.openingDoorAnimation(spriteSheet);
    _idleOpenedDoorAnimation = DoorElevatorSpriteAnimation.idleOpenedDoor(spriteSheet);
    _idleClosedDoorAnimation = DoorElevatorSpriteAnimation.idleClosedDoor(spriteSheet);
    _elevatorDoor.position = Vector2(1130, 445);
    _elevatorDoor.animation = _openingDoorAnimation;
    await add(_elevatorDoor);
  }

  void _floorListening() {
    _floorManager.currentFloor.listen((FloorModel floorModel) {
      _currentFloor = floorModel.floor - 1;

      switch (floorModel.doorState) {
        case ElevatorDoorState.isOpening:
          _elevatorDoorState = ElevatorDoorState.isOpening;
          _needUpdateDoorAnimation = true;
          break;
        case ElevatorDoorState.isClosing:
          _elevatorDoorState = ElevatorDoorState.isClosing;
          _needUpdateDoorAnimation = true;
          break;
        case ElevatorDoorState.closed:
          _elevatorDoorState = ElevatorDoorState.closed;
          _needUpdateDoorAnimation = true;
          break;
        case ElevatorDoorState.opened:
          _elevatorDoorState = ElevatorDoorState.opened;
          _needUpdateDoorAnimation = true;
          break;
      }
      // print('событие ${floorModel.toString()}');
      _updateFloorIndicators();
    });
  }

  void _updateDoorAnimation() {
    if (_needUpdateDoorAnimation) {
      _needUpdateDoorAnimation = false;
      switch (_elevatorDoorState) {
        case ElevatorDoorState.isOpening:
          _elevatorDoor.animation = _openingDoorAnimation;
          // print('_openingDoorAnimation');
          break;
        case ElevatorDoorState.isClosing:
          _elevatorDoor.animation = _closingDoorAnimation;
          // print('_closingDoorAnimation');
          break;
        case ElevatorDoorState.closed:
          _elevatorDoor.animation = _idleClosedDoorAnimation;
          // print('_idleClosedDoorAnimation');
          break;
        case ElevatorDoorState.opened:
          _elevatorDoor.animation = _idleOpenedDoorAnimation;
          // print('_idleOpenedDoorAnimation');
          break;
      }
    }
  }
}
