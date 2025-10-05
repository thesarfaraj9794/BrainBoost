import 'package:flutter/material.dart';
class FlyingElephantPage extends StatelessWidget {
  const FlyingElephantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlyingElephant'),
        backgroundColor: Colors.blue,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text( "Once there was an elephant who always dreamed of flying. "
                    "One day, a fairy appeared and gave him magical wings. "
                    "The elephant flew high over the jungle and helped animals in need. "
                    "But he became proud and stopped listening to the fairy. "
                    "His wings vanished, and he learned to be humble again. 🐘💫",
                    style: TextStyle(fontSize: 18, height: 1.5),
                    ),
                    Image.asset('assets/images/kkk.png'),
            ],
          ),
        ),
      ),
    );
  }
}