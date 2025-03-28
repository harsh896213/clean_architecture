import 'package:flutter/material.dart';
import 'package:pva/core/extension/context_ext.dart';
import 'package:pva/core/theme/app_pallete.dart';
import 'package:pva/core/theme/shadow.dart';
import 'package:pva/core/theme/text_styles.dart';
import 'package:pva/feature/library%20/domain/entities/resource.dart';

class AuthorType extends StatelessWidget {
  final ResourceType type;
  final String author;

  const AuthorType({required this.type, required this.author, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        Text(
          author,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.theme.secondaryHeaderColor,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: ShapeDecoration(
            color: AppPallete.iconBg,
            shadows: cardShadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            type.name.toString() == "article" ? "Article" : "Video",
            style: context.textTheme.labelMedium?.copyWith(
              fontSize: 12,
              color: AppPallete.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
