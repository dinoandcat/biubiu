

import 'dart:io';

import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class GameOverPage extends StatelessWidget {
  final int score;

  GameOverPage(this.score);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/ui/gameover.png"), fit: BoxFit.cover)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:120.0,bottom: 10.0),
              child: Text(
                "$score",
                style: TextStyle(fontSize: 36, color: BasicPalette.white.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/game");
                },
                child: Text("重新开始"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  exit(0);
                },
                child: Text("结束游戏"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
