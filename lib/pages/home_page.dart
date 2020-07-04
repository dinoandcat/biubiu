import 'package:flame/sprite.dart';
import 'package:flame/widgets/sprite_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FractionallySizedBox(
                widthFactor: 0.8,
                child: Image.asset(
                  "assets/images/ui/title.png",
                )),

            SpriteButton(
                width: 300,height: 41,
              label:Container() ,
              onPressed: () {
                  // start game
                Navigator.pushNamed(context, "/game");
              },
              sprite: Sprite("ui/game_start.png"),
              pressedSprite: Sprite("ui/game_start_selected.png"),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: FlareActor(
                "assets/rive/loading.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "loading",
              ),
            )
          ],
        ),
      ),
    );
  }
}
