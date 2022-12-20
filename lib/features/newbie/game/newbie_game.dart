import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

import '../../../core_ui/dialog_component.dart';
import '../../../core_ui/movement_direction.dart';
import '../obstacles/elevator/get_elevator_obstacle.dart';
import '../obstacles/main_door_in_building/get_main_door_to_building_obstacle.dart';
import '../sprite_animations/figure_skates_girl/figure_skates_girl_component.dart';
import '../sprite_animations/green_girl/green_girl_component.dart';
import '../sprite_animations/purple_girl/purple_girl_component.dart';
import '../sprite_animations/rabbit/rabbit_component.dart';
import '../sprite_animations/sprite_animations.dart';
import '../sprites/floor_indicator_component/floor_indicator_component.dart';
import 'configured_components/birds_components.dart';
import 'configured_components/boy_components.dart';
import 'configured_components/lantern_light_components.dart';
import 'floor_manager.dart';
import 'init_app_joystick.dart';
import 'rooms/conference_room.dart';
import 'rooms/elevator_room.dart';
import 'rooms/room401.dart';
import 'rooms/room404.dart';
import 'rooms/room405a.dart';
import 'rooms/room415v.dart';
import 'sprites/info_component/info_component.dart';
import 'sprites/java_image_component.dart';

class NewbieGame extends FlameGame with HasCollisionDetection, HasTappables, HasDraggables {
  // * Newbie

  static final Vector2 _newBiePosition = Vector2(3585.12109375, 449.44921875);
  late final NewbieComponent newbie;
  MovementDirection newbieMovementState = MovementDirection.idle;
  MovementDirection collisionDirection = MovementDirection.noCollision;

  // * Map
  late final Size mapSize;

  // * Components

  final List<PositionComponent> _components = [
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
    SantaClausComponent()..position = Vector2(1033.1171875, 1119.6016125),
    RabbitComponent(initialePosition: Vector2(492.0625, 1547.25395625)),
    RabbitComponent(initialePosition: Vector2(991.65234375, 1389.08208125)),
    RabbitComponent(initialePosition: Vector2(1384.265625, 1601.2578625)),
    ...getBirdComponents,
    ...getLanternLightComponents,
    GreenGirlComponent(
      dialog:
          'На почте лежит резюме от разработчика с фамилией Мамкин. Хочу, чтобы Мамкин программист работал у нас. Берем без собеса.',
      direction: MovementDirection.walkLeft,
    )..position = Vector2(4002.359375, 665.15234375),
    GreenGirlComponent(
      dialog: '-А эти жуки... -Баги -Хорошо, баги. Они сейчас здесь, с тобой в этой комнате?',
      direction: MovementDirection.walkLeft,
    )..position = Vector2(1572.05078125, 850.4180187500001),
    PurpleGirlComponent(
      dialog: 'Что по статусу?',
    )..position = Vector2(1779.19921875, 876.39453125),
    PurpleGirlComponent(
      dialog:
          '-Бабушка, а ты не видела мой пауербанк? -Лежит на антресоли -А что такое антресоль? - А что такое пауэрбанк?',
      direction: MovementDirection.walkLeft,
    )..position = Vector2(1559.40625, 726.9453625000001),
    ...getBoyComponents,
    InfoComponent(dialog: 'Здесь сидел Артем Ходос')..position = Vector2(3303.01953125, 293.171875),
    FigureSkatesGirlComponent(initialePosition: Vector2(3210, 1552.87505)),
    JavaImageComponent()..position = Vector2(4285.359375, 560.5195812500001),
    ...conferenceRoomComponents,
    ...room415vComponents,
    LanternLightComponent()..position = Vector2(2940.015625, 365.8594250000001),
    LanternLightComponent()..position = Vector2(2700.92578125, 495.2148937500001),
    LanternLightComponent()..position = Vector2(3561.44140625, 365.8516125000001),
    LanternLightComponent()..position = Vector2(1900.76171875, 558.7344250000001),
    LanternLightComponent()..position = Vector2(1436.22265625, 561.4648937500001),
    LanternLightComponent()..position = Vector2(451.77734375, 358.0469250000001),
    LanternLightComponent()..position = Vector2(427.6640625, 854.84765625),
    LanternLightComponent()..position = Vector2(1474.87890625, 454.21484375),
    LanternLightComponent()..position = Vector2(1331.87109375, 886.67578125),
    LanternLightComponent()..position = Vector2(1917.171875, 340.98046875),
    LanternLightComponent()..position = Vector2(2834.921875, 166.26953125),
    LanternLightComponent()..position = Vector2(2635.359375, 743.238281255),
    LanternLightComponent()..position = Vector2(2924.26953125, 646.898437),
    LanternLightComponent()..position = Vector2(3243.40625, 183.0703125),
    LanternLightComponent()..position = Vector2(3333.1484375, 566.21875),
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

  // * Toast messgae

  Future<void> showDialogByPosition(String message, Vector2 position) async {
    final DialogComponent dialogComponent = DialogComponent(text: message, position: position);
    await add(dialogComponent);
  }

  // * Lifecycle

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

    newbie = NewbieComponent()..position = _newBiePosition;
    await add(newbie);
    camera.followComponent(newbie, worldBounds: worldBounds);

    await initAppJoystick(this);

    _floorListening();

    unawaited(_floorManager.start());
    await _initializeElevatorDoor();

    await add(await getMainDoorToBuildingObstacle(tiledMap: newbieMap));
    await addAll(getElevatorObstacle(tiledMap: newbieMap));
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
      _updateFloorIndicators();
    });
  }

  void _updateDoorAnimation() {
    if (_needUpdateDoorAnimation) {
      _needUpdateDoorAnimation = false;
      switch (_elevatorDoorState) {
        case ElevatorDoorState.isOpening:
          _elevatorDoor.animation = _openingDoorAnimation;
          break;
        case ElevatorDoorState.isClosing:
          _elevatorDoor.animation = _closingDoorAnimation;
          break;
        case ElevatorDoorState.closed:
          _elevatorDoor.animation = _idleClosedDoorAnimation;
          break;
        case ElevatorDoorState.opened:
          _elevatorDoor.animation = _idleOpenedDoorAnimation;
          break;
      }
    }
  }
}
