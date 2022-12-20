import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../game/newbie_game.dart';
import 'cpu_indicators_spritesheet.dart';

class CpuIndicatorComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<NewbieGame> {
  final CpuIndicatorColor cpuIndicatorColor;

  static const double _animationSpeed = 0.2;

  late final SpriteAnimation _greenAnimation;
  late final SpriteAnimation _redAnimation;
  late final SpriteAnimation _yellowAnimation;

  CpuIndicatorComponent({
    required this.cpuIndicatorColor,
  });

  factory CpuIndicatorComponent.green() {
    return CpuIndicatorComponent(cpuIndicatorColor: CpuIndicatorColor.green);
  }

  factory CpuIndicatorComponent.yellow() {
    return CpuIndicatorComponent(cpuIndicatorColor: CpuIndicatorColor.yellow);
  }

  factory CpuIndicatorComponent.red() {
    return CpuIndicatorComponent(cpuIndicatorColor: CpuIndicatorColor.red);
  }

  @override
  Future<void> onLoad() async {
    final SpriteSheet spriteSheet = SpriteSheet(
      image: await gameRef.images.load(CpuIndicatorsSpriteSheet.imagePath),
      srcSize: CpuIndicatorsSpriteSheet.spriteSize,
    );

    _greenAnimation = spriteSheet.createAnimation(
      row: CpuIndicatorsSpriteSheet.greenRowIndex,
      stepTime: _animationSpeed,
      to: CpuIndicatorsSpriteSheet.numberOfSprites,
    );

    _redAnimation = spriteSheet.createAnimation(
      row: CpuIndicatorsSpriteSheet.redRowIndex,
      stepTime: _animationSpeed,
      to: CpuIndicatorsSpriteSheet.numberOfSprites,
    );

    _yellowAnimation = spriteSheet.createAnimation(
      row: CpuIndicatorsSpriteSheet.yellowRowIndex,
      stepTime: _animationSpeed,
      to: CpuIndicatorsSpriteSheet.numberOfSprites,
    );

    switch (cpuIndicatorColor) {
      case CpuIndicatorColor.green:
        animation = _greenAnimation;
        break;
      case CpuIndicatorColor.yellow:
        animation = _yellowAnimation;
        break;
      case CpuIndicatorColor.red:
        animation = _redAnimation;
        break;
    }

    size = CpuIndicatorsSpriteSheet.spriteSize * 0.2;
    anchor = Anchor.center;

    await super.onLoad();
  }
}

enum CpuIndicatorColor {
  green,
  yellow,
  red,
}
