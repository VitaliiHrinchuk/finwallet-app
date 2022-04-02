import 'package:finwallet_app/app/category/utils/category_icon_settings.dart';
import 'package:finwallet_app/app/category/utils/default_categories_list.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {

  final String slug;

  CategoryIcon({
    required this.slug
  });

  @override
  Widget build(BuildContext context) {
    CategoryIconSettings settings = DEFAULT_CATEGORIES_ICONS.containsKey(slug) ? DEFAULT_CATEGORIES_ICONS[slug]! : DEFAULT_CATEGORIES_ICONS['other']!;
    return FittedBox(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Icon(settings.icon, color: Colors.black),
        decoration: BoxDecoration(
            color: Color(0xFFB6E0F9),
            borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }
}
