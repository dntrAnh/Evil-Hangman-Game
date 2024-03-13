import 'package:flutter/material.dart';
import 'evilhangman.dart';
import 'setupscreen.dart';

class ResultScreen extends StatefulWidget {
  final EvilHangmanGame controller;

  const ResultScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button -- the user must start a new game
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'EVIL HANGMAN',
            style: TextStyle(
              color: Color.fromARGB(255, 185, 35, 85),
              fontWeight: FontWeight.bold,
              fontFamily: 'Silkscreen',
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.controller.isWon())
                Column(
                  children: [
                    Image.asset(
                      'assets/images/party.png',
                    ),
                    const Text(
                      'Congratulations!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 218, 10, 10),
                        fontSize: 24,
                        fontFamily: 'Advent_Pro'
                      ),
                    ),
                    Text(
                      'The word was \'${widget.controller.getSecretWord()}\'.',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 218, 10, 10),
                        fontSize: 24,
                        fontFamily: 'Advent_Pro'
                      ),
                    ),
                  ],
                ),
              if (!widget.controller.isWon())
                Column(
                  children: [
                    Image.asset(
                      'assets/images/clown.png',
                    ),
                    const Text(
                      'Sorry.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 167, 124, 138),
                        fontSize: 24,
                        fontFamily: 'Advent_Pro'
                      ),
                    ),
                    Text(
                      'The word was \'${widget.controller.getSecretWord()}\'.',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 167, 124, 138),
                        fontSize: 24,
                        fontFamily: 'Advent_Pro'
                      ),
                    ),
                  ],
                ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the setup screen, replacing the current route
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SetupScreen(controller: widget.controller),
                    ),
                    (route) => false, // Remove all previous routes from the stack
                  );
                },
                child: const Text(
                  'NEW GAME',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 227, 125, 159),
                      fontSize: 35,
                      fontFamily: 'Silkscreen'
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


