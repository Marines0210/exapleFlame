import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';


TextConfig regular = TextConfig(color: BasicPalette.white.color);
TextConfig tiny = regular.withFontSize(12.0);
class MyTextComponent extends BaseGame {
  MyTextComponent(Size screenSize) {
    size = screenSize;
    add(TextComponent('Hello, Flame', config: regular)
      ..y = 32.0);


    add(MyTextBox(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum.')
      ..anchor = Anchor.bottomLeft
      ..y = size.height);
  }
}
class MyTextBox extends TextBoxComponent {
  MyTextBox(String text)
      : super(text,
            config: tiny, boxConfig: const TextBoxConfig(timePerChar: 0.05));

  @override
  void drawBackground(Canvas c) {
    final Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = const Color(0xFFFF00FF));
    c.drawRect(
        rect.deflate(boxConfig.margin),
        Paint()
          ..color = BasicPalette.black.color
          ..style = PaintingStyle.stroke);
  }
}
