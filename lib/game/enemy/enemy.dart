import 'dart:math';
import 'dart:ui';

import 'package:biubiu/game/biu_biu_game.dart';
import 'package:biubiu/game/bullet/bullet.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/widgets.dart' hide Animation;

enum EnemyState { RUN, DIED, HIT }

class Enemy extends PositionComponent with HasGameRef<BiuBiuGame> {
  AnimationComponent runAnimation;
  AnimationComponent diedAnimation;
  AnimationComponent hitAnimation;
  int life;
  double speed;
  EnemyState enemyState;
  int power;
  int score;

  Enemy({
    @required this.runAnimation,
    @required this.diedAnimation,
    this.hitAnimation,
    this.life = 1,
    this.speed = 100,
    this.enemyState = EnemyState.RUN,
    this.power = 1,
    this.score = 1,
    double x,
    double y,
  }) {
    this.x = x;
    this.y = y;
  }

  @override
  void render(Canvas c) {
    switch (enemyState) {
      case EnemyState.RUN:
        runAnimation.render(c);
        break;
      case EnemyState.DIED:
        diedAnimation.render(c);
        break;
      case EnemyState.HIT:
        hitAnimation.render(c);
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkCollide();
    runAnimation?.setByPosition(toPosition());
    diedAnimation?.setByPosition(toPosition());
    hitAnimation?.setByPosition(toPosition());
    switch (enemyState) {
      case EnemyState.RUN:
        runAnimation.update(dt);
        break;
      case EnemyState.DIED:
        diedAnimation.update(dt);
        break;
      case EnemyState.HIT:
        hitAnimation.update(dt);
        if (hitAnimation.animation.done()) {
          if (life > 0) {
            enemyState = EnemyState.RUN;
          } else {
            enemyState = EnemyState.DIED;
          }
        }
        break;
    }
    y += speed * dt;
  }

  void checkCollide() {
    if (enemyState == EnemyState.DIED) {
      return;
    }
    //与玩家发生碰撞
    if (gameRef.player.life > 0 && gameRef.player.toRect().overlaps(toRect())) {
      enemyState = EnemyState.DIED;
      gameRef.player.takeHurt(power);
    }
    gameRef.components.where((c) => c is Bullet).forEach((c) {
      //与子弹发生碰撞
      var bullet = c as Bullet;
      if (bullet.toRect().overlaps(toRect())) {
        bullet.isDestroy = true;
        if (!takeHurt(bullet.power) && hitAnimation != null) {
          enemyState = EnemyState.HIT;
          hitAnimation.animation.reset();
        }
        if (life <= 0) {
          gameRef.score += score;
        }
      }
    });
  }

  bool takeHurt(int power) {
    life -= power;
    if (life <= 0) {
      enemyState = EnemyState.DIED;
      return true;
    }

    return false;
  }

  @override
  bool destroy() => (life <= 0 && diedAnimation.animation.done()) || y > gameRef.size.height + height;
}

class EnemyOne extends Enemy {
  EnemyOne({double x, y, int life = 1, double speed = 100}) {
    this.speed = speed;
    this.x = x;
    this.y = y;
    this.life = life;
    width = 57.0;
    height = 43.0;
    runAnimation = AnimationComponent(
      width,
      height,
      Animation.spriteList(
        [
          Sprite("enemy1.png"),
        ],
        stepTime: 0.2,
      ),
    );
    diedAnimation = AnimationComponent(
      width,
      height,
      Animation.spriteList(
        [
          Sprite("enemy1_down1.png"),
          Sprite("enemy1_down2.png"),
          Sprite("enemy1_down3.png"),
          Sprite("enemy1_down4.png"),
        ],
        stepTime: 0.25,
        loop: false,
      ),
      destroyOnFinish: true,
    );
  }
}

class EnemyTow extends Enemy {
  EnemyTow({double x, y, int life = 3, width = 69.0, height = 99.0})
      : super(
          speed: 80,
          runAnimation: AnimationComponent(
            width,
            height,
            Animation.spriteList([
              Sprite("enemy2.png"),
            ], stepTime: 0.2),
          ),
          hitAnimation: AnimationComponent(
            width,
            height,
            Animation.spriteList(
              [
                Sprite("enemy2_hit.png"),
              ],
              stepTime: 0.25,
              loop: false,
            ),
          ),
          diedAnimation: AnimationComponent(
            width,
            height,
            Animation.spriteList(
              [
                Sprite("enemy2_down1.png"),
                Sprite("enemy2_down2.png"),
                Sprite("enemy2_down3.png"),
                Sprite("enemy2_down4.png"),
              ],
              stepTime: 0.25,
              loop: false,
            ),
            destroyOnFinish: true,
          ),
          score: 5,
        ) {
    this.x = x;
    this.y = y;
    this.life = life;
    this.width = width;
    this.height = height;
  }
}

class EnemyThree extends Enemy {
  EnemyThree({double x, y, int life = 5, width = 165.0, height = 261.0})
      : super(
          speed: 40,
          runAnimation: AnimationComponent(
            width,
            height,
            Animation.spriteList([
              Sprite("enemy3_n1.png"),
              Sprite("enemy3_n2.png"),
            ], stepTime: 0.2),
          ),
          hitAnimation: AnimationComponent(
            width,
            height,
            Animation.spriteList(
              [
                Sprite("enemy3_hit.png"),
              ],
              stepTime: 0.25,
              loop: false,
            ),
          ),
          diedAnimation: AnimationComponent(
            width,
            height,
            Animation.spriteList(
              [
                Sprite("enemy3_down1.png"),
                Sprite("enemy3_down2.png"),
                Sprite("enemy3_down3.png"),
                Sprite("enemy3_down4.png"),
                Sprite("enemy3_down5.png"),
                Sprite("enemy3_down6.png"),
              ],
              stepTime: 0.25,
              loop: false,
            ),
            destroyOnFinish: true,
          ),
          score: 10,
        ) {
    this.x = x;
    this.y = y;
    this.life = life;
    this.width = width;
    this.height = height;
  }
}

class EnemyProvider extends Component with HasGameRef<BiuBiuGame> {
  Timer timer;
  Random random = Random();

  EnemyProvider(double limit) {
    timer = Timer(limit, repeat: true, callback: () {
      int r = random.nextInt(10);
      if (r <= 5) {
        var enemy = EnemyOne();
        enemy.setByPosition(
            Position.fromInts(random.nextInt((gameRef.size.width - enemy.width).floor()), -enemy.height.floor()));
        gameRef.add(enemy);
      } else if (r > 7) {
        var enemy = EnemyTow();
        enemy.setByPosition(
            Position.fromInts(random.nextInt((gameRef.size.width - enemy.width).floor()), -enemy.height.floor()));
        gameRef.add(enemy);
      } else {
        var enemy = EnemyThree();
        enemy.setByPosition(
            Position.fromInts(random.nextInt((gameRef.size.width - enemy.width).floor()), -enemy.height.floor()));
        gameRef.add(enemy);
      }
    });
  }

  void start() {
    timer.start();
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
