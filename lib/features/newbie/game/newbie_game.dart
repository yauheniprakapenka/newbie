import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

import '../../../core_ui/movement_direction.dart';
import '../sprite_animations/bird/bird_component.dart';
import '../sprite_animations/rabbit/rabbit_component.dart';
import '../sprite_animations/sprite_animations.dart';
import '../sprites/floor_indicator_component/floor_indicator_component.dart';
import 'floor_manager.dart';
import 'init_app_joystick.dart';
import 'rooms/elevator_room.dart';
import 'rooms/room401.dart';
import 'rooms/room404.dart';
import 'rooms/room405a.dart';

class NewbieGame extends FlameGame with HasCollisionDetection, HasTappables, HasDraggables {
  static final Vector2 _newBiePosition = Vector2(991.65234375, 1389.08208125);

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
    SantaClausComponent()..position = Vector2(1219.1171875, 1119.6016125),
    LanternLightComponent()..position = Vector2(710.140625, 1364.13676875),
    LanternLightComponent()..position = Vector2(2390.34765625, 1538.69145625),
    LanternLightComponent()..position = Vector2(2744.75, 1314.44926875),
    LanternLightComponent()..position = Vector2(3176.9296875, 1266.7422375),
    LanternLightComponent()..position = Vector2(3302.28125, 1268.74614375),
    LanternLightComponent()..position = Vector2(3302.28125, 1268.74614375),
    LanternLightComponent()..position = Vector2(134.9921875, 1105.9453625),
    LanternLightComponent()..position = Vector2(244.1875, 1380.51176875),
    LanternLightComponent()..position = Vector2(244.69921875, 1588.74614375),
    LanternLightComponent()..position = Vector2(135, 1587.99614375),
    LanternLightComponent()..position = Vector2(1063.9453125, 1253.37505),
    LanternLightComponent()..position = Vector2(1064.22265625, 1491.4766125),
    LanternLightComponent()..position = Vector2(2263.0546875, 1393.50005),
    LanternLightComponent()..position = Vector2(2630.9296875, 1538.4297375),
    RabbitComponent(initialePosition: Vector2(492.0625, 1547.25395625)),
    RabbitComponent(initialePosition: Vector2(991.65234375, 1389.08208125)),
    RabbitComponent(initialePosition: Vector2(1384.265625, 1601.2578625)),
    //
    BirdComponent(initialePosition: Vector2(601.4765625, 1442.2188)),
    BirdComponent(initialePosition: Vector2(1129.23046875, 1573.4297375)),
    BirdComponent(initialePosition: Vector2(1622.72265625, 1097.4805187)),
    BirdComponent(initialePosition: Vector2(2979.97265625, 1489.4766125)),
    BirdComponent(initialePosition: Vector2(3738.26953125, 1730.51953125)),
    BirdComponent(initialePosition: Vector2(3973.4296875, 1601.85551875)),
    BirdComponent(initialePosition: Vector2(2222.796875, 1318.3359875)),
    BirdComponent(initialePosition: Vector2(2222.796875, 1318.3359875)),
    LanternLightComponent()..position = Vector2(310.30859375, 1727.984375),
    LanternLightComponent()..position = Vector2(317.0625, 1715.22265625),
    LanternLightComponent()..position = Vector2(324.2421875, 1726.921875),
    //
    LanternLightComponent()..position = Vector2(565.65234375, 1728.1171875),
    LanternLightComponent()..position = Vector2(574.18359375, 1716.08203125),
    LanternLightComponent()..position = Vector2(582.10546875, 1726.13671875),
    //
    LanternLightComponent()..position = Vector2(902.92578125, 1724.2734375),
    LanternLightComponent()..position = Vector2(909.875, 1715.08203125),
    LanternLightComponent()..position = Vector2(917.4921875, 1726.05078125),
    //
    LanternLightComponent()..position = Vector2(1206.80078125, 1728.14453125),
    LanternLightComponent()..position = Vector2(1212.89453125, 1715.80078125),
    LanternLightComponent()..position = Vector2(1221.73046875, 1721.89453125),
    //
    LanternLightComponent()..position = Vector2(1494.8984375, 1726.4609375),
    LanternLightComponent()..position = Vector2(1500.3828125, 1714.42578125),
    LanternLightComponent()..position = Vector2(1509.828125, 1725.6953125),
    //
    LanternLightComponent()..position = Vector2(1782.4921875, 1729.4296875),
    LanternLightComponent()..position = Vector2(1790.09765625, 1717.06640625),
    LanternLightComponent()..position = Vector2(1799.84375, 1726.81640625),
    //
    LanternLightComponent()..position = Vector2(2036.74609375, 1724.93359375),
    LanternLightComponent()..position = Vector2(2047.5546875, 1715.46875),
    LanternLightComponent()..position = Vector2(2055.171875, 1727.9609375),
    //
    LanternLightComponent()..position = Vector2(2309.79296875, 1727.95703125),
    LanternLightComponent()..position = Vector2(2319.84375, 1713.453125),
    LanternLightComponent()..position = Vector2(2325, 1726.84375),
    //
    LanternLightComponent()..position = Vector2(2611.61328125, 1725.453125),
    LanternLightComponent()..position = Vector2(2619.53515625, 1714.33984375),
    LanternLightComponent()..position = Vector2(2630.19921875, 1724.69921875),
    //
    LanternLightComponent()..position = Vector2(2935, 1725.4921875),
    LanternLightComponent()..position = Vector2(2942.6171875, 1715.30859375),
    LanternLightComponent()..position = Vector2(2951.43359375, 1725.97265625),
    //
    LanternLightComponent()..position = Vector2(3253.65625, 1727.15234375),
    LanternLightComponent()..position = Vector2(3261.56640625, 1715.42578125),
    LanternLightComponent()..position = Vector2(3270.40234375, 1724.56640625),
    //
    LanternLightComponent()..position = Vector2(3604.5, 1728.171875),
    LanternLightComponent()..position = Vector2(3614.859375, 1715.2109375),
    LanternLightComponent()..position = Vector2(3619.9921875, 1725.25),
    //
    LanternLightComponent()..position = Vector2(3894.62109375, 1726.95703125),
    LanternLightComponent()..position = Vector2(3904.06640625, 1714.91796875),
    LanternLightComponent()..position = Vector2(3911.68359375, 1726.484375),
    //
    LanternLightComponent()..position = Vector2(4197.6640625, 1726.00781255),
    LanternLightComponent()..position = Vector2(4206.19140625, 1714.28125),
    LanternLightComponent()..position = Vector2(4214.41796875, 1727.3828125),
    //
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
