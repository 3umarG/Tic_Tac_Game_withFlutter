import 'package:flutter/material.dart';
import 'package:x_o_game/themes/theme.dart';

import '../logic/game_logic.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String activePlayer = "X".toUpperCase();
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 50,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w900,
                      color: MyTheme.red,
                    ),
                    children: [
                      TextSpan(text: "It's  ".toUpperCase()),
                      TextSpan(
                        text: "X".toUpperCase(),
                        style: TextStyle(
                          color: MyTheme.orange,
                          fontSize: 55,
                        ),
                      ),
                      TextSpan(text: "  Turn".toUpperCase()),
                    ],
                  ),
                ),
              ),
              Expanded(
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
                      onTap: isGameOver ? null : () => _onTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            "x".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 100,
                              color: MyTheme.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    activePlayer = "X".toUpperCase();
                    isGameOver = false;
                    turn = 0;
                    result = "";
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text("Repeat the Game"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).splashColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTap(int index) {
    game.playGame(index, activePlayer);
  }
}
