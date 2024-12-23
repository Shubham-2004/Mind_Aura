import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mindaura/widgets/resourcecard.dart';
import 'package:audio_session/audio_session.dart';

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

// Example pages for navigation (create these widgets separately in your app)
class MeditationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meditation')),
      body: Center(child: Text('Content for Meditation Page')),
    );
  }
}

class GuidedBreathingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guided Breathing')),
      body: Center(child: Text('Content for Guided Breathing Page')),
    );
  }
}

class CalmingMusicPage extends StatefulWidget {
  @override
  _CalmingMusicPageState createState() => _CalmingMusicPageState();
}

class _CalmingMusicPageState extends State<CalmingMusicPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Example calming music playlist
  final List<Map<String, String>> _calmingMusicPlaylist = [
    {
      'title': 'Morning Serenity',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'
    },
    {
      'title': 'Gentle Breeze',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'
    },
    {
      'title': 'Ocean Waves',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'
    },
    {
      'title': 'Happy Meditation',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3'
    },
    {'title': 'Solo', 'url': 'https://samplesongs.netlify.app/Solo.mp3'},
    {
      'title': 'Relaxing Music',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3'
    },
    {
      'title': 'Meditation Music',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3'
    },
  ];

  String? _currentlyPlaying;

  @override
  void initState() {
    super.initState();
    _setupAudioSession();
  }

  Future<void> _setupAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
  }

  Future<void> _playMusic(String url, String title) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      setState(() {
        _currentlyPlaying = title;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _stopMusic() async {
    await _audioPlayer.stop();
    setState(() {
      _currentlyPlaying = null;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose a Music Track',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Relax and unwind with these calming tracks:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _calmingMusicPlaylist.length,
                itemBuilder: (context, index) {
                  final track = _calmingMusicPlaylist[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(Icons.music_note, color: Colors.green),
                      title: Text(track['title']!),
                      subtitle: Text('Tap to play'),
                      trailing: _currentlyPlaying == track['title']
                          ? IconButton(
                              icon: Icon(Icons.stop, color: Colors.red),
                              onPressed: _stopMusic,
                            )
                          : Icon(Icons.play_arrow, color: Colors.green),
                      onTap: () => _playMusic(track['url']!, track['title']!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmotionalWellbeingAssessmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emotional Wellbeing Assessment')),
      body: Center(
          child: Text('Content for Emotional Wellbeing Assessment Page')),
    );
  }
}

class RelaxationAndSleepMusicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Relaxation and Sleep Music')),
      body: Center(child: Text('Content for Relaxation and Sleep Music Page')),
    );
  }
}
