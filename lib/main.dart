import 'package:flutter/material.dart';
import 'evilhangman.dart';
import 'setupscreen.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// This is the main class of the application. It is responsible for loading the
// dictionary file and passing it to the SetupScreen.
class _MyAppState extends State<MyApp> {
  EvilHangmanGame controller = EvilHangmanGame([]);

  @override
  void initState() {
    super.initState();

    // load the dictionary file
    rootBundle.loadString('assets/dictionary.txt').then((String result) {
      setState(() {
        controller = EvilHangmanGame(result.split('\n'));
      });
    });
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evil Hangman Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SetupScreen(controller: controller) // Pass the controller to the SetupScreen
    );
  }
}