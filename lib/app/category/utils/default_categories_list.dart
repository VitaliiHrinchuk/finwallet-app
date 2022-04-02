import 'package:finwallet_app/app/category/utils/category_icon_settings.dart';
import 'package:flutter/material.dart';

const Map<String, CategoryIconSettings> DEFAULT_CATEGORIES_ICONS = {
  "home_&_utilities": const CategoryIconSettings(icon: Icons.home, color: Colors.green),
  "taxes": const CategoryIconSettings(icon: Icons.paid, color: Colors.orange),
  "loans": const CategoryIconSettings(icon: Icons.credit_score, color: Colors.red),
  "reimbursements": const CategoryIconSettings(icon: Icons.currency_exchange, color: Colors.red),
  "other": const CategoryIconSettings(icon: Icons.menu_outlined, color: Colors.grey),
  "leisure": const CategoryIconSettings(icon: Icons.book, color: Colors.red),
  "food_&_drinks": const CategoryIconSettings(icon: Icons.restaurant, color: Colors.red),
  "education": const CategoryIconSettings(icon: Icons.school, color: Colors.red),
  "clothing_&_footwear": const CategoryIconSettings(icon: Icons.checkroom, color: Colors.red),
  "gifts": const CategoryIconSettings(icon: Icons.celebration, color: Colors.red),
  "salary": const CategoryIconSettings(icon: Icons.credit_card, color: Colors.red),
  "charity": const CategoryIconSettings(icon: Icons.favorite_outline, color: Colors.red),
  "grant": const CategoryIconSettings(icon: Icons.article, color: Colors.red),
  "transport": const CategoryIconSettings(icon: Icons.directions_car, color: Colors.red),
  "health_&_personal_care": const CategoryIconSettings(icon: Icons.health_and_safety, color: Colors.red),
  "sports": const CategoryIconSettings(icon: Icons.sports_basketball, color: Colors.red),
};