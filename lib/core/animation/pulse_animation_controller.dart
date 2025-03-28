import 'package:flutter/material.dart';

class PulseAnimationController {
  static final PulseAnimationController _instance = PulseAnimationController._internal();
  factory PulseAnimationController() => _instance;
  PulseAnimationController._internal();

  final Map<String, AnimationController> _controllers = {};

  Widget wrapWithPulse({
    required String itemId,
    required Widget child,
    required TickerProvider vsync,
    bool continuous = false,
    Duration duration = const Duration(milliseconds: 800),
    double maxScale = 1.2,
  }) {
    if (!_controllers.containsKey(itemId)) {
      _controllers[itemId] = AnimationController(
        duration: duration,
        vsync: vsync,
      );
    }

    final animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: maxScale), weight: 1),
      TweenSequenceItem(tween: Tween(begin: maxScale, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controllers[itemId]!,
      curve: Curves.easeInOut,
    ));

    if (continuous) {
      _controllers[itemId]?.repeat();
    }

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.scale(
        scale: animation.value,
        child: child,
      ),
      child: child,
    );
  }

  void startPulse(String itemId) {
    _controllers[itemId]?.forward().then((_) => _controllers[itemId]?.reverse());
  }

  void dispose(String itemId) {
    _controllers[itemId]?.dispose();
    _controllers.remove(itemId);
  }

  void disposeAll() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }
}