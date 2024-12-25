import 'package:flutter/material.dart';
import 'package:mindaura/presentation/tools/anxiety_tracker.dart';
import 'package:mindaura/presentation/tools/goal_tracker.dart';
import 'package:mindaura/presentation/tools/mood_tracker.dart';
import 'package:mindaura/widgets/resourcecard.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
          'Tools and Other Resources',
          style: TextStyle(
              color: Colors.grey.shade200, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ResourceCard(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MoodTrackerPage()));
                },
                title: 'Mood Tracker 😎',
                subtitle: 'Track your mood daily for better mood tomorrow',
                imagePath:
                    'https://media.istockphoto.com/id/1304715758/vector/emotions-scale-with-arrow-from-green-to-red-tiny-people-leave-feedback-emoji-set-for-mood.jpg?s=612x612&w=0&k=20&c=1TrS6mLDm7rSmQN1tz8T1xZqHvYlEi-F4ONR4nup9WE='),
            ResourceCard(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoalTrackerPage()));
                },
                title: 'Habit/Goal Tracker 🎯',
                subtitle: 'Make the goal and try to achieve it',
                imagePath:
                    'https://static.vecteezy.com/system/resources/previews/000/963/040/original/cartoon-boy-tracking-goals-vector.jpg'),
            ResourceCard(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FaceDetectionScreen()));
                },
                title: 'Anxiety Tracker',
                subtitle: 'Track your Anxiety',
                imagePath:
                    'https://th.bing.com/th/id/OIP.iK4tTdHkKdWg59xtEsZGkAHaHa?pid=ImgDet&w=474&h=474&rs=1')
          ],
        ),
      ),
    );
  }
}
