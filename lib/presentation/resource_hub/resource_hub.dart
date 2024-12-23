import 'package:flutter/material.dart';
import 'package:mindaura/presentation/resource_hub/mind_aura_blogs.dart';
import 'package:mindaura/presentation/resource_hub/resouce_library.dart';
import 'package:mindaura/widgets/resourcecard.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceHubScreen extends StatefulWidget {
  const ResourceHubScreen({super.key});

  @override
  State<ResourceHubScreen> createState() => _ResourceHubScreenState();
}

class _ResourceHubScreenState extends State<ResourceHubScreen> {
  String url = 'https://mentaltreat.com/search-professionals/';

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      )) {
        throw Exception('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Welcome to Mind Aura\n     Resource Hub !!',
            style: TextStyle(
                color: Colors.green.shade800,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          ResourceCard(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResourceLibrary()));
              },
              title: 'Library/Articles',
              subtitle: 'Articles on Mental Health',
              imagePath:
                  'https://th.bing.com/th/id/OIP.rWFeqmcnCfpMLCuLQo6yOAHaFs?rs=1&pid=ImgDetMain'),
          ResourceCard(
              onTap: () {
                _launchURL(url);
              },
              title: 'Resource Centers',
              subtitle: 'Contacts details of the Resource center',
              imagePath:
                  'https://th.bing.com/th/id/OIP.DwzwmXIuhpUQh9HDT6QaJwHaFN?rs=1&pid=ImgDetMain'),
          ResourceCard(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MindAuraBlogs()));
              },
              title: 'The Mind Aura Quotes',
              subtitle: 'The Quotes of the Day, from\nThe Famous Personalities',
              imagePath:
                  'https://th.bing.com/th/id/OIP.AbHe2OCkoxGcIDkPNCGPKgAAAA?rs=1&pid=ImgDetMain'),
        ]),
      ),
    );
  }
}
