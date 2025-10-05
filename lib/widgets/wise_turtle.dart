import 'package:flutter/material.dart';

class WiseTurtlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Wise Turtle"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "There was once a wise turtle who lived in a pond with two geese. "
                "When the pond started drying up, the geese decided to fly to a new place. "
                "The turtle asked them to help. The geese held a stick in their beaks, "
                "and the turtle bit the middle. They warned him not to talk. "
                "As they flew, people laughed seeing the turtle in the sky. "
                "He opened his mouth to reply — and fell to the ground. "
                "Moral: Never talk when it’s not necessary. 🐢✨",
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
