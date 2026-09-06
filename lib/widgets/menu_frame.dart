import 'package:flutter/material.dart';

import '../theme/app_style.dart';

class MenuFrame extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const MenuFrame({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cherry, width: 1),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.paper,
          border: Border.all(color: AppColors.sand, width: 3),
          borderRadius: BorderRadius.circular(26),
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
