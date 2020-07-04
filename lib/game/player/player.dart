import 'dart:math';
import 'dart:ui';

import 'package:biubiu/game/bullet/bullet.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';

import '../biu_biu_game.dart';

class Player extends PositionComponent with Resizable, HasGameRef<BiuBiuGame> {
  AnimationComponent _live;
  AnimationComponent _destroy;
  int life;
  bool onDrag = false;
  BulletProvider bulletProvider;

  Player({double x = 0.0, y = 0.0, this.life = 1, this.bulletProvider}) {
    this.x = x;
    this.y = y;

    width = 102 / 2;
    height = 126 / 2;

    _live = AnimationComponent(
      width,
      height,
      Animation.spriteList([
        Sprite("me1.png"),
        Sprite("me2.png"),
      ], stepTime: 0.2),
    );
    //
    _destroy = AnimationComponent(
      width,
      height,
      Animation.spriteList(
        [
          Sprite("me_destroy_1.png"),
          Sprite("me_destroy_2.png"),
          Sprite("me_destroy_3.png"),
          Sprite("me_destroy_4.png"),
        ],
        stepTime: 0.1,
        loop: false,
      ),
      destroyOnFinish: true,
    );
  }

  @override
  void render(Canvas c) {
    if (life > 0) {
      _live.render(c);
    } else {
      _destroy.render(c);
    }
    if (debugMode) {
      renderDebugMode(c);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (life > 0) {
      _live.setByPosition(toPosition());
      _live.update(dt);
      if (onDrag) {
        bulletProvider?.update(dt);
      }
    } else {
      _destroy.setByPosition(toPosition());
      _destroy.update(dt);
    }
  }

  onMove(Offset offset) {
    if (bulletProvider == null) {
      // bullet provider
      bulletProvider = BulletProvider(this, 1);
      bulletProvider.gameRef = gameRef;
      bulletProvider.start();
    }

    x += offset.dx;
    y += offset.dy;
    x = max(x, -_live.width / 2);
    x = min(x, size.width - _live.width / 2);
    y = max(y, -_live.height / 2);
    y = min(y, size.height - _live.height / 2);
  }

  @override
  void onDestroy() {
    gameRef.gameOver();
    gameRef.pauseEngine();
  }

  @override
  bool destroy() => life <= 0 && _destroy.destroy();

  void takeHurt(int power) {
    life -= power;
  }

  @override
  int priority() => Layer.player;
}
