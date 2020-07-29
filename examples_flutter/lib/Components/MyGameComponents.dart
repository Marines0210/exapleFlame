import 'dart:math';
import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/sprite_batch_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite_batch.dart';
import 'package:flame/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyAnimations.dart';
import 'MySpriteAtlas.dart';

class MyGameComponents extends BaseGame with TapDetector {
  PositionComponent positionComponent;

  MyGameComponents(size) {
    /*loadMySvgComponent();
    loadMyAnimationComponent(size);
    initSprites(size);*/
    loadMyAnimationComponent(size);
//    MySpriteBatchComponent().initData(size).then((value) => add(value));
  }

  loadMySvgComponent() {
    SvgComponent mySvgComponent;
    mySvgComponent = SvgComponent.fromSvg(100, 100, Svg('cody_boy.svg'));
    mySvgComponent.x = 100;
    mySvgComponent.y = 100;
    add(mySvgComponent);
  }

  loadMyAnimationComponent(size) {
  }

  void initSprites(size) async {
    final r = Random();
    List.generate(50, (i) => SpriteComponent.square(32, 'bug1.png'))
        .forEach((sprite) {
      sprite.x = r.nextInt(size.width.toInt()).toDouble();
      sprite.y = r.nextInt(size.height.toInt()).toDouble();
      add(sprite);
    });
  }

  @override
  void render(Canvas canvas) {
    positionComponent.render(canvas);
    super.render(canvas);
  }

  @override
  void update(double t) {
    positionComponent.update(t);
  }

  @override
  void onTapDown(TapDownDetails evt) {
  }



}
