import 'dart:ui';

import 'package:biubiu/game/biu_biu_game.dart';
import 'package:biubiu/game/player/player.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';

class Bullet extends SpriteComponent {
  double speed;
  int power;
  bool isDestroy = false;

  Bullet(double width, double height, String fileName, {double x, double y, this.speed = 150, this.power = 1})
      : super.fromSprite(width, height, Sprite(fileName)) {
    this.x = x;
    this.y = y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += -speed * dt;
    if (y < -20) {
      isDestroy = true;
    }
  }

  @override
  bool destroy() => isDestroy;

}


class BulletProvider extends Component with HasGameRef<BiuBiuGame> {
  Player player;
  Timer timer;

  BulletProvider(this.player, double limit) {
    timer = Timer(limit, repeat: true, callback: () {
      gameRef.add(Bullet(5, 11, "bullet1.png")..setByPosition(player.toPosition() - Position(-player.width / 2, 0.0)));
    });
  }

  void start() {
    timer.start();
    gameRef.add(Bullet(5, 11, "bullet1.png")..setByPosition(player.toPosition() - Position(-player.width / 2, 0.0)));
  }

  void stop() {
    timer.stop();
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double t) {
    timer.update(t);
  }
}
