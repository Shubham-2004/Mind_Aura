import 'package:flutter/material.dart';
import 'package:mindaura/presentation/screens/Consultant_chat_bot.dart';
import 'package:mindaura/presentation/screens/self_help.dart';
import 'package:mindaura/widgets/Consultcard.dart';
import 'package:mindaura/widgets/FeatureCard.dart';
import 'package:mindaura/widgets/FeelBetterCard.dart';
import 'package:mindaura/widgets/resourcecard.dart';
import 'package:mindaura/widgets/story_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: StoryPageView(),
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Feel Better . Live Better .",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.green.shade900),
                ),
              ),
              FeelBetterCard(),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.yellow.shade100],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Featurecard(
                        Path: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SelfHelpScreen()));
                        },
                        title: 'Self Help',
                        subtitle: 'Meditation, \nBreathing Techniques',
                        imagePath:
                            'https://static.vecteezy.com/system/resources/previews/000/450/909/non_2x/man-meditating-in-nature-and-leaves-concept-illustration-for-yoga-meditation-relax-recreation-healthy-lifestyle-vector-illustration-in-flat-cartoon-style.jpg'),
                    Featurecard(
                        Path: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatPage()));
                        },
                        title: 'Therapy Over Text',
                        subtitle: 'asynchronous \nChat Therapy',
                        imagePath:
                            'https://img.freepik.com/premium-vector/hand-drawn-speech-therapy-cartoon-illustration_1048368-601.jpg'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.yellow.shade100,
                    Colors.white,
                  ])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Group \nSupport",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                      Featurecard(
                          Path: () {},
                          title: 'Tide Over\nTogether',
                          subtitle: 'Support\n Group',
                          imagePath:
                              'https://thumbs.dreamstime.com/z/group-women-friends-illustration-vector-cartoon-relatives-coworkers-like-minded-different-type-female-character-get-together-131454874.jpg'),
                      Featurecard(
                          Path: () {},
                          title: 'Your Stories\n& Mine',
                          subtitle: 'Share ur\nExperience',
                          imagePath:
                              'https://thumbs.dreamstime.com/b/group-people-using-smartphone-vector-illustration-design-85518320.jpg'),
                    ],
                  ),
                ),
              ),
              ResourceCard(
                title: 'Journal',
                subtitle:
                    'Start Your Growth Journey\nCapture Moments,Reflect on\nThoughts',
                imagePath:
                    'https://as1.ftcdn.net/v2/jpg/03/76/73/66/1000_F_376736673_zv2ko1rYmPjNQJvywBFT2TcP9SCGJsU8.jpg',
                onTap: () {},
              ),
              ResourceCard(
                title: 'Resource Hub',
                subtitle: 'Self Help Articles and the Resources Center',
                imagePath:
                    'https://th.bing.com/th/id/OIP.fkLafIJ5dvio0Xyf1DIWrAHaGn?rs=1&pid=ImgDetMain',
                onTap: () {},
              ),
              Consultcard(
                  title: 'Personal Consultation',
                  subtitle:
                      'Counselling, Psychotherapy,\nExecutive Coaching, Nutritional\nCoaching and more...(Face to \n Face, Video ,Audio)',
                  imagePath:
                      'https://th.bing.com/th/id/OIP.jGzvyilJB12oYgAatFcJHQHaHa?rs=1&pid=ImgDetMain')
            ],
          ),
        ),
      ),
    );
  }
}
