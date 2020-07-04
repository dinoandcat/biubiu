import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flame_scrolling_sprite/flame_scrolling_sprite.dart';

class Background extends ScrollingSpriteComponent {
  Sprite overBackground;

  Background(Size size, {double speed = 30, x = 0.0, y = 0.0})
      : super(
          x: x,
          y: y,
          scrollingSprite: ScrollingSprite(
            spritePath: "background.png",
            spriteWidth: 480,
            spriteHeight: 700,
            width: size.width,
            height: size.height,
            verticalSpeed: speed,
          ),
        ){
    overBackground=Sprite("ui/gameover.png",width: 480.0,height: 582.0);
  }


}
