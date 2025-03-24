import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButtonContainer extends StatelessWidget {
  final String svgPath;
  final Color color;
  final double padding;
  final double size;

  const SvgButtonContainer(
      {required this.padding,
      required this.color,
      required this.svgPath,
      required this.size,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: ShapeDecoration(
        color: color,
        shape: CircleBorder(),),
      child: SvgPicture.asset(svgPath, width: size, height: size,),
    );
  }
}
