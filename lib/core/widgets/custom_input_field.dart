import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final Function(String)? onChanged;
  final VoidCallback? onClear;
  final bool autoFocus;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final BoxDecoration? customDecoration;
  final int minLines;
  final int maxLines;

  const CustomInputField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = 'Type a message...',
    this.onChanged,
    this.onClear,
    this.autoFocus = false,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.height,
    this.textStyle,
    this.contentPadding,
    this.customDecoration,
    this.minLines = 1,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        height: height,
        decoration: customDecoration ?? BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(24),
          color: backgroundColor ?? Colors.grey[100],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: autoFocus,
                style: textStyle ?? context.textTheme.bodyMedium,
                decoration: InputDecoration(
                  filled: false,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: onChanged,
                minLines: minLines,
                maxLines: maxLines,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}