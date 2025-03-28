import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final Widget? content;
  final Color? backgroundColor;
  final EdgeInsets contentPadding;
  final bool barrierDismissible;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.content,
    this.backgroundColor,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.barrierDismissible = true,
    this.titleStyle,
    this.messageStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor ?? Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: contentPadding,
      title: Text(
        title,
        style: titleStyle ?? Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: messageStyle ?? Theme.of(context).textTheme.bodyLarge,
          ),
          if (content != null) ...[
            const SizedBox(height: 16),
            content!,
          ],
        ],
      ),
    );
  }
}