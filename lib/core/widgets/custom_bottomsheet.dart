import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';

Future<void> showDynamicBottomSheet({
  required BuildContext context,
  required Widget child,
  double maxHeightFactor = 0.6, // Maximum height factor (60% of screen height)
  double borderRadius = 20.0,
  bool isScrollControlled = true,
  Color backgroundColor = Colors.white,
}) {
  return  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    constraints: BoxConstraints(
      maxWidth: double.infinity
    ),
    backgroundColor: Colors.transparent,
    builder: (context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = constraints.maxHeight * 0.6;
          return Container(
            constraints: BoxConstraints(
              maxHeight: maxHeight,
            ),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: child,
          );
        },
      );
    },
  );
}
