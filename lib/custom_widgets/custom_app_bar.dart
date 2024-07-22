import 'package:flutter/material.dart';

import '../color/app_color.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? action;
  final double? leadingWidth;
  final bool centerTitle;
  CustomAppBar({
    this.leading,
    super.key,
    required this.title,
    this.action,
    required this.centerTitle,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      scrolledUnderElevation: 0,
      surfaceTintColor: AppColor.white,
      backgroundColor: AppColor.white,
      actions: action,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColor.green,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      elevation: 0.0,
    );
  }
}
