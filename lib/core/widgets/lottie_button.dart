import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieButton extends StatefulWidget {
  final VoidCallback onTap;

  const LottieButton({Key? key, required this.onTap}) : super(key: key);

  @override
  _LottieButtonState createState() => _LottieButtonState();
}

class _LottieButtonState extends State<LottieButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this); // Initialize Lottie Controller
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose to free memory
    super.dispose();
  }

  void _playAnimation() {
    _controller
      ..reset()
      ..forward(); // Play the Lottie animation
    widget.onTap(); // Trigger the tap event
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _playAnimation, // Play animation on tap
      child: RepaintBoundary(
        child: SizedBox(
          height: 150,
          width: 150,
          child: Lottie.asset(
            'assets/lottie/ai_assistant.json',
            controller: _controller, // Attach controller
            onLoaded: (composition) {
              _controller.duration = composition.duration; // Set animation duration
            },
          ),
        ),
      ),
    );
  }
}
