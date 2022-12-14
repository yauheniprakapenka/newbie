import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../../core_ui/movement_direction.dart';
import '../components/joystick_button_component.dart/joystick_button_component.dart';
import '../components/joystick_button_component.dart/joystick_images.dart';
import 'newbie_game.dart';

Future<void> initAppJoystick(NewbieGame game) async {
  unawaited(game.add(
    JoystickButtonComponent(
      margin: const EdgeInsets.only(left: 120, bottom: 120),
      sprite: await Sprite.load(JoystickImages.buttonUp),
      onPressed: () {
        game.georgeMovementState = MovementDirection.walkUp;
      },
      onReleased: () {
        game.georgeMovementState = MovementDirection.idle;
      },
    ),
  ));

  unawaited(game.add(
    JoystickButtonComponent(
      margin: const EdgeInsets.only(left: 40, bottom: 40),
      sprite: await Sprite.load(JoystickImages.buttonLeft),
      onPressed: () {
        game.georgeMovementState = MovementDirection.walkLeft;
      },
      onReleased: () {
        game.georgeMovementState = MovementDirection.idle;
      },
    ),
  ));

  unawaited(game.add(
    JoystickButtonComponent(
      margin: const EdgeInsets.only(left: 120, bottom: 40),
      sprite: await Sprite.load(JoystickImages.buttonDown),
      onPressed: () {
        game.georgeMovementState = MovementDirection.walkDown;
      },
      onReleased: () {
        game.georgeMovementState = MovementDirection.idle;
      },
    ),
  ));

  unawaited(game.add(
    JoystickButtonComponent(
      margin: const EdgeInsets.only(left: 200, bottom: 40),
      sprite: await Sprite.load(JoystickImages.buttonRight),
      onPressed: () {
        game.georgeMovementState = MovementDirection.walkRight;
      },
      onReleased: () {
        game.georgeMovementState = MovementDirection.idle;
      },
    ),
  ));
}
