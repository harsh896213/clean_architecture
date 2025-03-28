import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';

class CompletedActivityDialog extends StatelessWidget {
  const CompletedActivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.ac_unit, size: 40,),
        Text("Care Plan Completed", style: context.textTheme.headlineLarge,),
        Text("Congratulation", style: context.textTheme.headlineLarge,),

      ],
    );
  }
}
