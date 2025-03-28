import 'package:flutter/material.dart';

class ElasticAnimationController {
  static final ElasticAnimationController _instance =
      ElasticAnimationController._internal();

  factory ElasticAnimationController() => _instance;

  ElasticAnimationController._internal();

  final Map<String, AnimationController> _controllers = {};
  final Map<String, bool> _isAnimating = {};

  Widget wrapWithElastic({
    required String itemId,
    required Widget child,
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 1200),
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
        tween: Tween(begin: 1.0, end: 0.85),
        weight: 25.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.85, end: 1.15),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.15, end: 1.0),
        weight: 25.0,
      ),
    ]).animate(CurvedAnimation(
      parent: _controllers[itemId]!,
      curve: Curves.easeInOut,
    ));

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.scale(
        scale: animation.value,
        child: child,
      ),
      child: child,
    );
  }

  void startAnimation(String itemId) {
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
