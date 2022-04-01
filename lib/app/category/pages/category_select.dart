import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/common/pages/list_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListCubit, CategoryListState>(
      builder: (context, state) {
        return ListSearchPage<CategoryEntity>(
            title: 'Select Category',
            entities: state.entities,
            filterPredicate: (CategoryEntity element, String query) {
              return element.name.toLowerCase().contains(query);
            },
            itemBuilder: (CategoryEntity entity) {
              return ListTile(
                title: Text(entity.name),
              );
            }
        );
      },
    );;
  }
}
