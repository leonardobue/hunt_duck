import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:hunt_duck/DuckGame.dart';

//controla pontuacao recorde
class HighscoreDisplay {
  final DuckGame game;
  TextPainter painter;
  Offset position;

  HighscoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;

    updateHighscore();
  }

  void updateHighscore() {
    resize();
  }

  void resize() {
    int highscore = game.storage.getInt('highscore') ?? 0;

    Shadow shadow = Shadow(
      blurRadius: game.tileSize * .0625,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    painter.text = TextSpan(
      text: 'Recorde: ' + highscore.toString(),
      style: TextStyle(
        color: Color(0xffffffff),
        fontSize: game.tileSize * .8,
        shadows: <Shadow>[
          shadow,
          shadow,
          shadow,
          shadow,
          shadow,
          shadow,
          shadow,
          shadow
        ],
      ),
    );

    if (painter.text == null) return;
    painter.layout();
    position = Offset(
      game.screenSize.width - (game.tileSize * .25) - painter.width,
      game.tileSize * .25,
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }
}

//exibe placar atual
class ScoreDisplay {
  final DuckGame game;
  TextPainter painter;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter?.text ?? '') != game.score.toString()) {
      resize();
    }
  }

  void resize() {
    painter.text = TextSpan(
      text: game.score.toString() + ' pts',
      style: TextStyle(
        color: Color(0xffffffff),
        fontSize: game.tileSize * 1,
        shadows: <Shadow>[
          Shadow(
            blurRadius: game.tileSize * .0625,
            color: Color(0xff000000),
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
    painter.layout();
    position = Offset(
      (game.screenSize.width / 2) - (painter.width / 2),
      (game.screenSize.height * .15) - (painter.height / 1),
    );
  }
}
