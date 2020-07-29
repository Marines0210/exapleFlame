import 'dart:ui';

class TextureCollision{
  String key;
  double xStart;
  double xEnd;
  double yStart;
  double yEnd;
  double width;
  double height;
  double xAtlas;
  double yAtlas;

  TextureCollision({this.key="",this.xStart=0.0,
    this.xEnd=0.0,
    this.yStart=0.0,
    this.yEnd=0.0,
    this.width=0.0,
    this.height=0.0,
    this.xAtlas=0.0,
    this.yAtlas=0.0});



  get(Size size,double scale,){
    this.width= this.xStart+yStart;
    this.height= this.yStart+yEnd;

    this.xStart= 128 * xStart*scale ;
    this.xEnd= 128  * xEnd*scale ;

    this.yStart = size.height - 128 * yStart*scale;
    this.yEnd =  size.height - 128  * yEnd*scale;
    return this;
  }



}