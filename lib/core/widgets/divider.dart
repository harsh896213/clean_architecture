import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color color;

  const CustomDivider({
    super.key,
    this.height = 1.0,
    this.thickness = 1.0,
    this.indent = 16.0,
    this.endIndent = 16.0,
    this.color = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: height,
        width: thickness,
        color: color,
      ),
    );
  }
}