import 'dart:math';

class EvilHangmanGame {
  Set<String> totalWordSet = {};
  Set<String> currWordSet = {};
  Set<String> guessedLetters = {};
  bool started = false;
  int wordLength = 0;
  int numGuesses = 0;
  bool displaySizeOfWordSet = false;
  String displayWord = "";

  EvilHangmanGame (List<String> wordList) {
    totalWordSet.addAll(wordList);
  }

  /**
   * Starts a new game with the given parameters.
   * Returns a not empty set of words if the game can be started.
   */
  bool startGame(int wordLength, int numGuesses, bool display) {
    this.started = true;
    this.wordLength = wordLength;
    this.numGuesses = numGuesses;
    this.displaySizeOfWordSet = display;

    currWordSet.clear();
    guessedLetters.clear();

    totalWordSet.forEach((word) {
      if (word.length == this.wordLength) {
        currWordSet.add(word);
      }
    });
    displayWord = "";
    for (int i = 0; i < wordLength; i++) {
      displayWord += "-";
    }
    return currWordSet.isNotEmpty; 
  }

  /**
   * Game guesses.
   * - Eliminate the guessed letter after the user has guessed it.
   * - Update the display word through a map of string and set of string where
   *    the string is the display word and the set of string is the set of words 
   *    that could match the display word.
   * - Choose the word family with the largest number of words. If there are
   *   multiple word families with the same number of words, choose the one
   *   that contains a dash.
   * - If the display word does not change, decrement the number of guesses.
   * - Return the display word.
   */
  void guess(String letter) {
    if (!guessedLetters.contains(letter)) {
      guessedLetters.add(letter);
      String oldDisplayWord = displayWord;
      Map<String, Set<String>> wordFamilyMap = Map();
      currWordSet.forEach((word) {
        String wordFamily = getDisplayWord(word, guessedLetters);
        if (wordFamilyMap[wordFamily] == null) {
          wordFamilyMap[wordFamily] = {word};
        } else {
          wordFamilyMap[wordFamily]?.add(word);
        }
      });
      // Choose the word family with the largest number of words. If there are
      // multiple word families with the same number of words, choose the one
      // that contains a dash.
      int maxSize = 0;
      wordFamilyMap.values.forEach((wordSet) {
        String wordFamily = getDisplayWord(wordSet.first, guessedLetters);
        if (wordSet.length > maxSize || 
            (wordSet.length == maxSize && wordFamily.contains('-'))) {
              maxSize = wordSet.length;
              currWordSet = wordSet;
              displayWord = wordFamily;
        }
       });
      if (displayWord == oldDisplayWord) {
        numGuesses--;
      }
    }
  }

  /**
   * Returns true if the game has ended.
   */
  bool gameEnded() {
    return numGuesses <= 0 || !displayWord.contains('-');
  }

  /**
   * Returns true if the user has won the game.
   */
  bool isWon() {
    return !displayWord.contains('-');
  }

  /**
   * Returns the display word.
   */
  String getDisplayWord(String word, Iterable<String> guessedLetters) {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < word.length; i++) {
      sb.write(guessedLetters.contains(word[i]) ? word[i] : '-');
    }
    return sb.toString();
  }

  /**
   * Returns the secret word through a random number generator.
   */
  String getSecretWord() {
    int index = Random().nextInt(currWordSet.length) + 1;
    var iter = currWordSet.iterator;
    while (index-- > 0) {
      iter.moveNext();
    }
    return iter.current;
  }
}