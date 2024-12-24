import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mindaura/models/quotes_model.dart';

// Main Widget
class MindAuraBlogs extends StatefulWidget {
  const MindAuraBlogs({super.key});

  @override
  State<MindAuraBlogs> createState() => _MindAuraBlogsState();
}

class _MindAuraBlogsState extends State<MindAuraBlogs> {
  List<Quotes> quotes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuotesFromAssets();
  }

  Future<void> loadQuotesFromAssets() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/quotes.json');
      setState(() {
        quotes = quotesFromJson(jsonString);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error loading quotes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mind Aura Quotes',
          style: TextStyle(color: Colors.grey.shade200),
        ),
        backgroundColor: Colors.grey.shade700,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : quotes.isEmpty
              ? const Center(
                  child: Text(
                    "No quotes available.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    final quote = quotes[index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '"${quote.quote}"',
                              style: const TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "- ${quote.author ?? "Unknown"}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
