import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'home_widget.dart';
import 'features/newbie/game/newbie_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  final NewbieGame game = NewbieGame();

  runApp(
    MaterialApp(
      home: HomeWidget(game: game),
    ),
  );
}
