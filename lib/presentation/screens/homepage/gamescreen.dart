import 'package:flutter/material.dart';
import 'package:mindaura/presentation/screens/games/CrosswordGame.dart';
import 'package:mindaura/presentation/screens/games/brickbreaker.dart';
import 'package:mindaura/widgets/FeatureCard.dart';
import 'package:mindaura/widgets/resourcecard.dart';

class Gamescreen extends StatefulWidget {
  const Gamescreen({super.key});

  @override
  State<Gamescreen> createState() => _GamescreenState();
}

class _GamescreenState extends State<Gamescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
          'Playing Mindfull Games',
          style: TextStyle(
              color: Colors.grey.shade100, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ResourceCard(
                title: 'Crossword Game',
                subtitle: 'Puzzle Your Way to Glory!',
                imagePath:
                    'https://th.bing.com/th/id/OIP.xVQxbV8DN5hcII9V_-ehIAHaHa?rs=1&pid=ImgDetMain',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CrosswordGame()));
                }),
            ResourceCard(
                title: 'Brick Breaker',
                subtitle: 'Ball vs Brick: The Ultimate Showdown',
                imagePath:
                    'https://th.bing.com/th/id/OIP._1CuSN6nWukD8mwPYRT5LQHaDt?rs=1&pid=ImgDetMain',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrickBreakerGame()));
                }),
          ],
        ),
      ),
    );
  }
}
