import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../services/meal_service.dart';
import '../theme/app_style.dart';
import '../widgets/async_state_views.dart';
import '../widgets/leader_row.dart';
import '../widgets/menu_frame.dart';
import '../widgets/photo_sticker.dart';
import '../widgets/section_label.dart';

class DishScreen extends StatefulWidget {
  final String mealId;

  const DishScreen({super.key, required this.mealId});

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  late Future<MealDetail> _dishFuture;

  @override
  void initState() {
    super.initState();
    _dishFuture = MealService.fetchMealDetail(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MenuFrame(
            child: FutureBuilder<MealDetail>(
              future: _dishFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: KitchenLoading());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: KitchenError(
                      onRetry: () => setState(
                        () => _dishFuture = MealService.fetchMealDetail(widget.mealId),
                      ),
                    ),
                  );
                }

                return _DishContent(detail: snapshot.data!);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DishContent extends StatelessWidget {
  final MealDetail detail;

  const _DishContent({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.chevron_left, color: AppColors.cherry),
              Text(
                'back to the menu',
                style: AppFonts.baloo(color: AppColors.cherry),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: PhotoSticker(url: detail.thumbMedium, size: 160),
                ),
                const SizedBox(height: 16),
                Text(
                  detail.name,
                  style: AppFonts.pacifico(fontSize: 28, color: AppColors.cherry),
                ),
                if (detail.isVegetarian) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.cherry,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'VEGETARIAN',
                      style: AppFonts.baloo(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                const SectionLabel(text: 'Ingredients'),
                const SizedBox(height: 8),
                Column(
                  children: [
                    for (final ingredient in detail.ingredients)
                      LeaderRow(
                        name: ingredient.name,
                        measure: ingredient.measure,
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                const SectionLabel(text: 'How To Cook'),
                const SizedBox(height: 8),
                Text(
                  detail.instructions,
                  style: AppFonts.baloo(fontSize: 13.5, height: 1.42),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
