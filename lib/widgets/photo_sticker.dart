import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_style.dart';

class PhotoSticker extends StatelessWidget {
  final String url;
  final double size;
  final double tilt;
  final String? fallbackUrl;

  const PhotoSticker({
    super.key,
    required this.url,
    required this.size,
    this.tilt = 3,
    this.fallbackUrl,
  });

  Widget _fallbackCircle() {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.cream,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _image() {
    final fallback = fallbackUrl;
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        if (fallback == null) return _fallbackCircle();
        return Image.network(
          fallback,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fallbackCircle(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: tilt * pi / 180,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipOval(child: _image()),
      ),
    );
  }
}
