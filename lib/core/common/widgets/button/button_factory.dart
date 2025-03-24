import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pva/core/common/widgets/button/android_btn.dart';
import 'package:pva/core/common/widgets/button/ios_btn.dart';

abstract class ButtonFactory {
  Widget createPrimaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  });

  Widget createSecondaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  });

  Widget createOutlinedButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  });

  Widget createTextButton({
    required String text,
    required VoidCallback onPressed,
  });

  Widget createIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required double iconSize,
  });

  factory ButtonFactory() {
    if (Platform.isIOS) {
      return IOSButtonFactory();
    } else {
      return AndroidButtonFactory();
    }
  }
}
///use it like
/// ButtonFactory().createIconButton(icon: Icons.add, onPressed:(){})
