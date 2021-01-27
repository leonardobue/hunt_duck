import 'dart:ui';
import 'package:hunt_duck/main.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:hunt_duck/DuckGame.dart';

class ThrowDuck {
  final DuckGame game;
  Sprite flyingSprite;
  Sprite deadSprite;
  Sprite splash;
  double flyingSpriteIndex = 0;
  Rect flyRect;
  Rect deadZone;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;
  bool isBomb = false;
  double get speed => game.tileSize * 12;
  double rotate = 0;
  bool destroy = false;

  ThrowDuck(this.game) {
    targetLocation = Offset(
        game.rand.nextDouble() *
            (game.screenSize.width - (game.tileSize * 1.35)),
        game.screenSize.height - (game.screenSize.height / 0.8));
  }

  void setTargetLocation() {
    targetLocation = Offset(
        game.rand.nextDouble() *
            (game.screenSize.width - (game.tileSize * 1.35)),
        game.screenSize.height);
    destroy = true;
  }

  void render(Canvas c) {
    if (isDead) {
      if (deadZone == null) {
        deadZone = flyRect;
      }
      if (!isBomb) {
        deadSprite.renderPosition(c, Position(deadZone.left, deadZone.top));
      }
    } else {
      flyingSprite.renderRect(c, flyRect.inflate(flyRect.width / 4));
    }
  }

  void update(double t) {
    if (isDead) {
      rotate += 2 * t;
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);

        if (destroy) {
          if (game.activeView == State.INGAME && !isBomb) {
            game.activeView = State.GAMEOVER;
          }
          isDead = true;
        } else {
          setTargetLocation();
        }
      }
    }
  }

  void resize() {}

  void onTapDown() {
    if (!isDead) {
      isDead = true;

      if (game.activeView == State.INGAME) {
        if (isBomb) {
          game.activeView = State.GAMEOVER;
        } else {
          game.score += 1;

          if (game.score > (game.storage.getInt('highscore') ?? 0)) {
            game.storage.setInt('highscore', game.score);
            game.highscoreDisplay.updateHighscore();
          }
        }
      }
    }
  }
}
