import 'package:flutter/material.dart';
import 'package:mindaura/presentation/self_help/breathingguide.dart';
import 'package:mindaura/presentation/self_help/calming_music.dart';
import 'package:mindaura/presentation/self_help/emotional_wellbeing.dart';
import 'package:mindaura/presentation/self_help/meditation.dart';
import 'package:mindaura/presentation/self_help/relaxation.dart';
import 'package:mindaura/widgets/resourcecard.dart';

class SelfHelpScreen extends StatefulWidget {
  const SelfHelpScreen({super.key});

  @override
  State<SelfHelpScreen> createState() => _SelfHelpScreenState();
}

class _SelfHelpScreenState extends State<SelfHelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 100,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Self Help Resources',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Choose A Category',
                style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.w500,
                    fontSize: 26),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 8),
          child: Column(
            children: [
              ResourceCard(
                title: 'Meditation',
                subtitle: 'Give a sense of calm, peace\nand balance',
                imagePath:
                    'https://th.bing.com/th/id/OIP.ugF89jPITxklMQSksvxccwHaHa?rs=1&pid=ImgDetMain',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MeditationPage(),
                    ),
                  );
                },
              ),
              ResourceCard(
                title: 'Guided Breathing',
                subtitle:
                    'Promote effective and healthy\nbreathing and breath control',
                imagePath:
                    'https://media.istockphoto.com/vectors/abdominal-breathing-woman-practicing-belly-breathing-for-good-breath-vector-id1331393470?k=20&m=1331393470&s=612x612&w=0&h=xk1ru01rONO_qCRYUGrVwjTY1DUcAkxAGfklYUuqrck=',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuidedBreathingPage(),
                    ),
                  );
                },
              ),
              ResourceCard(
                title: 'Calming Music',
                subtitle: 'Music to help release stress and\nrelax your mind',
                imagePath:
                    'https://media.istockphoto.com/vectors/woman-doing-yoga-listening-to-music-at-home-female-character-in-in-vector-id1224192614?k=6&m=1224192614&s=612x612&w=0&h=P29nxIOdpGwU8GojCtK61lFAA2uGHaIolEPvQUKiokE=',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalmingMusicPage(),
                    ),
                  );
                },
              ),
              ResourceCard(
                title: 'Assess Your Emotional Wellbeing',
                subtitle:
                    'Quick assesment to recognze\nyour present emotional state',
                imagePath:
                    'https://as2.ftcdn.net/v2/jpg/04/61/90/65/1000_F_461906599_t8LuKOCO244NCaVEDLWrMCiqeuKeOEPl.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmotionalWellbeingAssessmentPage(),
                    ),
                  );
                },
              ),
              ResourceCard(
                title: 'Music For Relaxation and Sleep',
                subtitle: 'Melodies to help you relax and\ndrift to sleep',
                imagePath:
                    'https://th.bing.com/th/id/OIP.27uEKVKkBGm9GjHghcrTNAHaFE?rs=1&pid=ImgDetMain',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelaxationAndSleepMusicPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
