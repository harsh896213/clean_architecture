import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(8, -2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: ValueKey(isExpanded),
          maintainState: false,
          initiallyExpanded: isExpanded,
          onExpansionChanged: onExpansionChanged,
          leading: Container(
            width: 60,
            height: 60,
            decoration: const ShapeDecoration(
              color: Color(0xFFEEF2F5),
              shape: CircleBorder(),
            ),
            child: const Icon(
              Icons.question_mark_outlined,
              size: 20,
              color: Colors.blue,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: RotationTransition(
            turns: isExpanded ? const AlwaysStoppedAnimation(0.25) : const AlwaysStoppedAnimation(0),
            child: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detailed Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(detailedDescription),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
