import 'package:flutter/material.dart';
import 'evilhangman.dart';
import 'gamescreen.dart';

/**
 * This class is responsible for setting up the game. It asks the user for the
 * word length, number of guesses, and whether or not to display the size of the
 * word set. It then passes this information to the GameScreen.
 */
class SetupScreen extends StatefulWidget {
  final EvilHangmanGame controller;
  const SetupScreen({
    super.key,
    required this.controller,
  });

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String wordLength = "";
  String numGuesses = "";
  bool displaySizeOfWordSet = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /**
   * This method builds the setup screen.
   */
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold( 
      appBar: AppBar(
        title: const Text(
          'EVIL HANGMAN',
          style: TextStyle(
            color: Color.fromARGB(255, 185, 35, 85), 
            fontFamily: 'Silkscreen',
          fontWeight: FontWeight.bold,),
          ),
          centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'How long do you want the word to be?',
                labelText: 'Word Length',
                hintStyle: TextStyle(
                  fontSize: 15, 
                  color:  Color.fromARGB(255, 227, 125, 159),
                  fontFamily: 'Advent_Pro'
                ),  
                labelStyle: TextStyle(
                  fontSize: 17, 
                  color: Color.fromARGB(255, 204, 95, 132),
                  fontFamily: 'Silkscreen'
                ),
              
              ), 
              // When the user changes the text, store it in the wordLength variable
              onChanged: (String? value) { 
                setState(() {
                  wordLength = (value != null) ? value : "";
                });
              },
              // Validate the input
              validator: (String? value) {
                // If the user did not enter anything, return an error message
                if (value == null || value.isEmpty) {
                  return 'Please enter a value for word length';
                }
                
                int? parsedValue = int.tryParse(value);

                // If the user entered something that is not a number, return an error message
                if (parsedValue == null) {
                  return 'Please enter a valid number';
                }
                // If the user entered a number that is not between 2 and 29, return an error message
                if (parsedValue <= 1 || parsedValue > 29) {
                  return 'Please enter a number between 2 and 29. Try again!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'How many guesses do you want?',
                labelText: 'Number of Guesses',
                hintStyle: TextStyle(
                  fontSize: 15, 
                  color: Color.fromARGB(255, 227, 125, 159),
                  fontFamily: 'Advent_Pro'
                ), 
                labelStyle: TextStyle(
                  fontSize: 17, 
                  color:  Color.fromARGB(255, 204, 95, 132),
                  fontFamily: 'Silkscreen'
                ),
              ),
              // When the user changes the text, store it in the numGuesses variable
              onChanged: (String? value) {
                setState(() {
                  numGuesses = (value != null) ? value : "";
                });
              },
              // Validate the input
              validator: (String? value) {
              // If the user did not enter anything, return an error message
              if (value == null || value.isEmpty) {
                return 'Please enter a value for the number of guesses';
              }

              int? parsedValue = int.tryParse(value);

              // If the user entered something that is not a number, return an error message
              if (parsedValue == null) {
                return 'Please enter a valid number';
              }

              // If the user entered a number that is not between 1 and 26, return an error message
              if (parsedValue <= 0 || parsedValue > 26) {
                return 'Please enter a number between 1 and 26. Try again!';
              }

              return null;
            },
            ),
            Column(
              children: [
                // Switch to display the size of the word set
                Switch(
                  value: displaySizeOfWordSet,
                  activeColor: const Color.fromARGB(255, 227, 125, 159),
                  onChanged: (bool value) {
                    setState(() {
                      displaySizeOfWordSet = value;
                    });
                  },
                ),
                const Text(
                  'Display Size of Word Set', // Your description text
                  style: TextStyle(
                    fontSize: 15, 
                    color: Color.fromARGB(255, 236, 81, 133),
                    fontFamily: 'Silkscreen'
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                    widget.controller.startGame(int.parse(wordLength), int.parse(numGuesses), displaySizeOfWordSet);
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => GameScreen(controller: widget.controller))
                    );
                  }
                },
                child: const Text(
                  'START GAME',
                  style: TextStyle(
                    color: Color.fromARGB(255, 225, 66, 119),
                    fontFamily: 'Silkscreen',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}