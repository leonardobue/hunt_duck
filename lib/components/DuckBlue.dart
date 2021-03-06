import 'dart:ui';
import 'package:hunt_duck/components/Throws.dart';
import 'package:flame/sprite.dart';
import 'package:hunt_duck/DuckGame.dart';

class DuckBlue extends ThrowDuck {
  double get speed => game.tileSize * 08;

  DuckBlue(DuckGame game, double x, double y) : super(game) {
    resize(x: x, y: y);
    flyingSprite = Sprite('galinha.png');
    deadSprite = Sprite('GameOver.png');
    isBomb = true;
  }

  void resize({double x, double y}) {
    x ??= (flyRect?.left) ?? 0;
    y ??= (flyRect?.top) ?? 0;
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 2, game.tileSize * 2);
    super.resize();
  }
}
