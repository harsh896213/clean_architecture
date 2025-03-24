import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double padding;

  const IconContainer(
      {required this.icon,
      required this.color,
      required this.padding,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: ShapeDecoration(
          color: color,
          shape: CircleBorder()),
      child: Icon(icon , size: 20, color: Colors.white,),
    );
  }
}
