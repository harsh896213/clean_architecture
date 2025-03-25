
import 'package:flutter/material.dart';
import 'package:pva/core/common/widgets/button/button_factory.dart';
import 'package:pva/core/common/widgets/loader/loader.dart';

class IOSButtonFactory implements ButtonFactory {
  @override
  Widget createPrimaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? PlatformLoader.create() : Text(text),
    );
  }

  @override
  Widget createSecondaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return FilledButton.tonal(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? const CircularProgressIndicator() : Text(text),
    );
  }

  @override
  Widget createOutlinedButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? PlatformLoader.create() : Text(text),
    );
  }

  @override
  Widget createTextButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  @override
  Widget createIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required double iconSize,
    Color color = Colors.black,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize, color: color,),
    );
  }
}
