import 'package:flutter/material.dart';

import '../data/favorites.dart';
import '../models/meal.dart';
import '../theme/app_style.dart';
import '../widgets/menu_frame.dart';
import '../widgets/photo_sticker.dart';
import '../widgets/section_label.dart';
import 'dish_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MenuFrame(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.chevron_left,
                    color: AppColors.cherry,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Favorites',
                            textAlign: TextAlign.center,
                            style: AppFonts.pacifico(fontSize: 40, color: AppColors.cherry),
                          ),
                          const SizedBox(width: 10),
                          Transform.translate(
                            offset: const Offset(0, -6),
                            child: Transform.rotate(
                              angle: -0.10,
                              child: Image.asset('assets/mascot/rat_peek.png', width: 46),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const TitleFlourish(lineWidth: 230),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: staticFavorites.length,
                    itemBuilder: (context, index) {
                      final meal = staticFavorites[index];
                      return _FavoriteRow(meal: meal);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FavoriteRow extends StatelessWidget {
  final MealSummary meal;


  const _FavoriteRow({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => DishScreen(mealId: meal.id)),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.sand, width: 1),
          ),
          child: Row(
            children: [
              PhotoSticker(url: meal.thumbPreview, size: 64),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  meal.name,
                  style: AppFonts.baloo(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.sand),
            ],
          ),
        ),
      ),
    );
  }
}
