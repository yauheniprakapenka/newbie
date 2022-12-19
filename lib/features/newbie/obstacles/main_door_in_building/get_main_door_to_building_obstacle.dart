import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import 'main_door_to_building_component.dart';

Future<PositionComponent> getMainDoorToBuildingObstacle({required TiledComponent tiledMap}) async {
  final ObjectGroup? objectGroup =
      tiledMap.tileMap.getLayer<ObjectGroup>('main_door_to_building_obstacle');

  if (objectGroup != null) {
    for (final TiledObject tiledObject in objectGroup.objects) {
      return MainDoorToBuildingComponent()
        ..position = Vector2(tiledObject.x, tiledObject.y)
        ..width = tiledObject.width
        ..height = tiledObject.height;
    }
  }

  throw Exception('obstacle not found');
}
