import 'package:flutter/material.dart';
import 'package:pva/core/theme/shadow.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function(String)? onChanged;
  final VoidCallback? onClear;
  final bool autoFocus;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? height;
  final double iconSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final BoxDecoration? customDecoration;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
    this.autoFocus = false,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.height = 44,
    this.iconSize = 24,
    this.textStyle,
    this.contentPadding,
    this.customDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: height,
        decoration: customDecoration ?? BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          boxShadow: cardShadow,
          color: backgroundColor ?? Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.search,
                color: iconColor ?? Theme.of(context).hintColor,
                size: iconSize,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                autofocus: autoFocus,
                style: textStyle ?? TextStyle(
                  fontSize: 16,
                  color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                ),
                decoration: InputDecoration(
                  filled: false,
                  hintText: hintText,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: onChanged,
              ),
            ),
            if (controller?.text.isNotEmpty ?? false)
              GestureDetector(
                onTap: () {
                  controller?.clear();
                  onClear?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.clear,
                    color: iconColor ?? Theme.of(context).hintColor,
                    size: iconSize - 4,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}