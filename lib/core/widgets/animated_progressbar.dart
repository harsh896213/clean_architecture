import 'package:flutter/material.dart';

class AnimatedProgressIndicator extends StatefulWidget {
  final double progress;
  final Color color;
  final double size;
  final double strokeWidth;

  const AnimatedProgressIndicator({
    super.key,
    required this.progress,
    this.color = Colors.blue,
    this.size = 100,
    this.strokeWidth = 8,
  });

  @override
  State<AnimatedProgressIndicator> createState() => _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: widget.size,
              width: widget.size,
              child: CircularProgressIndicator(
                value: _animation.value,
                backgroundColor: widget.color.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                strokeWidth: widget.strokeWidth,
              ),
            ),
            Text(
              '${(_animation.value * 100).toInt()}%',
              style: TextStyle(
                fontSize: widget.size * 0.2,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
          ],
        );
      },
    );
  }
}