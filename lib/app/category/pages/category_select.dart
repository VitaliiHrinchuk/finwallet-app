import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/pages/widgets/category_icon.dart';
import 'package:finwallet_app/common/pages/list_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelect extends StatelessWidget {

  final CategoryType type;

  CategorySelect({
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListCubit, CategoryListState>(
      builder: (context, state) {
        return ListSearchPage<CategoryEntity>(
            title: 'Select Category',
            entities: state.entities.where((element) => element.type == type).toList(),
            filterPredicate: (CategoryEntity element, String query) {
              return element.name.toLowerCase().contains(query);
            },
            itemBuilder: (CategoryEntity entity) {
              return ListTile(
                leading: CategoryIcon(slug: entity.slug),
                title: Text(entity.name),
                onTap: () {
                  Navigator.pop(context, entity.id);
                },
              );
            }
        );
      },
    );
  }
}
