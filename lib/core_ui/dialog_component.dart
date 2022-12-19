import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class DialogComponent extends TextBoxComponent {
  static const double _timePerChar = 0.07;

  static const double _dialogWidth = 160;

  DialogComponent({super.text, super.position})
      : super(
          textRenderer:
              TextPaint(style: TextStyle(fontSize: 12, color: BasicPalette.white.color)).copyWith(
            (style) => style.copyWith(
              color: Colors.white,
              fontFamily: 'vt323',
              letterSpacing: 2.0,
            ),
          ),
          boxConfig: TextBoxConfig(
            maxWidth: _dialogWidth,
            timePerChar: _timePerChar,
          ),
        );

  @override
  void drawBackground(Canvas c) {
    const Rect rect = Rect.fromLTWH(0, 0, _dialogWidth, _dialogWidth);
    c.drawRect(rect, Paint()..color = Colors.black.withOpacity(0.7));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final Duration duration = Duration(milliseconds: (_timePerChar * 1000).toInt() * text.length) +
        const Duration(seconds: 3);
    unawaited(Future.delayed(duration).then((value) {
      removeFromParent();
    }));
    return redraw();
  }
}
