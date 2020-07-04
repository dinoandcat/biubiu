import 'package:biubiu/game/biu_biu_game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      final size = Size(constraints.maxWidth, constraints.maxHeight);
      final game =BiuBiuGame(size);
      return Scaffold(
          body: game.widget,
      );
    },);
  }
}
