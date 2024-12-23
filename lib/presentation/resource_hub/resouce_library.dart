import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ResourceLibrary extends StatefulWidget {
  const ResourceLibrary({super.key});

  @override
  State<ResourceLibrary> createState() => _ResourceLibraryState();
}

class _ResourceLibraryState extends State<ResourceLibrary> {
  List articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    const String apiKey = "ff0e452b2a784f6b9d186a1210c914c2";
    const String apiUrl =
        "https://newsapi.org/v2/everything?q=apple&from=2024-12-22&to=2024-12-22&sortBy=popularity&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = data['articles'].take(10).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load articles");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error fetching articles: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        centerTitle: true,
        title: Text(
          'Resource Library',
          style: TextStyle(
            color: Colors.green.shade200,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : articles.isEmpty
              ? const Center(
                  child: Text(
                    "No articles found.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article['urlToImage'] != null)
                            Image.network(
                              article['urlToImage'],
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              article['title'] ?? "No Title",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              article['description'] ?? "No Description",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Published At: ${article['publishedAt']}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                final url = article['url'];
                                if (url != null) {
                                  _launchURL(url);
                                }
                              },
                              child: const Text(
                                "Read More",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

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
}
