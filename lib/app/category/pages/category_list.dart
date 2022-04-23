import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/pages/category_edit.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/category_icon.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Categories",
        canGoBack: true,
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (childContext) {
                    return CategoryEdit();
                  }),
                );

                BlocProvider.of<CategoryListCubit>(context).load(null);
              },
              icon: Icon(Icons.add)
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryListCubit, CategoryListState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.customCategories.length,
              itemBuilder: (context, i) {
                CategoryEntity entity = state.customCategories[i];
                return ListTile(
                  leading: CategoryIcon(slug: entity.slug),
                  title: Text(entity.name),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (childContext) {
                        return CategoryEdit(entity: entity);
                      }),
                    );

                    BlocProvider.of<CategoryListCubit>(context).load(null);
                  },
                );
              }
            );
          },
        ),
      ),
    );
  }
}
