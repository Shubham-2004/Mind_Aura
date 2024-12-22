import 'package:flutter/material.dart';
import 'package:mindaura/presentation/screens/Consultant_chat_bot.dart';

class FeelBetterCard extends StatelessWidget {
  const FeelBetterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ChatPage()));
      },
      child: Card(
        color: Colors.green.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 10.0, top: 12.0, bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Instant Live Chat',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Feel Better in 15 Using AI',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Stressed, Angry, Worried? \nA Live Chat with our Psychologists AI',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Available everyday between\n09:00 AM - 09:00 PM',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                height: 120,
                child: Image.network(
                  "https://www.tutoroot.com/images/privileged/privileged-03.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
