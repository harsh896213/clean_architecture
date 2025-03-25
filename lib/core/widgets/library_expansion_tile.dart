import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/image_path/image_path.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/widgets/svg_button_container.dart';

class LibraryExpansionTile extends StatelessWidget {
  final String title;
  final String detailedDescription;
  final bool isExpanded;
  final Function(bool)? onExpansionChanged;

  const LibraryExpansionTile({
    super.key,
    required this.title,
    required this.detailedDescription,
    required this.isExpanded,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardShadow
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: ValueKey(isExpanded),
          tilePadding: EdgeInsets.symmetric(horizontal: 16),
          maintainState: false,
          initiallyExpanded: isExpanded,
          onExpansionChanged: onExpansionChanged,
          leading: SvgButtonContainer(
              padding: 10,
              color: AppPallete.iconBg,
              svgPath: ImagePath.roundedQuestion,
              size: 24),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: RotationTransition(
            turns: isExpanded ? const AlwaysStoppedAnimation(0.25) : const AlwaysStoppedAnimation(0),
            child: const Icon(Icons.arrow_forward_ios_rounded, size: 20,),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70,right: 16),
              child: Text(detailedDescription,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Color.fromRGBO(102, 102, 102, 1),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
