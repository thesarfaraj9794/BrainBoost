import 'package:flutter/material.dart';

class SafeScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  const SafeScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton, required BottomNavigationBar bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: body), // 👈 Auto SafeArea
      floatingActionButton: floatingActionButton,
    );
  }
}
