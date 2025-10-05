import 'package:flutter/material.dart';
import 'package:quiz_basic_app/pages/result.dart';
import 'package:quiz_basic_app/pages/subject.dart';
import 'pages/home.dart';
import 'pages/result.dart';

void main() {
  runApp(EducationApp());
}

class EducationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Education App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
