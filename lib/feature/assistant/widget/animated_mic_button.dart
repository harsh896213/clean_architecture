import 'package:flutter/material.dart';

class AnimatedMicButton extends StatefulWidget {
  final bool isListening;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color circleColor;

  const AnimatedMicButton({
    Key? key,
    required this.isListening,
    required this.onTap,
    this.primaryColor = Colors.blue,
    this.circleColor = Colors.blue,
  }) : super(key: key);

  @override
  State<AnimatedMicButton> createState() => _AnimatedMicButtonState();
}

class _AnimatedMicButtonState extends State<AnimatedMicButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.3)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);

    // Only animate if listening
    if (!widget.isListening) {
      _controller.stop();
    }
  }

  @override
  void didUpdateWidget(AnimatedMicButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Start/stop animation when isListening changes
    if (widget.isListening != oldWidget.isListening) {
      if (widget.isListening) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 0; // Reset to initial state
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Static circles - always visible
            ...List.generate(3, (index) {
              return Container(
                width: 60 + (index * 16),
                height: 60 + (index * 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.circleColor.withOpacity(0.5 - (index * 0.15)),
                    width: 2,
                  ),
                ),
              );
            }),

            // Animated circles - only animate when active
            if (widget.isListening)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: List.generate(3, (index) {
                      final double size = (60 + (index * 16)) * _animation.value;
                      return Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.circleColor.withOpacity(0.5 - (index * 0.15)),
                            width: 2,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),

            // Mic Button
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.primaryColor,
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}