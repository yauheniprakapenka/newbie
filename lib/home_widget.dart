import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'features/newbie/game/newbie_game.dart';

class HomeWidget extends StatelessWidget {
  final NewbieGame game;

  const HomeWidget({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GameWidget(
            game: game,
          ),
        ],
      ),
    );
  }
}
