import 'dart:ui';
import 'package:hunt_duck/main.dart';
import 'package:flame/sprite.dart';
import 'package:hunt_duck/DuckGame.dart';

class StartButton {
  final DuckGame game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    resize();
    sprite = Sprite('play.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .80) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 2,
    );
  }

  void onTapDown() {
    game.score = 0;
    game.activeView = State.INGAME;
    game.spawner.start();
  }
}
