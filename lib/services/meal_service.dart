import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/meal.dart';

class MealService {
  MealService._();

  static const _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static const chefPickId = '52908';

  static Future<List<MealSummary>> fetchFrenchDishes() async {
    final response = await http.get(Uri.parse('$_baseUrl/filter.php?a=France'));

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load French dishes (status ${response.statusCode})',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final meals = body['meals'] as List<dynamic>?;

    if (meals == null) return [];

    return meals
        .map((meal) => MealSummary.fromJson(meal as Map<String, dynamic>))
        .toList();
  }

  static Future<MealDetail> fetchMealDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$id'));

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load meal detail for id $id (status ${response.statusCode})',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final meals = body['meals'] as List<dynamic>?;

    if (meals == null || meals.isEmpty) {
      throw Exception('No meal found for id $id');
    }

    return MealDetail.fromJson(meals.first as Map<String, dynamic>);
  }

  static Future<MealDetail> fetchChefPick() => fetchMealDetail(chefPickId);

  static String ingredientImage(String name, {bool small = true}) =>
      'https://www.themealdb.com/images/ingredients/$name${small ? '-small' : ''}.png';
}
