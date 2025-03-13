import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformLoader extends StatelessWidget {
  const PlatformLoader({super.key});

  factory PlatformLoader.create() {
    if (Platform.isIOS) {
      return const IOSLoader();
    }
    return const AndroidLoader();
  }
}

class AndroidLoader extends PlatformLoader {
  const AndroidLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class IOSLoader extends PlatformLoader {
  const IOSLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
