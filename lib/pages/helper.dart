import 'dart:convert';
import 'package:flutter/services.dart';

class JsonHelper {
  // Static variables to cache data
  static Map<String, dynamic>? lessonData;
  static Map<String, dynamic>? quizData;

  /// Load lesson_content.json once
  static Future<void> loadLessonContent() async {
    if (lessonData == null) {
      String data = await rootBundle.loadString('assets/lesson_contents.json');
      lessonData = jsonDecode(data);
    }
  }

  /// Load quiz_content.json once
  static Future<void> loadQuizContent() async {
    if (quizData == null) {
      String data = await rootBundle.loadString('assets/quiz_contents.json');
      quizData = jsonDecode(data);
    }
  }

  /// Get lesson content by class, subject, lesson
  static Map<String, dynamic>? getLesson(String className, String subject, String lesson) {
    return lessonData?[className]?[subject]?[lesson];
  }

  /// Get quiz content by class, subject, lesson
  static List<dynamic>? getQuiz(String className, String subject, String lesson) {
    return quizData?[className]?[subject]?[lesson];
  }
}
