import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/time.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components/timer_component.dart';

class MyBaseGameTimer extends BaseGame with TapDetector {

  Timer countdown;
  MyBaseGameTimer(){
    countdown = Timer(11,repeat: true , callback: () {
     if(countdown.isFinished())
       countdown.stop();
    });
    add(RenderedTimeComponent(countdown));
  }
  @override
  void onTapDown(_) {
    countdown.start();
  }

  @override
  void update(double dt) {
    countdown.update(dt);
  }

}

class RenderedTimeComponent extends TimerComponent {
  final TextConfig textConfig =
      const TextConfig(color: const Color(0xFFFFFFFF));

  RenderedTimeComponent(Timer timer) : super(timer);

  @override
  void render(Canvas canvas) {
    textConfig.render(
        canvas, "Elapsed time: ${timer.current.round()}", Position(10, 150));
  }
}


class MyGameTimer extends Game with TapDetector {
  final TextConfig textConfig =
      const TextConfig(color: const Color(0xFFFFFFFF));
  Timer countdown;
  Timer interval;

  int elapsedSecs = 0;

  MyGameTimer() {
    countdown = Timer(11);
    interval = Timer(1, repeat: true, callback: () {
      elapsedSecs += 1;
    });
    interval.start();
  }

  @override
  void onTapDown(_) {
    countdown.start();
  }

  @override
  void update(double dt) {
    countdown.update(dt);
    interval.update(dt);
  }

  @override
  void render(Canvas canvas) {
    textConfig.render(canvas, "Countdown: ${countdown.current.round()}",
        Position(10, 100));
    textConfig.render(canvas, "Elapsed time: $elapsedSecs", Position(10, 150));
  }
}
