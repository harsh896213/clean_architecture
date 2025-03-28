import 'package:flutter/material.dart';

class ShakeListController {
  static final ShakeListController _instance = ShakeListController._internal();
  factory ShakeListController() => _instance;
  ShakeListController._internal();

  final Map<String, AnimationController> _controllers = {};

  Widget buildShakeListItem({
    required String itemId,
    required Widget child,
    required TickerProvider vsync,
  }) {
    if (!_controllers.containsKey(itemId)) {
      _controllers[itemId] = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: vsync,
      );
    }

    final animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controllers[itemId]!,
      curve: Curves.easeInOut,
    ));

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(animation.value, 0),
        child: child,
      ),
      child: child,
    );
  }

  void shakeItem(String itemId) {
    _controllers[itemId]?.forward().then((_) => _controllers[itemId]?.reset());
  }

  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }
}