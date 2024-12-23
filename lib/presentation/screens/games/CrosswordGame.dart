import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CrosswordGame extends StatefulWidget {
  @override
  _CrosswordGameState createState() => _CrosswordGameState();
}

class _CrosswordGameState extends State<CrosswordGame> {
  final List<String> words = [
    'APPLE',
    'BANANA',
    'ORANGE',
    'GRAPE',
    'PEAR',
    'MANGO',
    'CHERRY',
    'PINEAPPLE',
    'KIWI',
    'PEACH',
  ];
  String? currentWord;
  List<String> grid = [];
  List<bool> selectedIndices = [];
  int score = 0;
  int timeLeft = 30;
  Timer? timer;
  String selectedWord = '';
  bool showScoreUpdate = false;

  @override
  void initState() {
    super.initState();
    startNewWord();
  }

  void startNewWord() {
    setState(() {
      // Shuffle and pick a random word
      words.shuffle();
      currentWord = words.first;

      // Generate a grid with the current word and random letters
      grid = generateGrid(currentWord!);
      selectedIndices = List.generate(grid.length, (_) => false);
      timeLeft = 30;
      selectedWord = '';
      showScoreUpdate = false;
    });

    // Start the timer
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          gameOver();
        }
      });
    });
  }

  List<String> generateGrid(String word) {
    // Create a grid with random letters and insert the word
    List<String> grid = List.generate(16, (_) {
      return String.fromCharCode(Random().nextInt(26) + 65); // Random A-Z
    });

    // Insert the word into random grid positions
    int startIndex = Random().nextInt(grid.length - word.length);
    for (int i = 0; i < word.length; i++) {
      grid[startIndex + i] = word[i];
    }
    return grid;
  }

  void checkWord() {
    if (selectedWord == currentWord) {
      setState(() {
        score += 10;
        showScoreUpdate = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          showScoreUpdate = false;
        });
        startNewWord();
      });
    } else {
      gameOver();
    }
  }

  void gameOver() {
    timer?.cancel();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over!'),
        content: Text('Your Score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
    });
    startNewWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
          'Crossword Game',
          style: TextStyle(color: Colors.grey.shade100),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Find the word: $currentWord',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Time Left: $timeLeft',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 20),
            if (showScoreUpdate)
              Text(
                '+10',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: grid.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWord += grid[index];
                        selectedIndices[index] = true;
                        if (selectedWord.length == currentWord!.length) {
                          checkWord();
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            selectedIndices[index] ? Colors.green : Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        grid[index],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Score: $score',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
