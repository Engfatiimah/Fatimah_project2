import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_style.dart';

class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppFonts.baloo(
        fontSize: 12,
        color: AppColors.muted,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }
}

class TitleFlourish extends StatelessWidget {
  final double lineWidth;
  final double centerSize;
  final bool centerIsCircle;

  const TitleFlourish({
    super.key,
    this.lineWidth = 120,
    this.centerSize = 10,
    this.centerIsCircle = true,
  });

  @override
  Widget build(BuildContext context) {
    final shape = centerIsCircle
        ? ClipOval(
            child: Container(
              width: centerSize,
              height: centerSize,
              color: AppColors.cherry,
            ),
          )
        : Transform.rotate(
            angle: pi / 4,
            child: Container(
              width: centerSize,
              height: centerSize,
              color: AppColors.cherry,
            ),
          );

    return SizedBox(
      width: lineWidth,
      height: centerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(height: 1, color: AppColors.sand),
          shape,
        ],
      ),
    );
  }
}
