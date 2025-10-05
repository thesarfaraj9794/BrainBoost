// result.dart
import 'package:flutter/material.dart';
import 'package:quiz_basic_app/pages/safe_scaffold.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int total;

  ResultPage({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    // Determine the result message and color based on the score
    String resultMessage;
    Color resultColor;
    String animationAsset; // You can use a local asset or a network URL for animation

    final double percentage = (score / total) * 100;

    if (percentage >= 80) {
      resultMessage = "Excellent! You are a quiz win!";
      resultColor = Colors.green;
      animationAsset = "assets/images/win3.png"; // Replace with your animation image path
    } else if (percentage >= 50) {
      resultMessage = "Good job! Keep practicing.";
      resultColor = Colors.orange;
      animationAsset = "assets/images/try1.png"; // Replace with your animation image path
    } else {
      resultMessage = "You can do better! Try again.";
      resultColor = Colors.red;
      animationAsset = "assets/images/lose.png"; // Replace with your animation image path
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Quiz Result",style: TextStyle(color: Colors.white),),
        //backgroundColor: const Color.fromARGB(255, 58, 57, 109),
         backgroundColor: const Color.fromARGB(255, 37, 75, 107),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // This button takes the user back, but we'll handle the main navigation below.
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 73, 79, 167), const Color.fromARGB(255, 179, 171, 170)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Displaying an image or an animation based on the score
                Image.asset(
                  animationAsset, // Use your custom image assets here
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text(
                  resultMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Score card
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                    child: Column(
                      children: [
                        Text(
                          "Your Score",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$score / $total",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // Back to home button
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate back to the home page by popping all routes until the first one
                    //Navigator.popUntil(context, (route) => route.isFirst);
                     Navigator.pop(context); // This will pop the current screen (ResultPage) and go back to the previous one (LessonContentPage).
                  },
                  icon: Icon(Icons.play_lesson, color: Colors.white),
                  label: Text(
                    "Back to Lesson",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 48, 129, 125),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}