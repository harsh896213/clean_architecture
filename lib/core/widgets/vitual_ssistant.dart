import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pva/core/animation/pulse_animation_controller.dart';
import 'package:pva/core/image_path/image_path.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/widgets/svg_button_container.dart';

class VirtualAssistant extends StatefulWidget {
  const VirtualAssistant({super.key});

  @override
  State<VirtualAssistant> createState() => _VirtualAssistantState();
}

class _VirtualAssistantState extends State<VirtualAssistant> with SingleTickerProviderStateMixin {
  var _pulseAnimationController = PulseAnimationController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => onItemTapped(2),
      onTap: () => context.push("/assistant"),
      child: _pulseAnimationController.wrapWithPulse(
        itemId: "virtual_assistant",
        continuous: true,
        vsync: this,
          child: SvgButtonContainer(padding: 12, color: AppPallete.primaryColor, svgPath: ImagePath.virtualAssistant, size: 34)),
    );
  }

  @override
  void dispose() {
    _pulseAnimationController.disposeAll();
    super.dispose();
  }
}
