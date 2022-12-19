import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import 'elevator_component.dart';

List<ElevatorComponent> getElevatorObstacle({required TiledComponent tiledMap}) {
  final ObjectGroup? objectGroup =
      tiledMap.tileMap.getLayer<ObjectGroup>('obstacle_elevator_doors');

  if (objectGroup != null) {
    final List<ElevatorComponent> elevators = [];

    for (final TiledObject tiledObject in objectGroup.objects) {
      elevators.add(
        ElevatorComponent()
          ..position = Vector2(tiledObject.x, tiledObject.y)
          ..width = tiledObject.width
          ..height = tiledObject.height,
      );
    }

    return elevators;
  }

  throw Exception('obstacle not found');
}
