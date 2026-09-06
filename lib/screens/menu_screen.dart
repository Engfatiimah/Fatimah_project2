import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../services/meal_service.dart';
import '../theme/app_style.dart';
import '../widgets/async_state_views.dart';
import '../widgets/dish_card.dart';
import '../widgets/menu_frame.dart';
import '../widgets/photo_sticker.dart';
import '../widgets/section_label.dart';
import 'dish_screen.dart';
import 'favorites_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<List<Object>> _menuFuture;

  @override
  void initState() {
    super.initState();
    _menuFuture = _loadMenu();
  }

  Future<List<Object>> _loadMenu() {
    return Future.wait([
      MealService.fetchFrenchDishes(),
      MealService.fetchChefPick(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MenuFrame(
            child: FutureBuilder<List<Object>>(
              future: _menuFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: KitchenLoading());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: KitchenError(
                      onRetry: () => setState(() => _menuFuture = _loadMenu()),
                    ),
                  );
                }

                final dishes = snapshot.data![0] as List<MealSummary>;
                final chefPick = snapshot.data![1] as MealDetail;

                return _MenuContent(dishes: dishes, chefPick: chefPick);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuContent extends StatelessWidget {
  final List<MealSummary> dishes;
  final MealDetail chefPick;

  const _MenuContent({required this.dishes, required this.chefPick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'The Menu',
                textAlign: TextAlign.center,
                style: AppFonts.pacifico(fontSize: 48, color: AppColors.cherry),
              ),
              const SizedBox(height: 8),
              const TitleFlourish(lineWidth: 200),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _ChefPickCard(chefPick: chefPick),
        const SizedBox(height: 24),
        const SectionLabel(text: 'Les Plats'),
        const SizedBox(height: 12),
        Expanded(
          child: dishes.isEmpty
              ? Center(
                  child: Text(
                    'No dishes on the menu right now — the kitchen is between courses.',
                    textAlign: TextAlign.center,
                    style: AppFonts.baloo(color: AppColors.muted),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final cardHeight = constraints.maxHeight - 20;
                    return _EdgeFade(
                      child: ClipRect(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 40,
                            top: 10,
                            bottom: 10,
                          ),
                          itemCount: dishes.length,
                          itemBuilder: (context, index) {
                            final dish = dishes[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: DishCard(
                                id: dish.id,
                                name: dish.name,
                                thumb: dish.thumb,
                                height: cardHeight,
                                tilt: index.isEven ? 1 : -1,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => DishScreen(mealId: dish.id),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const FavoritesScreen()));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.sand, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.cherry, size: 26),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'My Favorites',
                      style: AppFonts.baloo(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "the chef's dearest dishes",
                      style: AppFonts.baloo(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: AppColors.sand),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Divider(color: AppColors.cream),
        const SizedBox(height: 8),
        const Center(child: _FooterDots()),
      ],
    );
  }
}

// Softly fades the right edge of a horizontally-scrolling row so a partially
// visible ("peeking") card at the boundary trails off instead of looking
// abruptly sliced by the viewport's clip.
class _EdgeFade extends StatelessWidget {
  final Widget child;

  const _EdgeFade({required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.white, Colors.white, Colors.transparent],
        stops: [0.0, 0.97, 1.0],
      ).createShader(rect),
      child: child,
    );
  }
}

class _ChefPickCard extends StatelessWidget {
  final MealDetail chefPick;

  const _ChefPickCard({required this.chefPick});

  String get _description {
    final tags = chefPick.tags
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .join(', ');
    if (chefPick.category.isEmpty) return tags;
    if (tags.isEmpty) return chefPick.category;
    return '${chefPick.category} · $tags';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhotoSticker(url: chefPick.thumbMedium, size: 100),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cherry,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "CHEF'S PICK",
                        style: AppFonts.baloo(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Transform.translate(
                      offset: const Offset(0, -3),
                      child: Image.asset('assets/mascot/rat_peek.png', width: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  chefPick.name,
                  style: AppFonts.baloo(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (_description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    _description,
                    style: AppFonts.baloo(fontSize: 13, color: AppColors.muted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterDots extends StatelessWidget {
  const _FooterDots();

  Widget _dot(Color color) {
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.chevron_left, color: AppColors.sand),
        _dot(AppColors.cherry),
        _dot(AppColors.sand),
        _dot(AppColors.sand),
        const Icon(Icons.chevron_right, color: AppColors.sand),
      ],
    );
  }
}
