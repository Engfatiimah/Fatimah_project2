import 'package:flutter/material.dart';

import '../services/meal_service.dart';
import '../theme/app_style.dart';

class LeaderRow extends StatelessWidget {
  final String name;
  final String measure;

  const LeaderRow({super.key, required this.name, required this.measure});

  Widget _fallbackSquare() {
    return Container(width: 24, height: 24, color: AppColors.cream);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              MealService.ingredientImage(name),
              width: 24,
              height: 24,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _fallbackSquare(),
            ),
          ),
          const SizedBox(width: 8),
          Text(name, style: AppFonts.baloo(color: AppColors.muted)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '.' * 60,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: AppFonts.baloo(color: AppColors.sand),
            ),
          ),
          const SizedBox(width: 8),
          Text(measure, style: AppFonts.baloo()),
        ],
      ),
    );
  }
}
