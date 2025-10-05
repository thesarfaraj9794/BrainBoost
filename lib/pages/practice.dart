import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'result.dart';
import 'helper.dart';

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question({required this.question, required this.options, required this.correctIndex});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctIndex: json['correctIndex'],
    );
  }
}

class PracticePage extends StatefulWidget {
  final String className;
  final String subject;
  final String lesson;

  PracticePage({
    required this.className,
    required this.subject,
    required this.lesson,
  });

  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage>
    with SingleTickerProviderStateMixin {
  List<Question> questions = [];
  int currentQuestion = 0;
  int score = 0;
  bool isLoading = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    loadQuestions();

    // 👇 Animation Controller for floating image
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // repeat with bounce effect

    // 👇 Scale Animation from 1.0 to 1.2
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadQuestions() async {
    try {
      await JsonHelper.loadQuizContent();
      final quizData =
          JsonHelper.getQuiz(widget.className, widget.subject, widget.lesson);

      if (quizData != null && quizData is List) {
        setState(() {
          questions = quizData.map((q) => Question.fromJson(q)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          questions = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading quiz questions: $e");
      setState(() {
        questions = [];
        isLoading = false;
      });
    }
  }

  void checkAnswer(int selectedIndex) {
    if (questions.isEmpty) return;

    if (selectedIndex == questions[currentQuestion].correctIndex) {
      score++;
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultPage(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading Quiz...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Quiz Not Found")),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Sorry, no quiz is available for this lesson. Please check back later!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
          ),
        ),
      );
    }

    var q = questions[currentQuestion];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("${widget.subject} Quiz")),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Question ${currentQuestion + 1}/${questions.length}",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    q.question,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ...List.generate(q.options.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(index),
                        child: Text(q.options[index]),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // ✅ Animated Floating Image
            Positioned(
              bottom: 20,
              right: 20,
              child: ScaleTransition(
                scale: _animation, 
                child: GestureDetector(
                  onTap: () {
                    //print("Animated Image Clicked!");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      "assets/images/kkk.png",
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
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
