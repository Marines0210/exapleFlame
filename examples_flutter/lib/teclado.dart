import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/services.dart';

import 'dart:ui';


class Teclado extends Game with KeyboardEvents {

  Rect _rect = const Rect.fromLTWH(0, 100, 100, 100);
  int _dir = 0;

  @override
  void update(double dt) {
    _rect = _rect.translate(
      _dir * dt * 100,
      0,
    );
  }

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawRect(_rect, paint);
  }

  @override
  void onKeyEvent(e) {
    SystemChannels.textInput.invokeMethod('TextInput.show');

  final bool isKeyDown = e is RawKeyDownEvent;
    if (e.data.keyLabel == "a") {
      _dir = isKeyDown ? -1 : 0;
    } else if (e.data.keyLabel == "d") {
      _dir = isKeyDown ? 1 : 0;
    }
  }
}
