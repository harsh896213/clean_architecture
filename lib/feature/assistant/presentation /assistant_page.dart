import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AssistantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: Hero(
          tag: "heroTag", // Must match the first screen
          child: RepaintBoundary(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                'assets/lottie/ai_assistant.json', // Your Lottie animation file
                fit: BoxFit.fill,
                repeat: true,
                animate: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
