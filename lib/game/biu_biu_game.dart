import 'dart:io';
import 'dart:ui';

import 'package:biubiu/component/background.dart';
import 'package:biubiu/component/button_component.dart';
import 'package:biubiu/game/player/player.dart';
import 'package:biubiu/pages/game_over_page.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'enemy/enemy.dart';

class Layer {
  static int background = 1;
  static int player = 10;
  static int bullet = 9;
  static int enemy = 8;
}


class BiuBiuGame extends BaseGame with HasTapableComponents, MultiTouchDragDetector, HasWidgetsOverlay {
  Player player;
  EnemyProvider enemyProvider;
  int score = 0;
  final TextConfig testConfig = TextConfig(fontSize: 26, color: BasicPalette.white.color);

  BiuBiuGame(Size size) {
    this.size = size;
    add(Background(size, speed: 60));
    //暂停按钮
    add(ButtonComponent.position(
      Position.fromOffset(size.topRight(Offset(-65, 10))),
      onPressed: () {
        print("游戏暂停");
        pauseEngine();
        addWidgetOverlay("resume", PausePageWidget((){
          removeWidgetOverlay("resume");
          resumeEngine();
        }));
      },
      sprite: Sprite("ui/game_pause_nor.png"),
      pressedSprite: Sprite("ui/game_pause_pressed.png"),
      width: 65 * 0.8,
      height: 45 * 0.8,
    ));

    add(player = Player()..setByPosition(Position.fromOffset(size.bottomCenter(Offset(-102 / 4, -200)))));
    enemyProvider = EnemyProvider(2);
    add(enemyProvider);
    enemyProvider.start();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    testConfig.render(canvas, "SCORE $score", Position(10, 10));
  }

  @override
  void onReceiveDrag(DragEvent event) {
    onPanStart(event.initialPosition);
    event
      ..onUpdate = onPanUpdate
      ..onEnd = onPanEnd
      ..onCancel = onPanCancel;
  }

  void onPanStart(Offset position) {
    if (player.toRect().contains(position)) {
      player.onDrag = true;
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (player.onDrag) {
      player.onMove(details.delta);
    }
  }

  void onPanEnd(DragEndDetails details) {
    if (player.onDrag) {
      onPanCancel();
    }
  }

  void onPanCancel() {
    if (player.onDrag) {
      player.onDrag = false;
    }
  }

  @override
  Color backgroundColor() => Color(0xffccffff);

  void gameOver() {
    addWidgetOverlay("overlayName", GameOverPage(score));
  }
}

class PausePageWidget extends StatelessWidget {
  final VoidCallback resume;
  PausePageWidget(this.resume);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: resume,
              child: Text("继续游戏"),
            ),
          )
        ],
      ),
    );
  }
}
