import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart';

import 'wall_obstacle_component.dart';

List<WallObstacleComponent> getWallObstacle({required TiledComponent tiledMap}) {
  final ObjectGroup? objectGroup = tiledMap.tileMap.getLayer<ObjectGroup>('obstacle_wall');

  if (objectGroup != null) {
    final List<WallObstacleComponent> walls = [];

    for (final TiledObject tiledObject in objectGroup.objects) {
      walls.add(
        WallObstacleComponent()
          ..position = Vector2(tiledObject.x, tiledObject.y)
          ..width = tiledObject.width
          ..height = tiledObject.height,
      );
    }

    return walls;
  }

  throw Exception('obstacle not found');
}
