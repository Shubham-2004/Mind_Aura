import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://healthybodymindsolution.com/wp-content/uploads/2020/07/Meditation.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),

          alignment: Alignment.center, // Centers the text
          child: Text(
            "More Stories",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: StoryView(
          storyItems: [
            StoryItem.pageImage(
              url:
                  "https://selfhelpnirvana.com/wp-content/uploads/2020/02/Meditation-Quote-03.jpg",
              caption: Text(
                "Mindfulness and meditation",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              controller: storyController,
            ),
            StoryItem.pageImage(
              url:
                  "https://th.bing.com/th/id/OIP.-SV8opgChclrzXIBRXNOdAHaGI?w=1024&h=849&rs=1&pid=ImgDetMain",
              caption: Text(
                "Healthy mind, healthy life",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              controller: storyController,
            ),
            StoryItem.pageImage(
              url: "https://i.ytimg.com/vi/xFlX6IFoE2c/maxresdefault.jpg",
              caption: Text(
                "Stay positive and happy",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              controller: storyController,
            ),
          ],
          onStoryShow: (storyItem, index) {
            print("Showing a story");
          },
          onComplete: () {
            print("Completed a cycle");
          },
          progressPosition: ProgressPosition.top,
          repeat: false,
          controller: storyController,
        ),
      ),
    );
  }
}
