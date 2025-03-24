import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/library%20/domain/entities/resource.dart';

class AuthorType extends StatelessWidget {
  final ResourceType  type;
  final String author;

  const AuthorType({required this.type, required this.author, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(author, style: context.textTheme.labelMedium,)),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
            decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(width: 1, color: Colors.grey))),
            child: Text(type.name.toString() == "article" ? "Article" : "Video", style: context.textTheme.labelMedium?.copyWith(fontSize: 12),), )
      ],
    );
  }
}

