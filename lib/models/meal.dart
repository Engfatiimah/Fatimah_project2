class MealSummary {
  final String id;
  final String name;
  final String thumb;

  const MealSummary({required this.id, required this.name, required this.thumb});

  factory MealSummary.fromJson(Map<String, dynamic> json) {
    return MealSummary(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      thumb: json['strMealThumb'] as String,
    );
  }

  String get thumbPreview => '$thumb/preview';

  String get thumbMedium => '$thumb/medium';
}

class Ingredient {
  final String name;
  final String measure;

  const Ingredient({required this.name, required this.measure});
}

class MealDetail {
  final String id;
  final String name;
  final String thumb;
  final String instructions;
  final String category;
  final String tags;
  final String youtube;
  final List<Ingredient> ingredients;

  const MealDetail({
    required this.id,
    required this.name,
    required this.thumb,
    required this.instructions,
    required this.category,
    required this.tags,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    final ingredients = <Ingredient>[];
    for (var i = 1; i <= 20; i++) {
      final rawName = json['strIngredient$i'];
      final name = (rawName as String?)?.trim() ?? '';
      if (name.isEmpty) continue;
      final rawMeasure = json['strMeasure$i'];
      final measure = (rawMeasure as String?)?.trim() ?? '';
      ingredients.add(Ingredient(name: name, measure: measure));
    }

    return MealDetail(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      thumb: json['strMealThumb'] as String,
      instructions: json['strInstructions'] as String? ?? '',
      category: json['strCategory'] as String? ?? '',
      tags: json['strTags'] as String? ?? '',
      youtube: json['strYoutube'] as String? ?? '',
      ingredients: ingredients,
    );
  }

  bool get isVegetarian =>
      category.toLowerCase().contains('vegetarian') ||
      tags.toLowerCase().contains('vegetarian');

  String get thumbMedium => '$thumb/medium';

  MealSummary toSummary() => MealSummary(id: id, name: name, thumb: thumb);
}
