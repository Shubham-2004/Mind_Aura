import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GuidedBreathingPage extends StatefulWidget {
  @override
  State<GuidedBreathingPage> createState() => _GuidedBreathingPageState();
}

class _GuidedBreathingPageState extends State<GuidedBreathingPage> {
  // Predefined list of meditation video links and titles
  final List<Map<String, String>> _videoLinks = [
    {
      'title': 'Breathing Exercise 1',
      'url': 'https://www.youtube.com/shorts/y9jbHCRq9Ho?feature=share',
    },
    {
      'title': 'Breathing Exercise 2',
      'url': 'https://www.youtube.com/shorts/kw9y4cGbnWQ?feature=share',
    },
    {
      'title': 'Breathing Exercise 3',
      'url': 'https://youtu.be/-7-CAFhJn78?feature=shared',
    },
    {
      'title': 'Breathing Exercise 4',
      'url': 'https://youtu.be/395ZloN4Rr8?feature=shared',
    },
  ];

  YoutubePlayerController? _youtubeController;

  // Extracts video ID from a YouTube URL
  String extractVideoId(String url) {
    if (url.isEmpty) return '';

    Uri? uri = Uri.tryParse(url);
    if (uri == null) return '';

    // Handle YouTube Shorts URL format
    if (url.contains('shorts')) {
      final shortsPath = uri.pathSegments.indexOf('shorts');
      if (shortsPath != -1 && shortsPath + 1 < uri.pathSegments.length) {
        return uri.pathSegments[shortsPath + 1];
      }
    }

    // Handle regular YouTube URL
    if (uri.pathSegments.contains('watch')) {
      return uri.queryParameters['v'] ?? '';
    }

    return uri.pathSegments.last;
  }

  void _loadVideo(String videoUrl) {
    final videoId = extractVideoId(videoUrl);
    if (videoId.isNotEmpty) {
      if (_youtubeController != null) {
        _youtubeController!.load(videoId);
      } else {
        setState(() {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              useHybridComposition: true,
            ),
          );
        });
      }
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
          'Breathing Guide Videos',
          style: TextStyle(color: Colors.grey.shade200),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select a Meditation Video to Watch',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),

            // Horizontal list of video cards
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _videoLinks.length,
                itemBuilder: (context, index) {
                  final video = _videoLinks[index];
                  return GestureDetector(
                    onTap: () {
                      _loadVideo(video['url']!); // Load the selected video
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.video_library,
                              size: 50,
                              color: Colors.greenAccent,
                            ),
                            SizedBox(height: 8),
                            Text(
                              video['title']!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // YouTube Player or placeholder text
            if (_youtubeController != null)
              Expanded(
                child: YoutubePlayer(
                  controller: _youtubeController!,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print("Video is ready to play.");
                  },
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Text(
                    'Please select a meditation video to watch.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
