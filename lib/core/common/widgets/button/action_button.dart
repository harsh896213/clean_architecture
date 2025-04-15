import 'package:flutter/material.dart';
import '../../../widgets/svg_button_container.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final String? svgPath;
  final IconData? icon;
  final Color? iconColor;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double iconSize;

  const ActionButton({
    super.key,
    required this.label,
    this.svgPath,
    this.icon,
    this.iconColor,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.iconSize = 20,
  }) : assert(svgPath != null || icon != null, 'Either svgPath or icon must be provided');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgPath != null)
              SvgButtonContainer(
                padding: 0,
                color: Colors.transparent,
                svgPath: svgPath!,
                size: iconSize,
              )
            else if (icon != null)
              Icon(
                icon,
                color: iconColor ?? textColor,
                size: iconSize,
              ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final String? svgPath;
  final IconData? icon;
  final double iconSize;

  const MessageButton({
    super.key,
    required this.onPressed,
    this.width,
    this.svgPath = 'assets/icons/message.svg',
    this.icon,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final button = ActionButton(
      label: 'Send Message',
      svgPath: icon == null ? svgPath : null,
      icon: icon,
      iconColor: const Color(0xFF4D7BF3),
      backgroundColor: const Color(0xFFF0F4FF),
      textColor: const Color(0xFF4D7BF3),
      onPressed: onPressed,
      iconSize: iconSize,
    );

    if (width != null) {
      return SizedBox(width: width, child: button);
    }

    return button;
  }
}

class CallButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final String? svgPath;
  final IconData? icon;
  final double iconSize;

  const CallButton({
    super.key,
    required this.onPressed,
    this.width,
    this.svgPath = 'assets/icons/call.svg',
    this.icon,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final button = ActionButton(
      label: 'Call',
      svgPath: icon == null ? svgPath : null,
      icon: icon,
      iconColor: const Color(0xFF4D7BF3),
      backgroundColor: const Color(0xFFF0F4FF),
      textColor: const Color(0xFF4D7BF3),
      onPressed: onPressed,
      iconSize: iconSize,
    );

    if (width != null) {
      return SizedBox(width: width, child: button);
    }

    return button;
  }
}