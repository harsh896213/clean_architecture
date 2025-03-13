import 'dart:collection';

import 'package:flutter/material.dart';

// Step 1: Abstract Button Class
abstract class Button {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;

  Button({this.label, this.icon, this.onPressed});

  void render();
}

// Step 2: Concrete Button Classes for Android
class AndroidTextButton extends Button {
  AndroidTextButton({required String label, required VoidCallback onPressed})
      : super(label: label, onPressed: onPressed);

  @override
  void render() {
    print("Android Text Button: $label Rendered");
    onPressed?.call();
  }
}

class AndroidIconButton extends Button {
  AndroidIconButton({required IconData icon, required VoidCallback onPressed})
      : super(icon: icon, onPressed: onPressed);

  @override
  void render() {
    print("Android Icon Button Rendered");
    onPressed?.call();
  }
}

class AndroidElevatedButton extends Button {
  AndroidElevatedButton({required String label, IconData? icon, required VoidCallback onPressed})
      : super(label: label, icon: icon, onPressed: onPressed);

  @override
  void render() {
    print("Android Elevated Button: $label Rendered");
    onPressed?.call();
  }
}

// Step 3: Concrete Button Classes for iOS
class IOSTextButton extends Button {
  IOSTextButton({required String label, required VoidCallback onPressed})
      : super(label: label, onPressed: onPressed);

  @override
  void render() {
    print("iOS Text Button: $label Rendered");
    onPressed?.call();
  }
}

class IOSIconButton extends Button {
  IOSIconButton({required IconData icon, required VoidCallback onPressed})
      : super(icon: icon, onPressed: onPressed);

  @override
  void render() {
    print("iOS Icon Button Rendered");
    onPressed?.call();
  }
}

class IOSElevatedButton extends Button {
  IOSElevatedButton({required String label, IconData? icon, required VoidCallback onPressed})
      : super(label: label, icon: icon, onPressed: onPressed);

  @override
  void render() {
    print("iOS Elevated Button: $label Rendered");
    onPressed?.call();
  }
}

// Step 4: Abstract Factory for Button Creation
abstract class ButtonFactory {
  Button createTextButton({required String label, required VoidCallback onPressed});
  Button createIconButton({required IconData icon, required VoidCallback onPressed});
  Button createElevatedButton({required String label, IconData? icon, required VoidCallback onPressed});
}

// Step 5: Concrete Factories for Android and iOS
class AndroidButtonFactory implements ButtonFactory {
  @override
  Button createTextButton({required String label, required VoidCallback onPressed}) {
    return AndroidTextButton(label: label, onPressed: onPressed);
  }

  @override
  Button createIconButton({required IconData icon, required VoidCallback onPressed}) {
    return AndroidIconButton(icon: icon, onPressed: onPressed);
  }

  @override
  Button createElevatedButton({required String label, IconData? icon, required VoidCallback onPressed}) {
    return AndroidElevatedButton(label: label, icon: icon, onPressed: onPressed);
  }
}

class IOSButtonFactory implements ButtonFactory {
  @override
  Button createTextButton({required String label, required VoidCallback onPressed}) {
    return IOSTextButton(label: label, onPressed: onPressed);
  }

  @override
  Button createIconButton({required IconData icon, required VoidCallback onPressed}) {
    return IOSIconButton(icon: icon, onPressed: onPressed);
  }

  @override
  Button createElevatedButton({required String label, IconData? icon, required VoidCallback onPressed}) {
    return IOSElevatedButton(label: label, icon: icon, onPressed: onPressed);
  }
}

// Step 6: Factory of Factories
class ButtonFactoryProvider {
  static ButtonFactory getFactory(String platform) {
    switch (platform) {
      case 'android': return AndroidButtonFactory();
      case 'ios': return IOSButtonFactory();
      default: throw Exception('Unsupported platform');
    }
  }
}

// Step 7: Usage Example
void main() {
  String platform = 'android'; // Assume platform detection logic
  ButtonFactory factory = ButtonFactoryProvider.getFactory(platform);

  // Create a Text Button
  Button textButton = factory.createTextButton(
    label: "Click Me",
    onPressed: () => print("Text Button Clicked!"),
  );
  textButton.render(); // Output: Android Text Button: Click Me Rendered
  //          Text Button Clicked!

  // Create an Icon Button
  Button iconButton = factory.createIconButton(
    icon: Icons.favorite,
    onPressed: () => print("Icon Button Clicked!"),
  );
  iconButton.render(); // Output: Android Icon Button Rendered
  //          Icon Button Clicked!

  // Create an Elevated Button
  Button elevatedButton = factory.createElevatedButton(
    label: "Submit",
    icon: Icons.send,
    onPressed: () => print("Elevated Button Clicked!"),
  );
  elevatedButton.render(); // Output: Android Elevated Button: Submit Rendered
  //          Elevated Button Clicked!
}
