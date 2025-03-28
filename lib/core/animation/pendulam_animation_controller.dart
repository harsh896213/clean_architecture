import 'package:flutter/material.dart';
import 'dart:math' as math;

class PendulumAnimationController {
  static final PendulumAnimationController _instance =
      PendulumAnimationController._internal();

  factory PendulumAnimationController() => _instance;

  PendulumAnimationController._internal();

  final Map<String, AnimationController> _controllers = {};
  final Map<String, bool> _isAnimating = {};

  Widget wrapWithPendulum({
    required String itemId,
    required Widget child,
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 1500),
    double maxAngle = 30,
  }) {
    if (!_controllers.containsKey(itemId)) {
      _controllers[itemId] = AnimationController(
        duration: duration,
        vsync: vsync,
      );
      _isAnimating[itemId] = false;
    }

    final animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0, end: maxAngle * (math.pi / 180)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(
            begin: maxAngle * (math.pi / 180),
            end: -maxAngle * (math.pi / 180)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -maxAngle * (math.pi / 180), end: 0),
        weight: 25,
      ),
    ]).animate(CurvedAnimation(
      parent: _controllers[itemId]!,
      curve: Curves.easeInOut,
    ));

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateZ(animation.value),
        alignment: Alignment.topCenter,
        child: child,
      ),
      child: child,
    );
  }

  void startPendulum(String itemId) {
    if (_isAnimating[itemId] == true) return;

    _isAnimating[itemId] = true;
    _controllers[itemId]?.forward().then((_) {
      _controllers[itemId]?.reset();
      _isAnimating[itemId] = false;
    });
  }

  void dispose(String itemId) {
    _controllers[itemId]?.dispose();
    _controllers.remove(itemId);
    _isAnimating.remove(itemId);
  }

  void disposeAll() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _isAnimating.clear();
  }
}
