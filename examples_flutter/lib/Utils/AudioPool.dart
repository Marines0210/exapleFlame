import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/audio_pool.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';


TextConfig regular = TextConfig(color: BasicPalette.white.color);
AudioPool pool = AudioPool('laser.mp3');

class MyGameAudiopool extends BaseGame with TapDetector {
  MyGame(Size screenSize) {
    size = screenSize;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        BasicPalette.black.paint);
    regular.render(canvas, 'hit me!', Position.fromSize(size).div(2),
        anchor: Anchor.center);
    super.render(canvas);
  }

  @override
  void onTap() {
    pool.start();
  }
}
