import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyParallax extends BaseGame {
  MyParallax() {
    final horizontal = [
      ParallaxImage("horizontal_background.png",  alignment:Alignment.bottomLeft, fill: LayerFill.width),
      ParallaxImage("horizontal_Clouds.png", fill: LayerFill.width),
      ParallaxImage("horizontal_Rocks.png",  fill: LayerFill.width),
      ParallaxImage("horizontal_Hills_2.png",   fill: LayerFill.width),
      ParallaxImage("horizontal_Hills_1.png",  fill: LayerFill.width),
      ParallaxImage("horizontal_Ground.png", fill: LayerFill.width),
      ParallaxImage("horizontal_Trees.png", fill: LayerFill.width),
    ];
    final vertical = [
      ParallaxImage("vertical_sky.png", fill: LayerFill.height,repeat: ImageRepeat.repeat),
      ParallaxImage("vertical_clouds.png",fill: LayerFill.height,repeat: ImageRepeat.repeat),
      //ParallaxImage("vertical_background.png", fill: LayerFill.height,repeat: ImageRepeat.repeat),
      ParallaxImage("vertical_background_grass.png",  alignment:Alignment.center, fill: LayerFill.height,repeat: ImageRepeat.repeat),
    ];
    final parallaxComponent = ParallaxComponent(vertical,layerDelta:const Offset(0, 30) )
        ;
    //con baseSpeed: const Offset(0, 20), movemos la imagen de fondo
    add(parallaxComponent);
  }

}
