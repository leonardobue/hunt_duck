import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hunt_duck/components/background.dart';
import 'package:hunt_duck/components/Throws.dart';
import 'package:hunt_duck/main.dart';
import 'components/Duck.dart';
import 'components/DuckBlue.dart';
import 'components/RecordeDisplay.dart';
import 'components/Play.dart';
import 'components/Spawn.dart';
import 'components/GameOver.dart';

class DuckGame extends Game {
  final SharedPreferences storage;
  Size screenSize;
  double tileSize;
  Random rand;

  Background background;
  List<ThrowDuck> ducks;
  StartButton startButton;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;
  Spawner spawner;
  State activeView = State.GAMEOVER;
  GameOver gameOver;
  int score;

  DuckGame(this.storage) {
    initialize();
  }

  Future<void> initialize() async {
    rand = Random();
    ducks = List<ThrowDuck>();
    score = 0;
    resize(Size.zero);

    background = Background(this);
    startButton = StartButton(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
    spawner = Spawner(this);
    gameOver = GameOver(this);
  }

  void spawn() {
    double x = rand.nextDouble() * (screenSize.width - (tileSize * 2.025));
    double y = screenSize.height - (tileSize * 2.025);
    switch (rand.nextInt(2)) {
      case 0:
        ducks.add(Duck(this, x, y));
        break;
      case 1:
        ducks.add(DuckBlue(this, x, y));
        break;
    }
  }

  void render(Canvas canvas) {
    background.render(canvas);
    highscoreDisplay.render(canvas);
    if (activeView == State.INGAME || activeView == State.GAMEOVER)
      scoreDisplay.render(canvas);
    ducks.forEach((ThrowDuck duck) => duck.render(canvas));

    if (activeView == State.GAMEOVER) gameOver.render(canvas);
    if (activeView == State.HOME || activeView == State.GAMEOVER) {
      startButton.render(canvas);
    }
  }

  void update(double t) {
    spawner.update(t);
    ducks.forEach((ThrowDuck duck) => duck.update(t));
    ducks.removeWhere((ThrowDuck duck) => duck.isOffScreen);
    if (activeView == State.INGAME) scoreDisplay.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    background?.resize();
    highscoreDisplay?.resize();
    scoreDisplay?.resize();
    ducks.forEach((ThrowDuck duck) => duck?.resize());
    gameOver?.resize();
    startButton?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // start
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == State.HOME || activeView == State.GAMEOVER) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      bool duckHitAFly = false;
      ducks.forEach((ThrowDuck duck) {
        if (duck.flyRect.contains(d.globalPosition)) {
          duck.onTapDown();
          isHandled = true;
          duckHitAFly = true;
        }
      });
    }
  }
}
