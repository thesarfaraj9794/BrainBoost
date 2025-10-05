import 'package:flutter/material.dart';

class CleverRabbitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Clever Rabbit"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Once upon a time, a clever rabbit lived in a forest. "
                "One day, a lion started hunting animals every day. "
                "When it was the rabbit’s turn, he made a plan to outsmart the lion. "
                "He led the lion to a deep well, saying another lion lived inside. "
                "When the lion looked inside and saw his own reflection, he roared and jumped in, thinking it was his enemy. "
                "The lion drowned, and all animals were safe again. 🦁🐇",
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
