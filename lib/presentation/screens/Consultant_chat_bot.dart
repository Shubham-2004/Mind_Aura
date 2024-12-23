// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mindaura/backend/api_service.dart';
import 'package:mindaura/widgets/bot_chat_text.dart';
import 'package:mindaura/widgets/my_chat_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  List messages = [];
  String prompt =
      "You are a therapy assistant bot. Your primary role is to provide compassionate and supportive text-based therapy to individuals experiencing various mental health conditions such as anxiety, depression, and stress. Respond to their concerns with empathy, offer calming exercises, suggest positive coping strategies, and encourage self-reflection. Maintain a warm and understanding tone, ensuring a safe and non-judgmental space for users to express themselves. Adapt your guidance to suit their unique needs and provide resources or suggestions to help them manage their mental well-being effectively.";

  Future<void> getAnswers(String userQuery) async {
    String? response = await ApiService.generateContent(prompt + userQuery);

    if (response != null) {
      try {
        // Parse the response
        final Map<String, dynamic> jsonResponse = json.decode(response);
        final List<dynamic>? parts = jsonResponse['candidates']?[0]['content']
                ?['parts']?[0]?['text']
            ?.split(' ');

        if (parts != null && parts.isNotEmpty) {
          setState(() {
            messages.add(BotChatText(
                text: parts.join(' '))); // Combine parts into a single response
          });
        } else {
          setState(() {
            messages.add(BotChatText(
              text:
                  "I'm sorry, I couldn't process your request. Please try again later.",
            ));
          });
        }
      } catch (e) {
        setState(() {
          messages.add(BotChatText(
            text: "An error occurred while processing the response.",
          ));
        });
      }
    } else {
      setState(() {
        messages.add(BotChatText(
          text:
              "I'm sorry, I couldn't process your request. Please try again later.",
        ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showFeatureDialog();
    });
  }

  void _showFeatureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Meet Your Virtual Wellness Consultant',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          content: Text(
            'Here you can chat with our AI-powered consultant to get instant help and support.',
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey.shade600,
            )),
        title: Column(
          children: [
            Text(
              'Feel Better in 15 Seconds',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600),
            ),
            Text(
              'Press Back to exit this Chat',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600),
            )
          ],
        ),
        backgroundColor: Colors.grey.shade100,
      ),
      body: Container(
        padding: EdgeInsets.all(15).copyWith(top: 10, bottom: 10),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.yellow.shade100,
            Colors.yellow.shade200,
            Colors.yellow.shade100,
          ],
        )),
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(bottom: 60),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messages[index];
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        controller: messageController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter your message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.black),
                            onPressed: () {
                              final userMessage = messageController.text;
                              if (userMessage.isNotEmpty) {
                                setState(() {
                                  messages.add(MyChatText(
                                    text: userMessage,
                                    images: [],
                                  ));
                                  messageController.clear();
                                });
                                getAnswers(userMessage);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
