
import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart' as animation;
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;



Random rnd = Random();
class ActionsGame extends BaseGame with HasWidgetsOverlay, HasTapableComponents{
  MyComposedComponent myComposedComponent;
  CodyBoy codyBoy;
  ParallaxComponent parallaxComponent;
  Size size;
  bool soundCrash=true;
  ActionsGame(this.size) {
    createControls();
    myComposedComponent = MyComposedComponent(size);
    codyBoy=CodyBoy(size);
    parallaxComponent=createParallaxComponent();
    add(parallaxComponent);
    add(codyBoy);
    add(myComposedComponent);
    _start();
  }

  void _start() async {
    Flame.audio.disableLog();
    Flame.audio.load('jump.mp3');
    Flame.audio.load('crash.mp3',);
    Flame.audio.loop('music.mp3', volume: 3.0);

  }
  createParallaxComponent(){
    final horizontal=[
      ParallaxImage("horizontal_background.png"),
      ParallaxImage("horizontal_Clouds.png"),
      ParallaxImage("horizontal_Rocks.png"),
      ParallaxImage("horizontal_Hills_2.png"),
      ParallaxImage("horizontal_Hills_1.png"),
      ParallaxImage("horizontal_Trees.png",repeat: ImageRepeat.noRepeat,),
      ParallaxImage("horizontal_Ground.png"),
    ];

    return ParallaxComponent(horizontal,layerDelta: const Offset(20, 0) );
  }
  @override
  void update(double t) {
   var bug = myComposedComponent.components;

   if(codyBoy.status==Status.crashed) {
     parallaxComponent.layerDelta= const Offset(0, 0);
   }else{
     myComposedComponent.updateBugs(t);
   }

    final hasCollision =
        bug.isNotEmpty && checkCollision(bug.first, codyBoy.currentCodyBoy);
    if (!hasCollision) {
    } else {
      if(soundCrash)
        Flame.audio.play('crash.mp3', volume: 1.0);

      soundCrash=false;
      codyBoy.status=Status.crashed;
      (bug.first as Bug).speed=0;
      (bug.first as Bug).animation.loop=false;
      createRestStar((bug.first as Bug));
    }

    super.update(t);
  }
  @override

  createControls(){
    addWidgetOverlay("Controls",
        Stack(children: <Widget>[
          Positioned(right:10,bottom:10,child:Column(children: <Widget>[
            gameButton(path:"assets/images/up_arrow.png",onTapDown: jumping,onTapUp: stopMoving),
            gameButton(path:"assets/images/down_arrow.png",onTapDown: ducking,onTapUp:stopMoving ),
          ],))
        ],));
  }
  createRestStar(bug){
    addWidgetOverlay("menu",
        Center(child:Container( decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'),
            fit: BoxFit.scaleDown,
          ),
          shape: BoxShape.circle,
        ),child:Column(mainAxisSize: MainAxisSize.min ,children: <Widget>[
        FlatButton(child:Image.asset('assets/images/play.png',width: 200,),onPressed:()=>restartGame(bug)
          ,padding: EdgeInsets.symmetric(vertical: 10),),
       FlatButton(child:Image.asset('assets/images/exit.png',width: 200,), ),
        ],))));
  }

  stopMoving(){
    if(codyBoy.status==Status.ducking){
      codyBoy.status=Status.running;
    }
    parallaxComponent.layerDelta= const Offset(20, 0);
  }

  restartGame( Bug bug){
    soundCrash=true;
      myComposedComponent.components.remove(bug);
      parallaxComponent.layerDelta= const Offset(20, 0);
      codyBoy.status=Status.running;
      removeWidgetOverlay("menu");
  }

  gameButton({path,onTapDown,onTapUp}){
    return GestureDetector(
      onTapDown: (detailDown)=>onTapDown(),
      onTapUp:(onTapUp!=null)? (detailUp)=>onTapUp():null,
      child: Container(
        child: Image.asset(path),
        width: 70,
        height: 70,
        margin: EdgeInsets.all(2),
      ),
    );
  }
  ducking(){
    if (codyBoy.status == Status.ducking || codyBoy.status==Status.crashed) {
      return;
    }
    parallaxComponent.layerDelta= const Offset(0, 0);
    codyBoy.status=Status.ducking;
    codyBoy.axisY=20;
  }

  jumping(){
    if (codyBoy.status==Status.crashed) {
      return;
    }
    Flame.audio.play('jump.mp3', volume: 1.0);
    parallaxComponent.layerDelta= const Offset(0, 0);
    codyBoy.status=Status.jumping;
    codyBoy.axisY=20;
  }


}

