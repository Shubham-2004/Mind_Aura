import 'package:flutter/material.dart';
import 'package:mindaura/presentation/screens/auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/007/701/054/large_2x/poster-design-for-mental-health-with-boy-and-girl-free-vector.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  Text(
                    'Mind Aura',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nurturing your mental\n  wellness through AI.',
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Reflect • Connect • Thrive',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 48),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.yellow.shade200,
                          Colors.yellow.shade700,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Step into Serenity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
