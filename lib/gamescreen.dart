import 'package:flutter/material.dart';
import 'evilhangman.dart';
import 'resultscreen.dart';

class GameScreen extends StatefulWidget {
  final EvilHangmanGame controller;
  const GameScreen({
    super.key,
    required this.controller,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final guessTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Focus node for the guess text field
    final guessFocusNode = FocusNode();
    return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Evil Hangman', 
        style: TextStyle(
          color: Color.fromARGB(255, 185, 35, 85),
          fontWeight: FontWeight.bold,
          fontFamily: 'Silkscreen',
        )),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children from top to bottom
      children: [
        // Top: Display word guess. 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.controller.displayWord.toUpperCase(),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            ),
          ),
        ),

        // Middle: Display number of guesses remaining and guessed letters.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Number of guesses remaining: ${widget.controller.numGuesses}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 215, 48, 103),
                  fontSize: 21,
                  fontFamily: 'Advent_Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.center, 
                child: Text(
                  'Guessed letters: ${widget.controller.guessedLetters.join(" ")}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 227, 125, 159),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Advent_Pro'
                  ),
                ),
              ),
              if (widget.controller.displaySizeOfWordSet)
                Text(
                  'Number of remaining set of words: ${widget.controller.currWordSet.length}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 227, 125, 159),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontFamily: 'Advent_Pro'
                  ),
                ),
            ],
          ),
        ),

      // Bottom: Form field for user to guess a letter.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                focusNode: guessFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Guess a letter',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 182, 100, 127),
                    fontFamily: 'Silkscreen'
                  ),
                ),
                controller: guessTextController,
                // Validate the input
                validator: (String? value) {
                    // If the user did not enter anything, return an error message
                    if (value == null || value.isEmpty) {
                      return 'Please enter a letter to guess';
                    }
                    // If the user entered something that is not a letter, return an error message
                    RegExp regex = RegExp(r'^[a-zA-Z]+$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a letter, not a number';
                    }
                    // If the user entered more than one letter, return an error message
                    if (value.length > 1) {
                      return 'Please enter a single letter';
                    }
                    // If the user entered a letter that has already been guessed, return an error message
                    if (widget.controller.guessedLetters.contains(value)) {
                      return 'Please enter a new guess';
                    }
                    else {
                      return null;
                    }
                },
                onFieldSubmitted: (String? value) {
                  // When the user presses the enter key, validate the input and guess the letter
                  setState(() {
                    // If the input is valid, guess the letter
                    if (_formKey.currentState!.validate() && value != null) {
                      widget.controller.guess(value.toLowerCase());
                      // If the game has ended, navigate to the result screen
                      if (widget.controller.gameEnded()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResultScreen(controller: widget.controller)),
                        );
                      }
                      guessTextController.clear();

                      // Autofocus after each guess
                      FocusScope.of(context).requestFocus(guessFocusNode);
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Evil Hangman'),
    //   ),
    //   body: elements,
    // );
  }
}