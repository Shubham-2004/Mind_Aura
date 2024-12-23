import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiEndpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';
  static const String _apiKey = 'AIzaSyDJzo9-3h1ARHFgNAxYuBG1rBCm8OLSqCQ';

  static Future<String?> generateContent(String inputText) async {
    final requestBody = json.encode({
      "contents": [
        {
          "parts": [
            {"text": inputText}
          ]
        }
      ]
    });

    try {
      final response = await http.post(
        Uri.parse('$_apiEndpoint?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      print('Response status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return response.body;
    } catch (e) {
      print('Error during API request: $e');
      return 'Error occurred during the request';
    }
  }
}