checkCollision(bug,codyBoy){
  return codyBoy.x<bug.x + bug.width &&
      codyBoy.x + codyBoy.width>bug.x &&
      codyBoy.y<bug.y+bug.height &&
      codyBoy.y + codyBoy.height>bug.y;
}


class MyComposedComponent extends PositionComponent with  HasGameRef, Tapable,ComposedComponent{
  Size size;
  MyComposedComponent(this.size);

  updateBugs(double t){
    for(final component in components){
      Bug bug = component as Bug;
      bug.updateBug(t);
    }

    if(components.isNotEmpty){
      final bug=components.elementAt(components.length-1) as Bug;
      if(bug.x<150 && components.length==1)
        addBug();
    }else{
      addBug();
    }
  }

  addBug(){
    components.add(Bug()..x=size.width..y=getRandom([size.height-80,size.height-140]));
  }
}

class Bug extends AnimationComponent{
  bool toRemove=false;
  double speed=10;
  Bug() : super(70, 80,
      animation.Animation.sequenced("bug.png", 2,amountPerRow: 2,loop: true,stepTime: 0.2,textureHeight: 481,textureWidth: 582)){

    width=70.0*getRandom([1,2]);
  }

  updateBug(double t){
    if(toRemove)
      return;

    x-=speed*t*20;
    if(!isVisible)
      toRemove=true;
  }


  @override
  bool destroy() {
    return toRemove;
  }

  bool get isVisible=>x+width>0;

}


Random random=Random();
getRandom(List list) {
  return list[random.nextInt(list.length)];
}


enum Status { running, crashed,ducking,jumping}
class CodyBoy extends PositionComponent with Resizable  {
  double startPositionX=0;

  double speed=20;
  double axisX=0;
  double axisY=0;
  var codyBoyRun;
  var codyBoyCrash;
  SpriteComponent codyBoyJump;
  SpriteComponent codyBoyDuck;
  Status status=Status.running;
  Size size;

  CodyBoy(this.size)
      : codyBoyRun =AnimationComponent(70, 80, animation.Animation.sequenced("run.png",4,amountPerRow:4,loop: true, stepTime: 0.2,textureHeight: 409,textureWidth:294.75,)),
        codyBoyCrash=AnimationComponent(70, 80, animation.Animation.sequenced("crash.png",2, amountPerRow:2,loop: true, stepTime: 0.2,textureHeight: 451,textureWidth:321,)),
        codyBoyJump=SpriteComponent.fromSprite(70, 80, Sprite("jump.png",height:447,width: 304) ),
        codyBoyDuck=SpriteComponent.fromSprite(80, 70, Sprite("duck.png",      width: 420,height:320)),
        super(){
    startPositionX=size.width/6;
  }


  @override
  void update(double dt) {
    switch(status){
      case Status.ducking:
        y=startPositionY+axisY;
        break;
      case Status.jumping:
        y-=axisY;
        axisY=axisY-1;
        if(y > startPositionY)
          reset();
        break;
      default:
        y=startPositionY;
    }

    currentCodyBoy.update(dt);
    currentCodyBoy.y=y;
    currentCodyBoy.x=x;
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    currentCodyBoy.render(c);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    x=startPositionX;
    y=startPositionY;
  }

  double get startPositionY {
    if (size == null) {
      return null;
    }
    return size.height-80;
  }

  reset(){
    y = startPositionY;
    axisY=0;
    status=Status.running;
  }


  PositionComponent get currentCodyBoy {
    switch (status) {
      case Status.running:
        return codyBoyRun;
      case Status.crashed:
        return codyBoyCrash;
      case Status.jumping:
        return codyBoyJump;
      case Status.ducking:
        return codyBoyDuck;
    }
  }
}
