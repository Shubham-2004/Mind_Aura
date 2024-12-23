import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
