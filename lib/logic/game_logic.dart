import 'package:x_o_game/pages/game_page.dart';

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";

// For Storing the Position of [0-8] of X-O ...
  static List<int> playersX = [];
  static List<int> playersO = [];
}

class Game {
  void playGame(int index, Players activePlayer) {
    if (activePlayer == Players.X) {
      Player.playersX.add(index);
    } else {
      Player.playersO.add(index);
    }
  }

  void checkWinner() {}
}
