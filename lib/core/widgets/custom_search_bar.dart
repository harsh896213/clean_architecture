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
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CustomSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
    this.autoFocus = false,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: cardShadow,
      ),
      child: TextField(
        controller: controller,
        autofocus: autoFocus,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor ?? Theme.of(context).cardColor,
          hintText: hintText,
          prefixIcon: Icon(
            Icons.search,
            color: iconColor ?? Theme.of(context).hintColor,
          ),
          suffixIcon: controller?.text.isNotEmpty ?? false
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: iconColor ?? Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: onChanged,
      ),
    );
  }
}