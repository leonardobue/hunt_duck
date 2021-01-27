import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:hunt_duck/DuckGame.dart';

class Background {
  final DuckGame game;
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite = Sprite('background.png');
    resize();
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void resize() {
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 20,
      game.tileSize * 27,
    );
  }
}
