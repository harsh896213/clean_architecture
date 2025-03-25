import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final Widget? customTitle;
  final PreferredSizeWidget? appBar;
  final double? toolbarHeight;
  final TextStyle? titleStyle;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.customTitle,
    this.appBar,
    this.toolbarHeight,
    this.titleStyle,
  }) : assert(title != null || customTitle != null || appBar != null,
            'Either title, customTitle or appBar must be provided');

  @override
  Widget build(BuildContext context) {
    if (appBar != null) return appBar!;

    return AppBar(
      title: title,
      centerTitle: centerTitle,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: titleColor ?? Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => appBar?.preferredSize ??
      Size.fromHeight(
        (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0.0),
      );
}