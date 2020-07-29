import 'package:flame/anchor.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/position.dart';

import './square.dart';

class MyEffectMove extends BaseGame with TapDetector {
  Square square;
  MyEffectMove() {
    add(square = Square()
      ..x = 100
      ..y = 100);
  }

  @override
  void onTapUp(details) {
    square.addEffect(MoveEffect(isAlternating: true,
      destination: Position(
        details.localPosition.dx,
        details.localPosition.dy,
      ),
      speed: 600,
      curve: Curves.bounceInOut,
    ));
  }
}

class MyEffectScale extends BaseGame with TapDetector {
  Square square;
  bool grow = true;

  MyEffectScale() {
    add(square = Square()
      ..anchor = Anchor.center
      ..x = 200
      ..y = 200);
  }

  @override
  void onTap() {
    final s = grow ? 300.0 : 100.0;
    grow = !grow;
    square.addEffect(ScaleEffect(
      size: Size(s, s),
      speed: 250.0,
      curve: Curves.bounceInOut,
    ));
  }
}


