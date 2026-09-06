import 'dart:math';

import 'package:flutter/material.dart';

import '../data/favorites.dart';
import '../theme/app_style.dart';
import 'photo_sticker.dart';

class DishCard extends StatelessWidget {
  static const width = 170.0;
  static const _padding = 14.0;
  static const _gap = 8.0;
  static const _nameFontSize = 15.0;
  static const _nameLineHeight = 1.2;
  static const _nameBlockHeight = _nameFontSize * _nameLineHeight * 2;
  static const _heartSize = 17.0;
  static const _photoBorder = 8.0;

  final String id;
  final String name;
  final String thumb;
  final double tilt;
  final double height;
  final VoidCallback onTap;

  const DishCard({
    super.key,
    required this.id,
    required this.name,
    required this.thumb,
    required this.height,
    required this.onTap,
    this.tilt = 0,
  });

  @override
  Widget build(BuildContext context) {
    final favorite = isFavorite(id);
    final heightBudget =
        height - (_padding * 2) - _nameBlockHeight - _heartSize - (_gap * 2) - _photoBorder;
    final widthBudget = width - (_padding * 2) - _photoBorder;
    final photoSize = max(40.0, min(heightBudget, widthBudget));

    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: tilt * pi / 180,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(_padding),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.sand, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Center(
                  child: PhotoSticker(url: '$thumb/medium', size: photoSize),
                ),
              ),
              const SizedBox(height: _gap),
              SizedBox(
                height: _nameBlockHeight,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.baloo(
                    fontSize: _nameFontSize,
                    fontWeight: FontWeight.w700,
                    height: _nameLineHeight,
                  ),
                ),
              ),
              const SizedBox(height: _gap),
              // Display-only indicator — never tappable.
              Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: favorite ? AppColors.cherry : AppColors.sand,
                size: _heartSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
