import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/app_style.dart';
import 'section_label.dart';

class KitchenLoading extends StatelessWidget {
  const KitchenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'La Table',
          style: AppFonts.pacifico(fontSize: 40, color: AppColors.cherry),
        ),
        const SizedBox(height: 8),
        const TitleFlourish(),
        const SizedBox(height: 24),
        LoadingAnimationWidget.horizontalRotatingDots(
          color: AppColors.cherry,
          size: 40,
        ),
        const SizedBox(height: 16),
        Text(
          'the little chef is cooking...',
          style: AppFonts.baloo(fontSize: 13, color: AppColors.muted),
        ),
      ],
    );
  }
}

class KitchenError extends StatelessWidget {
  final VoidCallback onRetry;

  const KitchenError({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'La Table',
          style: AppFonts.pacifico(fontSize: 34, color: AppColors.cherry),
        ),
        const SizedBox(height: 8),
        const TitleFlourish(),
        const SizedBox(height: 16),
        Text(
          "the kitchen hit a snag — let's try that again",
          textAlign: TextAlign.center,
          style: AppFonts.baloo(fontSize: 13, color: AppColors.muted),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cherry,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Try again',
            style: AppFonts.baloo(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
