import 'package:flutter/material.dart';

class MagicForestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magic Forest"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Deep inside the mountains, there was a forest full of magic trees. "
                "Every tree could talk, and flowers glowed at night. "
                "One day, a lost boy entered the forest crying. "
                "The trees whispered to him, showing him the path home. "
                "Before leaving, the boy promised to protect the forest forever. 🌳🌟",
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
