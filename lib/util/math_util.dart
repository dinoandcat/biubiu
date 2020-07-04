import 'dart:math';
import 'dart:ui';

import 'package:flame/position.dart';

class RandomUtil {
  static Random _random = Random();

  static double nextDouble() {
    return _random.nextDouble();
  }

  static int nextInt(int max) {
    return _random.nextInt(max);
  }

  static Position nextPosition(Size size,{double width,double height}) {
    return Position.fromInts(nextInt((size.width-width).floor()), nextInt((size.height-height).floor()));
  }

}
