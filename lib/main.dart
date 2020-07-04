import 'package:biubiu/pages/game_over_page.dart';
import 'package:biubiu/pages/game_page.dart';
import 'package:biubiu/pages/home_page.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setPortraitUpOnly();
  await Flame.audio.loadAll([
    "bullet.mp3",
    "enemy1_down.mp3",
    "enemy2_down.mp3",
    "enemy2_out.mp3",
    "enemy3_down.mp3",
    "enemy4_down.mp3",
    "enemy4_out.mp3",
    "enemy5_down.mp3",
    "game_achievement.mp3",
    "game_music.mp3",
    "game_over.mp3",
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BIUBIU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        "/home":(context)=>HomePage(),
        "/game":(context)=>GamePage(),
      },
      initialRoute: "/",
    );
  }
}
