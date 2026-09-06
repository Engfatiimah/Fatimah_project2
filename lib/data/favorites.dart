import '../models/meal.dart';

// Static, non-reactive list — no persistence, no add/remove UI by design.

final List<MealSummary> staticFavorites = [
  const MealSummary(
    id: '52904',
    name: 'Beef Bourguignon',
    thumb: 'https://www.themealdb.com/images/media/meals/vtqxtu1511784197.jpg',
  ),
  const MealSummary(
    id: '52832',
    name: 'Coq au vin',
    thumb: 'https://www.themealdb.com/images/media/meals/qstyvs1505931190.jpg',
  ),
  const MealSummary(
    id: '52903',
    name: 'French Onion Soup',
    thumb: 'https://www.themealdb.com/images/media/meals/xvrrux1511783685.jpg',
  ),
  const MealSummary(
    id: '52909',
    name: 'Tarte Tatin',
    thumb: 'https://www.themealdb.com/images/media/meals/ryspuw1511786688.jpg',
  ),
];

bool isFavorite(String id) => staticFavorites.any((m) => m.id == id);
