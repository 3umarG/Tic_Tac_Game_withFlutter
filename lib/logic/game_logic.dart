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

  Winner? checkWinner() {
    if (Player.playersX.containsAll(0, 1, 2) ||
        Player.playersX.containsAll(0, 3, 6) ||
        Player.playersX.containsAll(1, 4, 7) ||
        Player.playersX.containsAll(6, 7, 8) ||
        Player.playersX.containsAll(2, 5, 8) ||
        Player.playersX.containsAll(3, 4, 5) ||
        Player.playersX.containsAll(0, 4, 8) ||
        Player.playersX.containsAll(2, 4, 6)) {
      return Winner.X;
    } else if (Player.playersO.containsAll(0, 1, 2) ||
        Player.playersO.containsAll(0, 3, 6) ||
        Player.playersO.containsAll(1, 4, 7) ||
        Player.playersO.containsAll(6, 7, 8) ||
        Player.playersO.containsAll(2, 5, 8) ||
        Player.playersO.containsAll(3, 4, 5) ||
        Player.playersO.containsAll(0, 4, 8) ||
        Player.playersO.containsAll(2, 4, 6)) {
      return Winner.O;
    } else if (Player.playersO.length + Player.playersX.length == 9) {
      return Winner.noOne;
    } else {
      return null;
    }
  }
}

extension ContainsAll on List {
  bool containsAll(int a, int b, int c) {
    return contains(a) && contains(b) && contains(c);
  }
}

enum Winner {
  X,
  O,
  noOne,
}
