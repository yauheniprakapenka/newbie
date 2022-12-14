import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'features/newbie/game/floor_manager.dart';
import 'features/newbie/game/newbie_game.dart';
import 'home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  final NewbieGame game = NewbieGame(floorManager: FloorManager());

  runApp(
    MaterialApp(
      home: HomeWidget(game: game),
    ),
  );
}
