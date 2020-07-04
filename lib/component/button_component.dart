import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends PositionComponent with Tapable {
  final VoidCallback onPressed;
  TextConfig label;
  final Sprite sprite;
  final Sprite pressedSprite;
  final double width;
  final double height;
  bool _pressed = false;

  ButtonComponent(
    double x,
    double y, {
    @required this.onPressed,
    @required this.sprite,
    @required this.pressedSprite,
    this.width = 200,
    this.height = 50,
  }) {
    this.x = x;
    this.y = y;
  }

  ButtonComponent.position(
    Position position, {
    @required this.onPressed,
    @required this.sprite,
    @required this.pressedSprite,
    this.width = 200,
    this.height = 50,
  }) {
    setByPosition(position);
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);
    if (_pressed) {
      pressedSprite.render(c, width: width, height: height);
    } else {
      sprite.render(c, width: width, height: height);
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    if (toRect().contains(details.globalPosition)) {
      _pressed = true;

    }
  }

  @override
  void onTapUp(TapUpDetails details) {
    if (_pressed) {
      onTapCancel();
      onPressed();
    }
  }

  @override
  void onTapCancel() {
    if (_pressed) {
      _pressed = false;
    }
  }
}
