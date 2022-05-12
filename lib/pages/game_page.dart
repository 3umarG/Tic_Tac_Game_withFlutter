import 'package:flutter/material.dart';
import 'package:x_o_game/themes/theme.dart';
import 'package:x_o_game/widgets/button.dart';

import '../logic/game_logic.dart';

enum Players { X, O }

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Players activePlayer = Players.X;
  bool isGameOver = false;
  int turn = 0;
  String result = "";
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: MyTheme.red,
                  ),
                  children: [
                    TextSpan(text: "It's  ".toUpperCase()),
                    TextSpan(
                      text: activePlayer == Players.X ? "X" : "O",
                      style: TextStyle(
                        color: activePlayer == Players.X
                            ? MyTheme.orange
                            : MyTheme.green,
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(text: "  Turn".toUpperCase()),
                  ],
                ),
              ),
              Container(
                height: 500,
                child: GridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                  children: List.generate(
                    9,
                    (index) => InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: isGameOver ||
                              Player.playersX.contains(index) ||
                              Player.playersO.contains(index)
                          ? null
                          : () => _onTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            Player.playersX.contains(index)
                                ? "x".toUpperCase()
                                : Player.playersO.contains(index)
                                    ? "o".toUpperCase()
                                    : "",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 100,
                              color: Player.playersX.contains(index)
                                  ? MyTheme.orange
                                  : MyTheme.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: repeatGame,
                icon: const Icon(Icons.replay),
                label: const Text(
                  "Repeat the Game",
                  style: TextStyle(fontSize: 25),
                ),
                style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromHeight(50)),
                    backgroundColor: MaterialStateProperty.all(
                      MyTheme.red,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTap(int index) {
    game.playGame(index, activePlayer);
    setState(() {
      activePlayer = (activePlayer == Players.X) ? Players.O : Players.X;
    });
    Winner? theWinner = game.checkWinner();
    if (theWinner == Winner.X) {
      ShowDialogueResult(Winner.X);
    } else if (theWinner == Winner.O) {
      ShowDialogueResult(Winner.O);
    } else if (theWinner == Winner.noOne) {
      ShowDialogueResult(Winner.noOne);
    }
  }

  void repeatGame() {
    setState(() {
      activePlayer = Players.X;
      isGameOver = false;
      turn = 0;
      result = "";
      Player.playersX = [];
      Player.playersO = [];
    });
  }

  void ShowDialogueResult(Winner winner) {
    showDialog(
      context: context,
      builder: (constext) => AlertDialog(
        title: const Text(
          "The Result",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              MyTheme.red,
            )),
            onPressed: () {
              repeatGame();
              Navigator.of(context).pop();
            },
            child: const Text(
              "Repeat the Game",
            ),
          ),
        ],
        content: Text(
          winner == Winner.X
              ? "X the Winner"
              : winner == Winner.O
                  ? "O the Winner"
                  : "There is No Winner",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: winner == Winner.X
                ? MyTheme.orange
                : winner == Winner.O
                    ? MyTheme.green
                    : MyTheme.red,
          ),
        ),
      ),
    );
  }
}
