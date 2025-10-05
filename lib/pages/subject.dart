import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_basic_app/pages/safe_scaffold.dart';
import 'package:quiz_basic_app/widgets/Clever_Rabbit.dart';
import 'package:quiz_basic_app/widgets/FlyingElephant.dart';
import 'package:quiz_basic_app/widgets/Magic_forest.dart';
import 'package:quiz_basic_app/widgets/bravelion.dart';
import 'package:quiz_basic_app/widgets/wise_turtle.dart';
import 'lesson.dart';
import 'content.dart'; // Ensure this is imported for LessonContentPage
// Note: PracticePage is not included in this code.

class SubjectPage extends StatelessWidget {
  final String className;
  SubjectPage({required this.className});

  final List<String> subjects = [
    "Math",
    "Science",
    "GK",
    "Hindi",
    "Computer",
    "English",
  ];

  IconData _getSubjectIcon(String subject) {
    switch (subject) {
      case "Math":
        return Icons.calculate;
      case "Science":
        return Icons.science;
      case "GK":
        return Icons.public;
      case "Hindi":
        return Icons.language;
      case "Computer":
        return Icons.computer;
      case "English":
        return Icons.school;
      default:
        return Icons.subject;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("$className Subjects"),
          backgroundColor: const Color.fromARGB(255, 37, 75, 107),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // This button takes the user back, but we'll handle the main navigation below.
              Navigator.pop(context);
            },
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Easy-to-read materials at your fingertips",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: const Color.fromARGB(255, 34, 33, 33),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider(color: Colors.black.withOpacity(0.3),thickness: 1,),
                SizedBox(height: 20),
                // 🔹 Subjects Grid
                GridView.builder(
                  shrinkWrap: true, // Grid apne size ke hisaab se chale
                  physics:
                      NeverScrollableScrollPhysics(), // Alag scroll disable
                  itemCount: subjects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 3 / 2,
                  ),
                  itemBuilder: (context, index) {
                    String subject = subjects[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LessonPage(
                              className: className,
                              subject: subject,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 83, 116, 155),
                              const Color.fromARGB(255, 67, 39, 110),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(66, 233, 82, 82),
                              blurRadius: 30,
                              offset: Offset(4, 6),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getSubjectIcon(subject),
                              size: 40,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              subject,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                //const SizedBox(height: 30),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stories & Kahani",
                    style: TextStyle(
                      color: Color.fromARGB(255, 40, 39, 41),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // ✅ Scrollable vertical list
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildStoryCard(
                      context,
                      "The Clever Rabbit",
                      Icons.pets,
                      Colors.orange,
                      CleverRabbitPage(),
                    ),
                    _buildStoryCard(
                      context,
                      "The Wise Turtle",
                      Icons.emoji_nature,
                      Colors.green,
                      WiseTurtlePage(),
                    ),
                    _buildStoryCard(
                      context,
                      "Magic Forest",
                      Icons.park,
                      Colors.purple,
                      MagicForestPage(),
                    ),
                    _buildStoryCard(
                      context,
                      "Flying Elephant",
                      Icons.air,
                      Colors.blue,
                      FlyingElephantPage(),
                    ),
                    _buildStoryCard(
                      context,
                      "The Brave Lion",
                      Icons.favorite,
                      Colors.red,
                      BraveLionPage(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildStoryCard(
  BuildContext context,
  String title,
  IconData icon,
  Color color,
  Widget page, {
  double height = 120,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 50, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
