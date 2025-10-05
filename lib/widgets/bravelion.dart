import 'package:flutter/material.dart';
class BraveLionPage extends StatelessWidget {
  const BraveLionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bravelion'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("In a dense jungle lived a brave lion named Leo. "
                    "One day, hunters trapped a small deer. "
                    "Leo heard its cry and roared so loud that the hunters ran away in fear. "
                    "The deer was saved, and all animals praised Leo’s courage. 🦁❤️",
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