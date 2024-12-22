import 'package:flutter/material.dart';
import 'package:mindaura/presentation/screens/more_stories.dart';
import 'package:story_view/story_view.dart';

class StoryPageView extends StatelessWidget {
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 180,
              child: StoryView(
                controller: controller,
                storyItems: [
                  StoryItem.inlineImage(
                    url:
                        "https://th.bing.com/th/id/OIP.CT8XF7wbhERbzHPZhdWBKQHaE7?rs=1&pid=ImgDetMain",
                    controller: controller,
                    caption: Text(
                      "Nurturing your mental\n  wellness through AI.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  StoryItem.text(
                    textStyle: TextStyle(
                      color: Colors.grey.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    title:
                        "To keep the body in good health is a duty... otherwise we shall not be able to keep our mind strong and clear. \n- Gautam Buddha",
                    backgroundColor: Colors.yellow.shade200,
                    roundedTop: true,
                  ),
                  StoryItem.inlineImage(
                    url:
                        "https://img.freepik.com/premium-photo/brain-lifts-weights-gym-ai-generated_990017-5808.jpg",
                    controller: controller,
                    caption: Text(
                      "Empower your mind, embrace your wellness.",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
                onStoryShow: (storyItem, index) {
                  print("Showing a story");
                },
                progressPosition: ProgressPosition.top,
                repeat: true,
                inline: true,
              ),
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MoreStories()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8))),
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "View more stories",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
