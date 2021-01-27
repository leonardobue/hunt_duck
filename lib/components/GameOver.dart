import 'dart:ui';
import 'package:hunt_duck/DuckGame.dart';
import 'package:flame/sprite.dart';

class GameOver {
  final DuckGame game;
  Rect rect;
  Sprite sprite;

  GameOver(this.game) {
    resize();
    sprite = Sprite('GameOver.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
  }
}
