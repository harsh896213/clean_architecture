import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/app_pallete.dart';

class AnimatedProgressIndicator extends StatefulWidget {
  final double progress;
  final Color color;
  final double size;
  final double strokeWidth;
  final String completed;

  const AnimatedProgressIndicator({
    super.key,
    required this.progress,
    required this.completed,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(_animation.value * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.completed,
                  style: context.textTheme.labelMedium
                      ?.copyWith(fontSize: 10, color: AppPallete.secondaryColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}