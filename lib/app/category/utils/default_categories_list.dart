import 'package:finwallet_app/app/category/utils/category_icon_settings.dart';
import 'package:flutter/material.dart';

const Map<String, CategoryIconSettings> DEFAULT_CATEGORIES_ICONS = {
  "home_&_utilities": const CategoryIconSettings(icon: Icons.home, color: Colors.green),
  "taxes": const CategoryIconSettings(icon: Icons.paid, color: Colors.orange),
  "loans": const CategoryIconSettings(icon: Icons.credit_score, color: Colors.red),
  "reimbursements": const CategoryIconSettings(icon: Icons.currency_exchange, color: Colors.green),
  "other": const CategoryIconSettings(icon: Icons.menu_outlined, color: Colors.greenAccent),
  "leisure": const CategoryIconSettings(icon: Icons.book, color: Colors.pink),
  "food_&_drinks": const CategoryIconSettings(icon: Icons.restaurant, color: Colors.green),
  "education": const CategoryIconSettings(icon: Icons.school, color: Colors.blue),
  "clothing_&_footwear": const CategoryIconSettings(icon: Icons.checkroom, color: Colors.amber),
  "gifts": const CategoryIconSettings(icon: Icons.celebration, color: Colors.deepPurpleAccent),
  "salary": const CategoryIconSettings(icon: Icons.credit_card, color: Colors.blueAccent),
  "charity": const CategoryIconSettings(icon: Icons.favorite_outline, color: Colors.cyan),
  "grant": const CategoryIconSettings(icon: Icons.article, color: Colors.yellowAccent),
  "transport": const CategoryIconSettings(icon: Icons.directions_car, color: Colors.deepPurple),
  "health_&_personal_care": const CategoryIconSettings(icon: Icons.health_and_safety, color: Colors.blueAccent),
  "sports": const CategoryIconSettings(icon: Icons.sports_basketball, color: Colors.lightGreen),
};